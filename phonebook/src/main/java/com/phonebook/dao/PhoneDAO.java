package com.phonebook.dao;


import java.util.HashMap;
import java.util.List;

import com.phonebook.vo.PhoneBookVO;

public interface PhoneDAO {

	boolean join(PhoneBookVO jsonData);

	List<PhoneBookVO> AllList();

	PhoneBookVO search(String name);

	int delete(String name);

	boolean update(HashMap<String, String> jsonData);

}
