package com.mott.po;

import java.io.Serializable;

public class DataSourceConf  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int dsId;
	private String dsName;
	private String version;
	private String driverClaz;
	private String jdbcUrl;
	private String userName;
	private String passwd;
	private int poolInitSize;
	private int poolMaxSize;
	private String createTime;
	
	public int getDsId() {
		return dsId;
	}
	public void setDsId(int dsId) {
		this.dsId = dsId;
	}
	public String getDsName() {
		return dsName;
	}
	public void setDsName(String dsName) {
		this.dsName = dsName;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getDriverClaz() {
		return driverClaz;
	}
	public void setDriverClaz(String driverClaz) {
		this.driverClaz = driverClaz;
	}
	public String getJdbcUrl() {
		return jdbcUrl;
	}
	public void setJdbcUrl(String jdbcUrl) {
		this.jdbcUrl = jdbcUrl;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public int getPoolInitSize() {
		return poolInitSize;
	}
	public void setPoolInitSize(int poolInitSize) {
		this.poolInitSize = poolInitSize;
	}
	public int getPoolMaxSize() {
		return poolMaxSize;
	}
	public void setPoolMaxSize(int poolMaxSize) {
		this.poolMaxSize = poolMaxSize;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	
}
