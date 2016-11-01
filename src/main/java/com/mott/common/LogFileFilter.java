package com.mott.common;

import java.io.File;
import java.io.FilenameFilter;


public class LogFileFilter implements FilenameFilter {
	
	public boolean isfilter(String name){
		String[] frex = Constant.LOG_FILE_FREX.split(",");
		boolean isfilter = false;
		for (String f : frex) {
			if (name.toLowerCase().endsWith(f.toLowerCase())) {
				isfilter = true;
				break;
			}
		}
		return isfilter;
	}
	@Override
	public boolean accept(File dir, String name) {
		return isfilter(name);
	}

}
