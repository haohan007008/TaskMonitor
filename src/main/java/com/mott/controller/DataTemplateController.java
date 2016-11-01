package com.mott.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.mott.common.Message;
import com.mott.dao.DataTemplateDAO;
import com.mott.po.DataTemplate;

@Controller
public class DataTemplateController{
	@Autowired
    private DataTemplateDAO dtDAO;
	
	@RequestMapping(value="/templatelist")
    public  String dslist( Map<String,Object> model){
		List<DataTemplate> dslist = dtDAO.getDataTemplateList();
		model.put("templatelist",dslist);
        return "datapush/template";
    }
	
	@ResponseBody
	@RequestMapping(value="/datapush/addtemplate", method=RequestMethod.POST,produces = {"text/html;charset=UTF-8"})
    public  String addds(DataTemplate dsconf){
		Message message = new Message();
		
		if(dsconf.getTempId() <= 0 )
			message.setSuccess(dtDAO.addDataTemplate(dsconf)>=0?true:false);
		else 
			message.setSuccess(dtDAO.updateDataTemplate(dsconf)>=0?true:false);

		return JSON.toJSONString(message);
    }
	
	@ResponseBody
	@RequestMapping(value="/datapush/deltemplate", method=RequestMethod.POST,produces = {"text/html;charset=UTF-8"})
    public  String delds(HttpServletRequest request,  @RequestParam("dsId")int dsId){
		Message message = new Message();
		message.setSuccess(dtDAO.deleteDataSourceConfById(dsId)>=0?true:false);
		System.out.println("dsId："+dsId);
        return JSON.toJSONString(message);
    }
	
	@RequestMapping(value="/datapush/gettemplatebyid")
    public  String getds(@RequestParam("dsId")int dsId,Map<String,Object> model){
		model.put("dsconf",dtDAO.getDataTemplateById(dsId));
        return "conn_add";
    }
}
