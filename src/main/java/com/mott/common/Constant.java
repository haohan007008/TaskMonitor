package com.mott.common;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mott.po.TreeNode;

public class Constant {
	public static String NODE_TYPE_CATALOG = "catalog";
	public static String NODE_TYPE_FILE = "file";
	public static String NODE_TYPE_DIR = "dir";
	public static String ROOT_NODE_ID = "0";
	
	public static String LOG_FILE_FREX = "log,txt,out,html,htm";
	
	public static final Map<String,Object> map = new HashMap<String, Object>();
	
	
	
	public static List<TreeNode> getFiles(File dir){
		if(dir == null ){
			TreeNode node = new TreeNode();
			node.setId(System.currentTimeMillis()+"");
			node.setName("目录配置错误");
		}
		List<TreeNode> nodes = new ArrayList<TreeNode>();
		File[] fs = dir.listFiles(new LogFileFilter());
		for (File file : fs) {
			TreeNode node = new TreeNode();
			node.setId(System.currentTimeMillis()+"");
			node.setName(file.getName());
			node.setIsParent(file.isDirectory());
			node.setNodeType(file.isDirectory()?Constant.NODE_TYPE_DIR:Constant.NODE_TYPE_FILE);
			node.setNotes(file.getAbsolutePath());
			nodes.add(node);
		}
		return nodes;
	}
	
	
	
	public static void  main(String[] arg) {
		Constant.getFiles(new File("d:\\"));
	}
	
}
