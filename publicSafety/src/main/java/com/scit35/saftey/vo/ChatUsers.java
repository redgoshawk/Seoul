package com.scit35.saftey.vo;

public class ChatUsers {
	private String userId;
	private String userPassword;
	private String userName;
	private String userEmail;
	private String userGender;
	public ChatUsers() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ChatUsers(String userId, String userPassword, String userName, String userEmail, String userGender) {
		super();
		this.userId = userId;
		this.userPassword = userPassword;
		this.userName = userName;
		this.userEmail = userEmail;
		this.userGender = userGender;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserGender() {
		return userGender;
	}
	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}
	@Override
	public String toString() {
		return "ChatUsers [userId=" + userId + ", userPassword=" + userPassword + ", userName=" + userName
				+ ", userEmail=" + userEmail + ", userGender=" + userGender + "]";
	}

	
}
