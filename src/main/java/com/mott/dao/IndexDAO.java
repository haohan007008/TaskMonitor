package com.mott.dao;


import java.util.List;

import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.mott.po.IndexInfo;

public class IndexDAO {
	
	private final static Logger logger = Logger.getLogger(IndexDAO.class);
	
	@Autowired
	private SqlSessionTemplate  sqlSession ;
	
	public List<IndexInfo> selectALLIndex(){
		return sqlSession.selectList("selectALLIndex");
	}
}
