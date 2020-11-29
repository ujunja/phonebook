package com.phonebook.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.phonebook.dao.PhoneDAO;
import com.phonebook.vo.PhoneBookVO;

@Service
public class PhoneBookService {
	
	@Autowired PhoneDAO dao;

	public boolean join(PhoneBookVO jsonData) {	
		return dao.join(jsonData);
	}

	public List<PhoneBookVO> AllList() {
		return dao.AllList();
	}

	public PhoneBookVO search(String name) {
		return dao.search(name);
	}

	public int delete(String name) {
		return dao.delete(name);
	}

	public boolean update(HashMap<String, String> jsonData) {
		return dao.update(jsonData);
	}
	
	
}
