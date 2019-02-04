package com.conference.admin_controllers;

import java.sql.Connection;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.conference.business.IConference;
import com.conference.dao.ConferenceDAO;
import com.conference.dao.ConfigDB;

@WebServlet("/profile/deleteconference")
public class ConferenceDeleteController extends HttpServlet{

	
	private IConference conferenceBusiness;
	
	public void init( ){
		
		//======================= DATABASE PARAMETERS ======================= 
		ServletContext sc = this.getServletContext();
		String driver = sc.getInitParameter("driver");
		String url = sc.getInitParameter("url");
		String db_user = sc.getInitParameter("db_user");
		String db_password = sc.getInitParameter("db_password");
		Connection connection = ConfigDB.getInstance().getConnection(driver, url, db_user, db_password);
		this.conferenceBusiness = new ConferenceDAO(connection);
		
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			HttpSession session = request.getSession();
			session.setAttribute("message_conference_type", "danger");
			session.setAttribute("message_conference", "La suppression direct à été desactivée pour des raisons de securité!");
			response.sendRedirect(request.getContextPath()+"/profile?conference=all");
		}
		catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		
		try {
			if( !isConnected(session) ) {
				response.sendRedirect(request.getContextPath());
				return;
			}

			String conference_id = request.getParameter("conference_id");
			if( conference_id != null && !conference_id.equals("") ) {
				boolean is_deleted = conferenceBusiness.delete(Integer.parseInt(conference_id));
				if( is_deleted ) {
					session.setAttribute("message_conference_type", "success");
					session.setAttribute("message_conference", "La conference dont id="+conference_id+" à été supprimée avec succé");
				}else {
					session.setAttribute("message_conference_type", "danger");
					session.setAttribute("message_conference", "Une erreur est survenue, veuillez ressayer!");
				}
				response.sendRedirect(request.getContextPath()+"/profile?conference=all");
				return;
			}
			doGet(request, response);
		}
		catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
	
	private boolean isConnected(HttpSession session) {
		if( session.getAttribute("email") != null && session.getAttribute("password") != null && session.getAttribute("username") != null)
			return true;
		return false;
	}
	
}
