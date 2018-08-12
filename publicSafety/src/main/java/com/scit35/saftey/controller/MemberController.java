package com.scit35.saftey.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.scit35.saftey.dao.MemberRepository;
import com.scit35.saftey.vo.ChatUsers;

@Controller
public class MemberController {

	@Autowired
	MemberRepository repository;
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join() {

		return "join";
	}
	
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(ChatUsers chatusers, HttpSession session, RedirectAttributes rttr) {
		System.out.println("여긴 조인 버튼...");
		System.out.println(chatusers.toString());
		int result = repository.join(chatusers);
		if(result==1) {
			rttr.addAttribute("result", result);
		}
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping(value="/userCheck", method=RequestMethod.POST)
	public String userCheck(@RequestBody ChatUsers chatusers) {
		System.out.println("아이디 체크");
		System.out.println(chatusers.toString());
		ChatUsers c = repository.loginMember(chatusers);
		String result = "0";
		if(c==null) {
			 result = "1";
		}
		return result;
	}
	
	   @RequestMapping(value="/login", method=RequestMethod.GET)
	   public String login() {
		   return "login";
	   }
	   
	   @RequestMapping(value="/login", method=RequestMethod.POST)
	   public String login(ChatUsers chatusers, HttpSession session, Model model,  RedirectAttributes rttr) {
		   logger.info(chatusers.toString());
		   
		   //DB에서 확인 
		   ChatUsers c = repository.loginMember(chatusers);
		   
		   if(c!=null) {
			   session.setAttribute("loginId", c.getUserId());
			   session.setAttribute("loginName", c.getUserName());
			   rttr.addAttribute("login", "로그인에 성공했습니다.");
			   return "redirect:/";
		   } else {
			   model.addAttribute("result", "해당 아이디나 비밀번호가 존재하지 않습니다.");
			   return "login";
		   }
	   }
	
	   @RequestMapping(value="/logout", method=RequestMethod.GET)
	   public String logout(HttpSession session) {
		   session.invalidate(); // 한반에 다 지울때
	 	   
		   //session.removeAttribute("loginId");  여러개 중에 골라서 지울때 
		   return "redirect:/";
	   }
}
