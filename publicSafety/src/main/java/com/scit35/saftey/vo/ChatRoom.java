package com.scit35.saftey.vo;

import java.util.*;

import org.springframework.web.socket.WebSocketSession;

public class ChatRoom {
	private String roomName;
	private String id;
	private WebSocketSession session;
	private String date;
	private String userId;
	public ChatRoom() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ChatRoom(String roomName, String id, WebSocketSession session, String date, String userId) {
		super();
		this.roomName = roomName;
		this.id = id;
		this.session = session;
		this.date = date;
		this.userId = userId;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public WebSocketSession getSession() {
		return session;
	}
	public void setSession(WebSocketSession session) {
		this.session = session;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	@Override
	public String toString() {
		return "ChatRoom [roomName=" + roomName + ", id=" + id + ", session=" + session + ", date=" + date + ", userId="
				+ userId + "]";
	}
	
	
	

}
