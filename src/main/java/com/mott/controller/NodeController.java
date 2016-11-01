package com.mott.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.alibaba.fastjson.JSON;
import com.mott.common.Constant;
import com.mott.po.TreeNode;
import com.mott.service.TreeNodeService;

@Controller
public class NodeController {
	
	@Autowired
    private TreeNodeService treeNodeService;
	@ResponseBody
	@RequestMapping(value="/node",produces = {"text/html;charset=UTF-8"})
    public  String getnodes( HttpServletRequest request){
		   String pid = request.getParameter("pid");
		   if("".equals(pid) || pid == null ) pid = "0"; 
		   
		   List<TreeNode> ls = treeNodeService.getNodes(pid);
           System.out.println(JSON.toJSONString(ls));
           return JSON.toJSONString(ls);
    }
	
	
	@ResponseBody
	@RequestMapping(value="/logs",produces = {"text/html;charset=UTF-8"})
    public  String getlognodes( HttpServletRequest request){
		   String pid = request.getParameter("pid");
		   String nodetype = request.getParameter("nt");
		   String path = request.getParameter("pt");
		  
		   if("".equals(pid) || pid == null ) pid = Constant.ROOT_NODE_ID; 
		   List<TreeNode> ls = null ;
		   
		   if(Constant.NODE_TYPE_CATALOG.equals(nodetype) 
				   || Constant.ROOT_NODE_ID.equals(pid))
			   ls = treeNodeService.getLogNodes(pid);
		   else if(Constant.NODE_TYPE_DIR.equals(nodetype))
			   ls = Constant.getFiles(new File(path));
		   
           System.out.println(JSON.toJSONString(ls));
           return JSON.toJSONString(ls);
    }
	
	@RequestMapping(value="/meta")
    public  String meta( HttpServletRequest request){
           return "product-category";
    }
}	
