package com.mott.po;

import java.io.Serializable;

public class DataTemplate  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int tempId;
	private String sysName;
	private String templateName;
	private String srcConn;
	private String templateSql;
	private String queueName;
	private int status;
	private String description;
	private String createTime;
	private String modifyTime;
	private String statusName;
	private long maxzlID;
	
	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}
	public int getTempId() {
		return tempId;
	}
	public void setTempId(int tempId) {
		this.tempId = tempId;
	}
	
	public int getStatus() {
		return status;
	}
	
	public String getStatusName() {
		
		if(1 == status){
			return "主动推送";
		}else if(2 == status){
			return "执行中";
		}else if(3 == status){
			return "被动请求";
		}else if(9 == status){
			return "公募组合";
		}else{
			return "未知";
		}
	}
	
	public void setStatus(int status) {
		this.status = status;
	}
	
	public long getMaxzlID() {
		return maxzlID;
	}
	public void setMaxzlID(long maxzlID) {
		this.maxzlID = maxzlID;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getSysName() {
		return sysName;
	}
	public void setSysName(String sysName) {
		this.sysName = sysName;
	}
	public String getTemplateName() {
		return templateName;
	}
	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}
	public String getSrcConn() {
		return srcConn;
	}
	public void setSrcConn(String srcConn) {
		this.srcConn = srcConn;
	}
	public String getTemplateSql() {
		return templateSql;
	}
	public void setTemplateSql(String templateSql) {
		this.templateSql = templateSql;
	}
	public String getQueueName() {
		return queueName;
	}
	public void setQueueName(String queueName) {
		this.queueName = queueName;
	}
	
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getModifyTime() {
		return modifyTime;
	}
	public void setModifyTime(String modifyTime) {
		this.modifyTime = modifyTime;
	}
	
}
