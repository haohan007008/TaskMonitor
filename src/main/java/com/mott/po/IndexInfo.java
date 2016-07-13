package com.mott.po;

public class IndexInfo {
	private String jyrq;  //交易日期
	private String zqdm;  //指数代码
	private String zqmc;  //指数名称
	private String xldm;
	private String xlmc;
	
	
	
	
	public String getXldm() {
		return xldm;
	}
	public void setXldm(String xldm) {
		this.xldm = xldm;
	}
	public String getXlmc() {
		return xlmc;
	}
	public void setXlmc(String xlmc) {
		this.xlmc = xlmc;
	}
	public String getZqmc() {
		return zqmc;
	}
	public void setZqmc(String zqmc) {
		this.zqmc = zqmc;
	}
	private double hb;    //当日回报
	
	public String getJyrq() {
		return jyrq;
	}
	public void setJyrq(String jyrq) {
		this.jyrq = jyrq;
	}
	public String getZqdm() {
		return zqdm;
	}
	public void setZqdm(String zqdm) {
		this.zqdm = zqdm;
	}
	public double getHb() {
		return hb;
	}
	public void setHb(double hb) {
		this.hb = hb;
	}
	
}
