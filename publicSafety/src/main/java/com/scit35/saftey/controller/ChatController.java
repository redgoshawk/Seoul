package com.scit35.saftey.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.scit35.saftey.dao.MemberRepository;
import com.scit35.saftey.vo.ChatRoom;
import com.scit35.saftey.vo.ChatUsers;


@Controller
public class ChatController {
	
	@Autowired
	MemberRepository repository;
	
	@RequestMapping(value = "/chat", method = RequestMethod.GET)
	public String chat() {
		return "chat";
	}
	
	@RequestMapping(value="/chatList", method=RequestMethod.POST)
	public @ResponseBody List<ChatRoom> schoolData(String roomName) {
		System.out.println("roomName"+roomName);
		List<ChatRoom> cr = repository.chatList(roomName);
		System.out.println(cr.toString());
		return cr;
	}
	
	@RequestMapping(value = "/chatOne", method = RequestMethod.GET)
	public String echo(String roomnum, Model model, String userId, int roomNum) {
		System.out.println(userId);
		System.out.println(roomNum);
		model.addAttribute("userId", userId);
		model.addAttribute("roomNum", roomNum);
		return "chatOne";
	}
	
}
