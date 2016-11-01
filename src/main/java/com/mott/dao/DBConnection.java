package com.mott.dao;

import java.beans.PropertyVetoException;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.util.Properties;

import org.apache.log4j.Logger;

import com.mchange.v2.c3p0.ComboPooledDataSource;

/**
 * 数据库连接公共类
 * 
 * @author jinli.liu
 */
public class DBConnection {
	private static Logger log = Logger.getLogger(DBConnection.class);

	private static Properties props = null;
	private static ComboPooledDataSource dataSource = null;
	private static ThreadLocal<Connection> tlConn = new ThreadLocal<Connection>(); 
	private static DBConnection dbconnection = null;
	public static String filePath="\\c3p0.properties";
 
	
    private DBConnection() {// 将构造方法私有
    	//File path= new File(DBConnection.class.getResource("/").getPath());
    	//initDataSource(path.getParentFile().getPath()+filePath);
    	initDataSource("");
    }
 
    public static DBConnection getInstance() {// 实例化引用
        if (dbconnection == null) {
        	dbconnection = new DBConnection();
        }
        return dbconnection;
    }
	
 
    private void initDataSource(String filePath){
    	props = new Properties();
		try {
			props.load(DBConnection.class.getResourceAsStream("/c3p0.properties"));
			//props.load(new FileInputStream(filePath));
			if(dataSource == null){
				dataSource = new ComboPooledDataSource();
				try {
					dataSource.setDriverClass( props.getProperty("c3p0.driverClass"));
					dataSource.setJdbcUrl( props.getProperty("c3p0.jdbcUrl") );
					dataSource.setUser(props.getProperty("c3p0.user")); 
					dataSource.setPassword(props.getProperty("c3p0.password")); 
					
					dataSource.setInitialPoolSize(Integer.parseInt(props.getProperty("c3p0.initialPoolSize")));
					dataSource.setMinPoolSize(Integer.parseInt(props.getProperty("c3p0.minPoolSize"))); 
					dataSource.setAcquireIncrement(Integer.parseInt(props.getProperty("c3p0.acquireIncrement")));
					dataSource.setMaxPoolSize(Integer.parseInt(props.getProperty("c3p0.maxPoolSize"))); 
					dataSource.setMaxIdleTime(Integer.parseInt(props.getProperty("c3p0.maxIdleTime"))); 
					dataSource.setIdleConnectionTestPeriod(Integer.parseInt(props.getProperty("c3p0.idleConnectionTestPeriod")));
				} catch (PropertyVetoException e) {
					e.printStackTrace();
				}
			}
		} catch (IOException ioe) {
			log.error(ioe);
			ioe.printStackTrace();
		}
    }
	
	public Connection getConnection() {  
        try {  
           Connection conn = tlConn.get();  //得到当前线程上绑定的连接  
           if (conn == null) {  // 代表线程上没有绑定连接  
                conn = dataSource.getConnection();  
                tlConn.set(conn);  
            }  
            return conn;  
        } catch (Exception e) {  
        	log.error(e);
            throw new RuntimeException(e);  
        }  
    }  
	
	public void startTransaction() {  
       try {  
           // 得到当前线程上绑定连接开启事务  
           Connection conn=getConnection();  
           conn.setAutoCommit(false);  
        } catch (Exception e) {  
           throw new RuntimeException(e);  
        }  
    }  
	  
	public void commitTransaction() {  
        try {  
	        Connection conn = tlConn.get();  
            if (conn != null) {  
	            conn.commit();  
	        }  
        } catch (Exception e) {  
	        throw new RuntimeException(e);  
        }  
	}  
		 
	public void closeConnection() {  
	    try{  
	        Connection conn = tlConn.get();  
	        if (conn != null) {  
		       conn.close();  
	        }  
		} catch (Exception e) {  
		    throw new RuntimeException(e);  
	    } finally {  
	        tlConn.remove(); // 解除当前线程上绑定的链接（从threadlocal容器中移除对应当前线程的链接）  
	    }  
	}  
	
	
	/**
	 * 系统调用
	 * @param filePath
	 */
	public void init(String filePath) {
		// TODO Auto-generated method stub
		initDataSource(filePath);
	}
	
	/**
	 * 系统调用
	 */
	public void close(){
		if(dataSource!=null)
			dataSource.close();
	}
	
	public static  void main(String[] args) {
		File path= new File(DBConnection.class.getResource("/").getPath());
		System.out.println(path.getParentFile().getPath()+"\\c3p0.properties");
		System.out.println(DBConnection.class.getResourceAsStream("/c3p0.properties"));
//		Connection conn = DBConnection.getInstance().getConnection();
//		System.out.println(conn);
		
	}


}