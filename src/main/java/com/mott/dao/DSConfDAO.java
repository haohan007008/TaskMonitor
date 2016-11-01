package com.mott.dao;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import sun.tools.tree.ThisExpression;

import com.mott.po.DataSourceConf;


public class DSConfDAO extends CommDAO{
	
	public int AddDataSourceConf(DataSourceConf conf){
		StringBuffer sb = new StringBuffer();
		sb.append("insert into pubconfig.t_das_data_source_config(id,db_name,version,driver_class,jdbc_url,"
				+ "username,password,pool_init,pool_max,create_time)values(");
		
		sb.append(this.getDataValue("select max(id)+1 from pubconfig.t_das_data_source_config") +",");
		sb.append("'"+conf.getDsName() +"',");
		sb.append("'"+conf.getVersion() +"',");
		sb.append("'"+conf.getDriverClaz() +"',");
		sb.append("'"+conf.getJdbcUrl() +"',");
		sb.append("'"+conf.getUserName() +"',");
		sb.append("'"+conf.getPasswd() +"',");
		sb.append(conf.getPoolInitSize() +",");
		sb.append(conf.getPoolMaxSize() +",");
		sb.append("sysdate" );
		sb.append(")");
		System.out.println(sb.toString());
		
		return this.executeUpdate(sb.toString());
	}
	
	public int updateDataSourceConf(DataSourceConf conf){
		StringBuffer sb = new StringBuffer();
		sb.append("update pubconfig.t_das_data_source_config set ");
		sb.append("db_name ='"+conf.getDsName() +"',");
		sb.append("version='"+conf.getVersion() +"',");
		sb.append("driver_class='"+conf.getDriverClaz() +"',");
		sb.append("jdbc_url='"+conf.getJdbcUrl() +"',");
		sb.append("username='"+conf.getUserName() +"',");
		sb.append("password='"+conf.getPasswd() +"',");
		sb.append("pool_init="+conf.getPoolInitSize() +",");
		sb.append("pool_max="+conf.getPoolMaxSize() +",");
		sb.append("create_time=sysdate" );
		sb.append(" where id=" + conf.getDsId());
		System.out.println(sb.toString());
		
		return this.executeUpdate(sb.toString());
	}
	
	public int deleteDataSourceConfById(int dsId){
		StringBuffer sb = new StringBuffer();
		
		sb.append("delete pubconfig.t_das_data_source_config where id =" + dsId);
		
		return this.executeUpdate(sb.toString());
	}
	
	public DataSourceConf getDataSourceConfById(int dsId) {
		StringBuffer sb = new StringBuffer();
		sb.append("select * from pubconfig.t_das_data_source_config where id =" + dsId);
		List<Hashtable<String, Object>> list = 	this.executeQuery(sb.toString());
		
		DataSourceConf conf = new DataSourceConf();
		if(list != null && list.size() > 0){
			Hashtable<String, Object> hst = list.get(0);
			
			conf.setDsId(Integer.parseInt(hst.get("ID").toString()));
			conf.setDsName(hst.get("DB_NAME").toString());
			conf.setJdbcUrl(hst.get("JDBC_URL").toString());
			conf.setDriverClaz(hst.get("DRIVER_CLASS").toString());
			conf.setUserName(hst.get("USERNAME").toString());
			conf.setPasswd(hst.get("PASSWORD").toString());
			conf.setPoolInitSize(Integer.parseInt(hst.get("POOL_INIT").toString()));
			conf.setPoolMaxSize(Integer.parseInt(hst.get("POOL_MAX").toString()));
			conf.setVersion(hst.get("VERSION").toString());
			conf.setCreateTime(hst.get("CREATE_TIME").toString());
		}
		return conf;
	}
	
	/**
	 * getDataSourceConfList
	 *
	 * @return 创建时间：2016年10月31日 上午10:16:20
	 */
	public List<DataSourceConf> getDataSourceConfList(){
		List<DataSourceConf> ls = new ArrayList<DataSourceConf>();
		List<Hashtable<String, Object>> list = 
				this.executeQuery("select * from pubconfig.t_das_data_source_config");
		for (int i = 0; i < list.size(); i++) {
			Hashtable<String, Object> hst = list.get(i);
			DataSourceConf conf = new DataSourceConf();
			conf.setDsId(Integer.parseInt(hst.get("ID").toString()));
			conf.setDsName(hst.get("DB_NAME").toString());
			conf.setJdbcUrl(hst.get("JDBC_URL").toString());
			conf.setDriverClaz(hst.get("DRIVER_CLASS").toString());
			conf.setUserName(hst.get("USERNAME").toString());
			conf.setPasswd(hst.get("PASSWORD").toString());
			conf.setPoolInitSize(Integer.parseInt(hst.get("POOL_INIT").toString()));
			conf.setPoolMaxSize(Integer.parseInt(hst.get("POOL_MAX").toString()));
			conf.setVersion(hst.get("VERSION").toString());
			conf.setCreateTime(hst.get("CREATE_TIME").toString());
			ls.add(conf);
		}
		return ls;
	}
	
	public static void main(String[] args) {
		DSConfDAO dao = new DSConfDAO();
		
		List<DataSourceConf> list = dao.getDataSourceConfList();
		System.out.println(list.size());
	}

}
