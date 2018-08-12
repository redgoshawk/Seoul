package com.scit35.saftey;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.scit35.saftey.dao.MemberRepository;
import com.scit35.saftey.vo.ChatRoom;

public class EchoHandler extends TextWebSocketHandler {

	@Autowired
	MemberRepository repository;
	int count = 0;
	
	private static final Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	//private Map<String, WebSocketSession> users = new ConcurrentHashMap<>();
	private List<ChatRoom> RoomList = new ArrayList<>();
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		//users.put(session.getId(), session);
		logger.info("{} 연결됨", session.getId());
		// System.out.println("채팅방 입장자 :"+session.getPrincipal().getName());

	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// TODO Auto-generated method stub
		logger.info("{}로부터 {}받음", session.getId(), message.getPayload());
		String roomNum=  null;
		String talker = session.getId();
		String talkerRoom = null;
		String userId = null;
		// 채팅 시간 저장
		Date chatDate = new Date();
		SimpleDateFormat datetype = new SimpleDateFormat("yyyy/MM/dd");
		SimpleDateFormat time = new SimpleDateFormat("hh/mm/ss a");
		String date = datetype.format(chatDate);
		date += time.format(chatDate);
		System.out.println(message.getPayload().indexOf("***"));
		if (message.getPayload().indexOf("***")!=-1) {
			System.out.println("채팅신청");
			int index = 0;
			userId = message.getPayload().substring(index+3);
			for (ChatRoom chat : RoomList) {
				if (userId.equals(chat.getUserId())) {
					System.out.println(chat.toString());
					chat.getSession().sendMessage(new TextMessage(session.getId()+"|"+message.getPayload()));
				}
			}
		}
		
		//채팅룸 만들기
		for (ChatRoom chat : RoomList) {
			if (chat.getId().equals(talker)) {
				talkerRoom = chat.getRoomName();
			}
		}
		int index = 0;
		try {
			if(message.getPayload().indexOf(":::")!=-1) {
			index = message.getPayload().indexOf(":::");
			roomNum = message.getPayload().split(":::")[0];
			userId = message.getPayload().substring(index+3);
			}
			
			System.out.println(roomNum);
			System.out.println(userId);
			
		} catch (Exception e) {
			roomNum = null;
		}

		if (roomNum != null) {
			
			if(userId.equals("")||userId.equals(null)) userId = String.valueOf(count++); 
			ChatRoom chat = new ChatRoom(roomNum, session.getId(), session, date, userId);
			RoomList.add(chat);
			int result = repository.chatEnter(chat);
			System.out.println("입장한 얘들"+chat.toString());
		}
		
		if (talkerRoom != null)
			for (ChatRoom chat : RoomList) {
				if (talkerRoom.equals(chat.getRoomName())) {
					System.out.println(chat.toString());
					chat.getSession().sendMessage(new TextMessage(chat.getUserId()+"|"+message.getPayload()+"|"+date));
				}
			}

		logger.info("{}로부터 {}받음", session.getId(), message.getPayload());
		System.out.println("여기서 메시지가 나감");
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		//users.remove(session.getId());
		int s= 0;
		String userId=null;
		for (int i =0; i<RoomList.size(); i++) {
			if (RoomList.get(i).getId().equals(session.getId())) {
				s = i; 
				userId = RoomList.get(i).getUserId();
				break;
			}
		}
		System.out.println("outuserid"+userId);
		RoomList.remove(s);
		repository.chatOut(userId);
		
		
		logger.info("{} 연결끊김", session.getId());
		// System.out.println("채팅방 퇴장자 :"+session.getPrincipal().getName());
	}

}
