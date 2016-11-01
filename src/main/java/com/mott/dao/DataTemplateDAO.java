package com.mott.dao;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import sun.tools.tree.ThisExpression;

import com.mott.po.DataSourceConf;
import com.mott.po.DataTemplate;


public class DataTemplateDAO extends CommDAO{
	
	public int addDataTemplate(DataTemplate dataTemplate){
		StringBuffer sb = new StringBuffer();
		sb.append("insert into pubconfig.t_das_data_template "
				+ "(id,system,name,source,query,queue,status,max_zlid,description,create_time)values(");
		
		sb.append(this.getDataValue("select max(id)+1 from pubconfig.t_das_data_template") +",");
		sb.append("'"+dataTemplate.getSysName() +"',");
		sb.append("'"+dataTemplate.getTemplateName() +"',");
		sb.append("'"+dataTemplate.getSrcConn() +"',");
		sb.append("'"+dataTemplate.getTemplateSql() +"',");
		sb.append("'"+dataTemplate.getQueueName() +"',");
		sb.append(dataTemplate.getStatus() +",");
		sb.append(dataTemplate.getMaxzlID()+",");
		sb.append("'"+dataTemplate.getDescription()+"',");
		sb.append("sysdate" );
		sb.append(")");
		System.out.println(sb.toString());
		
		return this.executeUpdate(sb.toString());
	}
	
	public int updateDataTemplate(DataTemplate dataTemplate){
		StringBuffer sb = new StringBuffer();
		sb.append("update pubconfig.t_das_data_template set ");
		sb.append("system ='"+dataTemplate.getSysName() +"',");
		sb.append("name ='"+dataTemplate.getTemplateName() +"',");
		sb.append("source='"+dataTemplate.getSrcConn() +"',");
		sb.append("query ='"+dataTemplate.getTemplateSql() +"',");
		sb.append("queue='"+dataTemplate.getQueueName() +"',");
		sb.append("status="+dataTemplate.getStatus() +"',");
		sb.append("max_zlid="+dataTemplate.getMaxzlID() +",");
		sb.append("description='"+dataTemplate.getDescription() +"',");
		sb.append("modify_time=sysdate" );
		sb.append(" where id=" + dataTemplate.getTempId());
		System.out.println(sb.toString());
		
		return this.executeUpdate(sb.toString());
	}
	
	public int deleteDataSourceConfById(int tempId){
		StringBuffer sb = new StringBuffer();
		
		sb.append("delete pubconfig.t_das_data_template where id =" + tempId);
		
		return this.executeUpdate(sb.toString());
	}
	
	public DataTemplate getDataTemplateById(int tempId) {
		StringBuffer sb = new StringBuffer();
		sb.append("select * from pubconfig.t_das_data_template where id =" + tempId);
		List<Hashtable<String, Object>> list = 	this.executeQuery(sb.toString());
		
		DataTemplate template = new DataTemplate();
		if(list != null && list.size() > 0){
			Hashtable<String, Object> hst = list.get(0);
			
			template.setTempId(Integer.parseInt(hst.get("ID").toString()));
			template.setSysName(hst.get("SYSTEM").toString());
			template.setTemplateName(hst.get("NAME").toString());
			template.setSrcConn(hst.get("SOURCE").toString());
			template.setQueueName(hst.get("QUEUE").toString());
			template.setDescription(hst.get("DESCRIPTION").toString());
			template.setStatus(Integer.parseInt(hst.get("STATUS").toString()));
			template.setTemplateSql(hst.get("QUERY").toString());
			template.setMaxzlID(Long.parseLong(hst.get("MAX_ZLID").toString()));
			template.setCreateTime(hst.get("CREATE_TIME").toString());
		}
		return template;
	}
	
	/**
	 * getDataSourceConfList
	 *
	 * @return 创建时间：2016年10月31日 上午10:16:20
	 */
	public List<DataTemplate> getDataTemplateList(){
		List<DataTemplate> ls = new ArrayList<DataTemplate>();
		List<Hashtable<String, Object>> list = 
				this.executeQuery("select * from pubconfig.t_das_data_template");
		for (int i = 0; i < list.size(); i++) {
			Hashtable<String, Object> hst = list.get(i);
			DataTemplate template = new DataTemplate();
			template.setTempId(Integer.parseInt(hst.get("ID").toString()));
			template.setSysName(hst.get("SYSTEM").toString());
			template.setTemplateName(hst.get("NAME").toString());
			template.setSrcConn(hst.get("SOURCE").toString());
			template.setQueueName(hst.get("QUEUE").toString());
			template.setDescription(hst.get("DESCRIPTION").toString());
			template.setStatus(Integer.parseInt(hst.get("STATUS").toString()));
			template.setTemplateSql(hst.get("QUERY").toString());
			template.setMaxzlID(Long.parseLong(hst.get("MAX_ZLID").toString()));
			template.setCreateTime(hst.get("CREATE_TIME").toString());
			ls.add(template);
		}
		return ls;
	}
	
	public static void main(String[] args) {
		DataTemplateDAO dao = new DataTemplateDAO();
		
		List<DataTemplate> list = dao.getDataTemplateList();
		System.out.println(list.size());
	}

}
