package com.mott.service.impl;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mott.dao.CommDAO;
import com.mott.po.TreeNode;
import com.mott.service.TreeNodeService;

@Service
public class TreeNodeServiceImpl implements TreeNodeService {
	
	@Autowired
	private CommDAO commDAO;
	
	public List<TreeNode> getNodes(String pid) {
		List<TreeNode> ls = new ArrayList<TreeNode>();
		
		System.out.println("SELECT * FROM md_node where parent_nodeid = "+pid+" order by ord_index");
		List<Hashtable<String, Object>> list = 
				commDAO.executeQuery("SELECT * FROM md_node where parent_nodeid = "+pid+" order by ord_index");
		for (int i = 0; i < list.size(); i++) {
			Hashtable<String, Object> hst = list.get(i);
			TreeNode node = new TreeNode();
			node.setId(hst.get("NODE_ID").toString());
			node.setName(hst.get("NODE_NAME").toString());
			node.setNodeType(hst.get("NODE_TYPE").toString());
			if("table".equals(hst.get("NODE_TYPE").toString()))
				node.setIsParent(false);
			else node.setIsParent(true);
			
			node.setChecked(false);
			ls.add(node);
		}
		return ls;
	}
	public List<TreeNode> getLogNodes(String pid) {
		List<TreeNode> ls = new ArrayList<TreeNode>();
		
		System.out.println("SELECT * FROM mn_logs where parent_nodeid = "+pid+" order by ord_index");
		List<Hashtable<String, Object>> list = 
				commDAO.executeQuery("SELECT * FROM mn_logs where parent_nodeid = "+pid+" order by ord_index");
		for (int i = 0; i < list.size(); i++) {
			Hashtable<String, Object> hst = list.get(i);
			TreeNode node = new TreeNode();
			node.setId(hst.get("NODE_ID").toString());
			node.setName(hst.get("NODE_NAME").toString());
			node.setNotes(hst.get("NOTES").toString());
			node.setNodeType(hst.get("NODE_TYPE").toString());
			if("file".equals(hst.get("NODE_TYPE").toString()))
				node.setIsParent(false);
			else node.setIsParent(true);
			
			
			node.setChecked(false);
			ls.add(node);
		}
		return ls;
	}
}
