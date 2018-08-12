package com.scit35.saftey.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scit35.saftey.vo.ChatRoom;
import com.scit35.saftey.vo.ChatUsers;

@Repository
public class MemberRepository {
	@Autowired
	SqlSession session;
	/**
	 * 회원 가입
	 * @param ChatUsers
	 * @return int 회원가입여부(0, 1)
	 */
	public int join(ChatUsers chatusers){
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		int result = mapper.insert(chatusers);		
		return result;
	}
	/**
	 * 회원정보 수정
	 * @param ChatUsers
	 * @return int 회원정보 수정여부(0, 1)
	 */
	public int update(ChatUsers chatusers){
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		int result = mapper.update(chatusers);		
		return result;
	}
	/**
	 * 아이디 중복확인, 로그인
	 * @param ChatUsers
	 * @return 조회된 ChatUsers
	 */
	public ChatUsers loginMember(ChatUsers chatusers){
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		ChatUsers c = mapper.loginMember(chatusers);
		return c;
	}
	public int chatEnter(ChatRoom chat) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		int result = mapper.chatEnter(chat);	
		return result;
	}
	public List<ChatRoom> chatList(String roomName) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		List<ChatRoom> cr = mapper.chatList(roomName);	
		return cr;
	}
	public int chatOut(String userId) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		int result = mapper.chatOut(userId);	
		return result;
	}
	
}

/*
@Controller  --view랑 연동
@Repository  --db랑 연동
@Service     --로직작업
@Componentt  --bean이랑 (여러가지 잡다)
<bean> 으로 등록되는것은 위의 4가지 +1 
*/