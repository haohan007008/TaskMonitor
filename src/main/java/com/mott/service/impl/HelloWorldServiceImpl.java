package com.mott.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mott.dao.IndexDAO;
import com.mott.po.IndexInfo;
import com.mott.service.HelloWorldService;

@Service
public class HelloWorldServiceImpl implements HelloWorldService {
	@Autowired
	private IndexDAO indexDAO;
	
	@Override
	public String getNewName(String userName) {
		List<IndexInfo> list = indexDAO.selectALLIndex();
		
		return "hello spring!"+userName +":"+ list.size();
	}
	
}
