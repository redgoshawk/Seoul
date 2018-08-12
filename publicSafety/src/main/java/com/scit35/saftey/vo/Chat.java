package com.scit35.saftey.vo;

public class Chat {
	private String chatId;
	private String fromId;
	private String toId;
	private String chatContent;
	private String chatDate;
	public Chat() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Chat(String chatId, String fromId, String toId, String chatContent, String chatDate) {
		super();
		this.chatId = chatId;
		this.fromId = fromId;
		this.toId = toId;
		this.chatContent = chatContent;
		this.chatDate = chatDate;
	}
	public String getChatId() {
		return chatId;
	}
	public void setChatId(String chatId) {
		this.chatId = chatId;
	}
	public String getFromId() {
		return fromId;
	}
	public void setFromId(String fromId) {
		this.fromId = fromId;
	}
	public String getToId() {
		return toId;
	}
	public void setToId(String toId) {
		this.toId = toId;
	}
	public String getChatContent() {
		return chatContent;
	}
	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}
	public String getChatDate() {
		return chatDate;
	}
	public void setChatDate(String chatDate) {
		this.chatDate = chatDate;
	}
	@Override
	public String toString() {
		return "Chat [chatId=" + chatId + ", fromId=" + fromId + ", toId=" + toId + ", chatContent=" + chatContent
				+ ", chatDate=" + chatDate + "]";
	}
	
	
}
