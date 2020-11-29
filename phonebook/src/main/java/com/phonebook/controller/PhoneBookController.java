package com.phonebook.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.phonebook.service.PhoneBookService;
import com.phonebook.vo.PhoneBookVO;

@RestController
public class PhoneBookController {
	
	@Autowired PhoneBookService pbs;
	
	@RequestMapping(value = "Ajax/", method = RequestMethod.POST)
	public String join(@RequestBody PhoneBookVO jsonData) {
		
		boolean joinresult = pbs.join(jsonData);
		System.out.println("joinresult : " + joinresult);
		if(joinresult == false)
			return "false";
		Gson gson = new Gson();

		return gson.toJson(pbs.AllList());
	}

	@RequestMapping(value = "Ajax/{name}", produces="application/text;charset=utf8")
	public String search(@PathVariable("name")String name) {
				
		PhoneBookVO vo = pbs.search(name);
		String jsonString = null;
		ObjectMapper jsonMapper = new ObjectMapper();
		
		try {
			jsonString = jsonMapper.writeValueAsString(vo);
		} catch (JsonProcessingException e) {
			System.out.println("JSON에서 문제가 발생했소!!");
		}
		
		return vo != null ? jsonString : null;
	}

	@RequestMapping(value = "Ajax/", produces="application/text;charset=utf8", method = RequestMethod.PUT)
	public String update(@RequestBody HashMap<String, String> jsonData) {
		boolean updateresult = pbs.update(jsonData);
		if(updateresult == false)
			return "false";
		Gson gson = new Gson();

		return gson.toJson(pbs.AllList());
	}
	
	@RequestMapping(value = "Ajax/{name}", method = RequestMethod.DELETE)
	public String delete(@PathVariable("name")String name) {	// boolean 반환할 때에는 produce를 쓰지 맙시다
		int deleteresult = pbs.delete(name);
		if (deleteresult != 1)
			return "false";
		Gson gson = new Gson();
		
		return  gson.toJson(pbs.AllList());
	}

}
