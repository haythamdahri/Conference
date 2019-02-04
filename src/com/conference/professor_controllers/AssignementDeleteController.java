package com.conference.professor_controllers;

import java.sql.Connection;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.conference.business.IAffectation;
import com.conference.dao.AffectationDAO;
import com.conference.dao.ConfigDB;


@WebServlet("/professor/deleteassignement")
public class AssignementDeleteController extends HttpServlet {

private IAffectation affectationBusiness;
	
	public void init( ){
		
		//======================= DATABASE PARAMETERS ======================= 
		ServletContext sc = this.getServletContext();
		String driver = sc.getInitParameter("driver");
		String url = sc.getInitParameter("url");
		String db_user = sc.getInitParameter("db_user");
		String db_password = sc.getInitParameter("db_password");
		Connection connection = ConfigDB.getInstance().getConnection(driver, url, db_user, db_password);
		this.affectationBusiness = new AffectationDAO(connection);
		
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.sendRedirect(request.getContextPath()+"/professor?assignement=all");
		}
		catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		try {
			String affectation_id = request.getParameter("assignement_id");
			boolean is_deleted = affectationBusiness.delete(Integer.parseInt(affectation_id));
			if( is_deleted ) {
				session.setAttribute("message_assignement_type", "success");
				session.setAttribute("message_assignement", "L'affectation dont id="+affectation_id+" à été supprimée");
			}else {
				session.setAttribute("message_assignement_type", "danger");
				session.setAttribute("message_assignement", "Une erreur est survenue, veuillez ressayer!");
			}	
			//============ Redirect Admin to submitted papers ============ 
			response.sendRedirect(request.getContextPath()+"/professor?assignement=all");
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
