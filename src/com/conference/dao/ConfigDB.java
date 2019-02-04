package com.conference.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConfigDB {
	
	private static ConfigDB config;
	
	private ConfigDB() {
		
	}
	
	public static ConfigDB getInstance() {
		if( config == null ) {
			config = new ConfigDB();
		}
		return config;
	}
	
	public Connection getConnection(String driver, String url, String username, String password) {
		Connection conn = null;
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, username, password);
		}
		catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
		return conn;
		
	}

}
