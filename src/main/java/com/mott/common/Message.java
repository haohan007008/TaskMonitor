package com.mott.common;

import java.util.ArrayList;
import java.util.List;


public class Message {
	private boolean success = true;
	private String desc;
	private List<Object> data = new ArrayList<Object>();
	
	public void setObject(Object dt) {
		data.add(dt);
	}
	
	public List<Object> getData() {
		return data;
	}
	public void setData(List<Object> data) {
		this.data = data;
	}
	public boolean isSuccess() {
		return success;
	}
	public void setSuccess(boolean success) {
		this.success = success;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	
}
