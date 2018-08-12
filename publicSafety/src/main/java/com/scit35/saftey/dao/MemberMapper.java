package com.scit35.saftey.dao;
import java.util.List;

import com.scit35.saftey.vo.ChatRoom;
import com.scit35.saftey.vo.ChatUsers;

/**
 * 회원관련 Interface
 */
public interface MemberMapper {
	/**
	 * 회원 가입
	 * @param member
	 * @return
	 */
	public int insert(ChatUsers chatusers);
	
	/**
	 * 회원 정보 수정
	 * @param member
	 * @return
	 */
	public int update(ChatUsers chatusers);
	/**
	 * 로그인, 
	 * @param member
	 * @return
	 */
	public ChatUsers loginMember(ChatUsers chatusers);

	public int chatEnter(ChatRoom chat);

	public List<ChatRoom> chatList(String roomName);

	public int chatOut(String userId);
}
