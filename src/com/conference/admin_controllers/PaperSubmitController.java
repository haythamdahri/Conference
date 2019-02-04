package com.conference.admin_controllers;

import java.io.IOException;
import java.sql.Connection;
import java.text.DecimalFormat;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.conference.business.IPapier;
import com.conference.business.ISession;
import com.conference.business.IUser;
import com.conference.dao.ConfigDB;
import com.conference.dao.PapierDAO;
import com.conference.dao.SessionDAO;
import com.conference.dao.UserDAO;
import com.conference.entities.Papier;
import com.conference.entities.Session;
import com.conference.entities.User;

@WebServlet("/submitpaper")
public class PaperSubmitController extends HttpServlet {


	private ISession sessionBusiness;
	private IUser userBusiness;
	private IPapier papierBusiness;
	
	public void init( ){
		
		//======================= DATABASE PARAMETERS ======================= 
		ServletContext sc = this.getServletContext();
		String driver = sc.getInitParameter("driver");
		String url = sc.getInitParameter("url");
		String db_user = sc.getInitParameter("db_user");
		String db_password = sc.getInitParameter("db_password");
		Connection connection = ConfigDB.getInstance().getConnection(driver, url, db_user, db_password);
		this.sessionBusiness = new SessionDAO(connection);
		this.userBusiness = new UserDAO(connection);
		this.papierBusiness = new PapierDAO(connection);
		
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.sendRedirect(request.getContextPath());
		}
		catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		try {
				String conference_id = request.getParameter("conference_id");
				String user_id = request.getParameter("user_id");
				String session_id = request.getParameter("session_id");
				String titre = request.getParameter("titre");
				String description = request.getParameter("description");
				
				User user = userBusiness.find(Integer.parseInt(user_id));
				Session ses = sessionBusiness.find(Integer.parseInt(session_id));

				if( user != null && ses != null ) {	
					DecimalFormat dc = new DecimalFormat("##.##");
					Papier papier = new Papier(0, titre, description, user, ses, "", Float.parseFloat("10.75"));
					Papier returned_papier = papierBusiness.add(papier);
					if( returned_papier != null ) {
						session.setAttribute("paper_submited", true);
						response.sendRedirect(request.getContextPath()+"/conference?id="+conference_id);
					}else {
						session.setAttribute("paper_submited", false);
						response.sendRedirect(request.getContextPath()+"/conference?id="+conference_id);
					}
				}else {										
					session.setAttribute("paper_submited", true);
					response.sendRedirect(request.getContextPath()+"/conference?id="+conference_id);
				}
		}
		catch(Exception ex) {
			try {
				response.sendRedirect(request.getContextPath());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	private boolean isConnected(HttpSession session) {
		if( session.getAttribute("email") != null && session.getAttribute("password") != null && session.getAttribute("username") != null)
			return true;
		return false;
	}
	
}
