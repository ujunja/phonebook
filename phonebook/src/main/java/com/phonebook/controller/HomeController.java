package com.phonebook.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.phonebook.service.PhoneBookService;

@Controller
public class HomeController {

	@Autowired PhoneBookService pbs;
	
	@RequestMapping("/")
	public ModelAndView home() {
		ModelAndView mav = new ModelAndView("home");		
		mav.addObject("list", (new Gson()).toJson(pbs.AllList()));
		
		return mav;
	}

	
}
