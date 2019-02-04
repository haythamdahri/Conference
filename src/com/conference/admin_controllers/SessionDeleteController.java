package com.conference.admin_controllers;

import java.sql.Connection;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.conference.business.IAdministrateur;
import com.conference.business.IComite;
import com.conference.business.IConference;
import com.conference.business.IPapier;
import com.conference.business.IPresident;
import com.conference.business.IProfesseur;
import com.conference.business.ISession;
import com.conference.business.ITutoriel;
import com.conference.business.IUser;
import com.conference.dao.AdministrateurDAO;
import com.conference.dao.ComiteDAO;
import com.conference.dao.ConferenceDAO;
import com.conference.dao.ConfigDB;
import com.conference.dao.PapierDAO;
import com.conference.dao.PresidentDAO;
import com.conference.dao.ProfesseurDAO;
import com.conference.dao.SessionDAO;
import com.conference.dao.TutorielDAO;
import com.conference.dao.UserDAO;

@WebServlet("/profile/deletesession")
public class SessionDeleteController extends HttpServlet{

	
	private ISession sessionBusiness;
	
	public void init( ){
		
		//======================= DATABASE PARAMETERS ======================= 
		ServletContext sc = this.getServletContext();
		String driver = sc.getInitParameter("driver");
		String url = sc.getInitParameter("url");
		String db_user = sc.getInitParameter("db_user");
		String db_password = sc.getInitParameter("db_password");
		Connection connection = ConfigDB.getInstance().getConnection(driver, url, db_user, db_password);
		this.sessionBusiness = new SessionDAO(connection);
		
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			HttpSession session = request.getSession();
			session.setAttribute("message_session_type", "danger");
			session.setAttribute("message_session", "La suppression direct à été desactivée pour des raisons de securité!");
			response.sendRedirect(request.getContextPath()+"/profile?session=all");
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

			String session_id = request.getParameter("session_id");
			System.out.println("SESSION ID: "+session_id);
			if( session_id != null && !session_id.equals("") ) {
				boolean is_deleted = sessionBusiness.delete(Integer.parseInt(session_id));
				if( is_deleted ) {
					session.setAttribute("message_session_type", "success");
					session.setAttribute("message_session", "La session dont id="+session_id+" à été supprimée avec succé");
				}else {
					session.setAttribute("message_session_type", "danger");
					session.setAttribute("message_session", "Une erreur est survenue, veuillez ressayer!");
				}
				response.sendRedirect(request.getContextPath()+"/profile?session=all");
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
