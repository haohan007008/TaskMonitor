package com.mott.service;

import java.util.List;

import com.mott.po.TreeNode;


public interface TreeNodeService {
	public List<TreeNode> getNodes(String pid) ;
	
	public List<TreeNode> getLogNodes(String pid);
}
