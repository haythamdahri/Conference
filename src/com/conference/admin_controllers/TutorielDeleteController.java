package com.conference.admin_controllers;

import java.sql.Connection;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.conference.business.ITutoriel;
import com.conference.dao.ConfigDB;
import com.conference.dao.TutorielDAO;

@WebServlet("/profile/deletetutoriel")
public class TutorielDeleteController extends HttpServlet{

	
	private ITutoriel tutorielBusiness;
	
	public void init( ){
		
		//======================= DATABASE PARAMETERS ======================= 
		ServletContext sc = this.getServletContext();
		String driver = sc.getInitParameter("driver");
		String url = sc.getInitParameter("url");
		String db_user = sc.getInitParameter("db_user");
		String db_password = sc.getInitParameter("db_password");
		Connection connection = ConfigDB.getInstance().getConnection(driver, url, db_user, db_password);
		this.tutorielBusiness = new TutorielDAO(connection);
		
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			HttpSession session = request.getSession();
			session.setAttribute("message_tutoriel_type", "danger");
			session.setAttribute("message_tutoriel", "La suppression direct à été desactivée pour des raisons de securité!");
			response.sendRedirect(request.getContextPath()+"/profile?tutoriel=all");
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

			String tutoriel_id = request.getParameter("tutoriel_id");
			System.out.println("TUTORIEL ID: "+tutoriel_id);
			if( tutoriel_id != null && !tutoriel_id.equals("") ) {
				boolean is_deleted = tutorielBusiness.delete(Integer.parseInt(tutoriel_id));
				if( is_deleted ) {
					session.setAttribute("message_tutoriel_type", "success");
					session.setAttribute("message_tutoriel", "Le tutoriel dont id="+tutoriel_id+" à été supprimé avec succé");
				}else {
					session.setAttribute("message_tutoriel_type", "danger");
					session.setAttribute("message_tutoriel", "Une erreur est survenue, veuillez ressayer!");
				}
				response.sendRedirect(request.getContextPath()+"/profile?tutoriel=all");
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
