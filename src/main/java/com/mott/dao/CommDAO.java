package com.mott.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

public class CommDAO {
	
	//private static Logger log = Logger.getLogger(CommDAO.class);
	
	/**
     * 方法，为sql语句设置参数；
     * @param pstmt 指令
     * @param parameters 参数集合；
     * @throws SQLException 
     */
    private void setParameters(PreparedStatement pstmt,List<Object> parameters) throws SQLException{
        for (int i = 0; i < parameters.size(); i++) {
            Object v = parameters.get(i);
            pstmt.setObject(i+1, v);
        }
    }

	/**
     * 执行查询；
     * @return
     */
    public List<Hashtable<String, Object>> executeQuery(String sql , List<Object> parameters){
    	Connection conn = null;
    	List<Hashtable<String, Object>> list = new ArrayList<Hashtable<String, Object>>();
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        
        try {
        	conn = DBConnection.getInstance().getConnection();
            //如果sql语句有参数；
            if(parameters != null && parameters.size() > 0){
                pstmt = conn.prepareStatement(sql);
                setParameters(pstmt, parameters);
                rs = pstmt.executeQuery();
            }
            //如果没有参数；
            else{
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();
            }
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();
            while (rs.next()) {
            	Hashtable<String, Object> htData = new Hashtable<String, Object>(columnCount);
            	for (int i = 1; i <= columnCount; i++) {
            		htData.put(metaData.getColumnName(i).toUpperCase(), rs.getObject(i)==null ? "":rs.getObject(i));   
            	} 
            	list.add(htData);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public int getDataValue(String sql){
    	Connection conn = null;
    	ResultSet rs = null;
    	int dataValue = -1;
        PreparedStatement pstmt = null;
        try {
        	conn = DBConnection.getInstance().getConnection();
            
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
           
            if (rs.next()) {
            	dataValue = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return dataValue;
        }finally{
			try {
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				pstmt = null;
				rs = null;
			}
		}
		return dataValue;
    }
    
    /**
     * executeQuery
     *
     * @param sql
     * @return 创建时间：2016年10月31日 上午10:44:00
     */
    public List<Hashtable<String, Object>> executeQuery(String sql){
    	
    	return executeQuery(sql , null);
    }
    
    
    /**
     * executeUpdate
     *
     * @param sql
     * @return 创建时间：2016年10月31日 上午10:43:40
     */
    public int executeUpdate(String sql){
    	Connection conn = null;
    	 PreparedStatement pstmt = null;
    	 try {
    		conn = DBConnection.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			return pstmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}finally{
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				pstmt = null;
			}
		}
    }
    
    
	public static void main(String[] args) {
		long date = 1442793600000L ;
	}

}
