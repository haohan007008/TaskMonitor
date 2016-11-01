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
import com.mott.dao.DSConfDAO;
import com.mott.po.DataSourceConf;

@Controller
public class DataSourceConfController{
	@Autowired
    private DSConfDAO dsDAO;
	
	@RequestMapping(value="/dslist")
    public  String dslist( Map<String,Object> model){
		List<DataSourceConf> dslist = dsDAO.getDataSourceConfList();
		model.put("dslist",dslist);
        return "datapush/conn";
    }
	
	@ResponseBody
	@RequestMapping(value="/datapush/addds", method=RequestMethod.POST,produces = {"text/html;charset=UTF-8"})
    public  String addds(DataSourceConf dsconf){
		Message message = new Message();
		
		if(dsconf.getDsId() <= 0 )
			message.setSuccess(dsDAO.AddDataSourceConf(dsconf)>=0?true:false);
		else 
			message.setSuccess(dsDAO.updateDataSourceConf(dsconf)>=0?true:false);

		return JSON.toJSONString(message);
    }
	
	@ResponseBody
	@RequestMapping(value="/datapush/delds", method=RequestMethod.POST,produces = {"text/html;charset=UTF-8"})
    public  String delds(HttpServletRequest request,  @RequestParam("dsId")int dsId){
		Message message = new Message();
		message.setSuccess(dsDAO.deleteDataSourceConfById(dsId)>=0?true:false);
		System.out.println("dsId："+dsId);
        return JSON.toJSONString(message);
    }
	
	@RequestMapping(value="/datapush/getds")
    public  String getds(@RequestParam("dsId")int dsId,Map<String,Object> model){
		model.put("dsconf",dsDAO.getDataSourceConfById(dsId));
        return "conn_add";
    }
}
