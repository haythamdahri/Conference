package com.conference.professor_controllers;

import java.sql.Connection;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.conference.business.IPapier;
import com.conference.business.ISession;
import com.conference.dao.ConfigDB;
import com.conference.dao.PapierDAO;
import com.conference.dao.SessionDAO;
import com.conference.entities.Papier;
import com.conference.entities.Session;

@WebServlet("/professor/updatepaper")
public class MyPaperUpdateController extends HttpServlet{
	
	private IPapier papierBusiness;
	private ISession sessionBusiness;

	public void init( ){
		
		//======================= DATABASE PARAMETERS ======================= 
		ServletContext sc = this.getServletContext();
		String driver = sc.getInitParameter("driver");
		String url = sc.getInitParameter("url");
		String db_user = sc.getInitParameter("db_user");
		String db_password = sc.getInitParameter("db_password");
		Connection connection = ConfigDB.getInstance().getConnection(driver, url, db_user, db_password);
		this.papierBusiness = new PapierDAO(connection);
		this.sessionBusiness = new SessionDAO(connection);
		
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.sendRedirect(request.getContextPath()+"/professor?mypaper=all");
		}
		catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		try {
			String mypaper_id = request.getParameter("mypaper_id");
			String session_id = request.getParameter("session_id");
			String titre = request.getParameter("titre");
			String description = request.getParameter("description");
			Papier papier = papierBusiness.find(Integer.parseInt(mypaper_id));
			Session ses = sessionBusiness.find(Integer.parseInt(session_id));
			//================= UPDATE PAPER =================
			papier.setDescription(description);
			papier.setSession(ses);
			papier.setTitre(titre);
			
			boolean is_updated = papierBusiness.update(papier);
			if( is_updated ) {
				session.setAttribute("message_mypaper_type", "success");
				session.setAttribute("message_mypaper", "Votre papier dont id="+mypaper_id+" est mis à jour avec succès");
			}else {
				session.setAttribute("message_mypaper_edit_type", "danger");
				session.setAttribute("message_mypaper_edit", "Une erreur est survenue, veuillez ressayer!");
			}	
			//============ Redirect Admin to submitted papers ============ 
			response.sendRedirect(request.getContextPath()+"/professor?mypaper=all");
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
