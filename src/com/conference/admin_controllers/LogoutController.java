package com.conference.admin_controllers;

import java.sql.Connection;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.conference.business.IUser;
import com.conference.dao.ConfigDB;
import com.conference.dao.UserDAO;
import com.conference.entities.User;

@WebServlet("/logout")
public class LogoutController extends HttpServlet{
	
	private IUser userBusiness;
	
	public void init( ){
		
		//======================= DATABASE PARAMETERS ======================= 
		ServletContext sc = this.getServletContext();
		String driver = sc.getInitParameter("driver");
		String url = sc.getInitParameter("url");
		String db_user = sc.getInitParameter("db_user");
		String db_password = sc.getInitParameter("db_password");
		Connection connection = ConfigDB.getInstance().getConnection(driver, url, db_user, db_password);
		this.userBusiness = new UserDAO(connection);
	    userBusiness = new UserDAO(connection); 
	   
	}
	
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			HttpSession session = request.getSession();
			session.removeAttribute("email");
			session.removeAttribute("password");
			session.removeAttribute("username");
			response.sendRedirect(request.getContextPath()+"/login");
		}
		catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		doGet(request, response);
	}
	

}
