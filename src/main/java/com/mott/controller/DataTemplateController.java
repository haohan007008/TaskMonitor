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
import com.mott.dao.DataTemplateDAO;
import com.mott.po.DataSourceConf;
import com.mott.po.DataTemplate;

@Controller
public class DataTemplateController{
	@Autowired
    private DataTemplateDAO dtDAO;
	@Autowired
	private DSConfDAO dsDAO;
	
	@RequestMapping(value="/templatelist")
    public  String dslist( Map<String,Object> model){
		List<DataTemplate> dslist = dtDAO.getDataTemplateList();
		model.put("templatelist",dslist);
        return "datapush/template";
    }
	
	@ResponseBody
	@RequestMapping(value="/datapush/addtemplate",produces = {"text/html;charset=UTF-8"})
    public  String addds(HttpServletRequest request){
		Message message = new Message();
		DataTemplate template = new DataTemplate();
		if(request.getParameter("tempId") != null && !"".equals(request.getParameter("tempId")))
			template.setTempId(Integer.parseInt(request.getParameter("tempId")));
		template.setSysName(request.getParameter("sysName"));
		template.setTemplateName(request.getParameter("templateName"));
		template.setSrcConn(request.getParameter("srcConn"));
		template.setQueueName(request.getParameter("queueName"));
		template.setDescription(request.getParameter("description"));
		template.setStatus(Integer.parseInt(request.getParameter("status")));
		template.setTemplateSql(request.getParameter("templateSql"));
		
		if(request.getParameter("maxzlId") != null && !"".equals(request.getParameter("maxzlId")))
			template.setMaxzlID(Long.parseLong(request.getParameter("maxzlId")));
		//template.setMaxzlID(Long.parseLong(request.getParameter("maxzlId")));
		//template.setCreateTime(hst.get("CREATE_TIME").toString());
		
		if(template.getTemplateSql().contains("%") 
				|| template.getTemplateSql().contains("_")
				|| template.getTemplateSql().contains("'")){ 
			template.setTemplateSql(template.getTemplateSql() 
					.replaceAll("\\%", "\\\\%")
					.replaceAll("'", "''")
					);
		}
		
		if(template.getTempId() <= 0 )
			message.setSuccess(dtDAO.addDataTemplate(template)>=0?true:false);
		else 
			message.setSuccess(dtDAO.updateDataTemplate(template)>=0?true:false);

		return JSON.toJSONString(message);
    }
	
	@ResponseBody
	@RequestMapping(value="/datapush/deltemplate", method=RequestMethod.POST,produces = {"text/html;charset=UTF-8"})
    public  String delds(HttpServletRequest request,  @RequestParam("dtId")int dtId){
		Message message = new Message();
		message.setSuccess(dtDAO.deleteDataSourceConfById(dtId)>=0?true:false);
		System.out.println( "dtId：" + dtId );
        return JSON.toJSONString(message);
    }
	
	@RequestMapping(value="/datapush/gettemplatebyid")
    public  String getds(@RequestParam("dtId")int dtId,Map<String,Object> model){
		model.put("template",dtDAO.getDataTemplateById(dtId));
		List<DataSourceConf> dslist = dsDAO.getDataSourceConfList();
		model.put("dslist",dslist);
        return "template_add";
    }
	
	@RequestMapping(value="/datapush/newtemplate")
    public  String newtemplate(Map<String,Object> model){
		List<DataSourceConf> dslist = dsDAO.getDataSourceConfList();
		model.put("dslist",dslist);
        return "template_add";
    }
}
