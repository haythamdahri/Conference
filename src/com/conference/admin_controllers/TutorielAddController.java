package com.conference.admin_controllers;

import java.sql.Connection;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.conference.business.IConference;
import com.conference.business.ITutoriel;
import com.conference.dao.ConferenceDAO;
import com.conference.dao.ConfigDB;
import com.conference.dao.TutorielDAO;
import com.conference.entities.Comite;
import com.conference.entities.Conference;
import com.conference.entities.Professeur;
import com.conference.entities.Tutoriel;

@WebServlet("/profile/addtutoriel")
public class TutorielAddController extends HttpServlet {


	private ITutoriel tutorielBusiness;
	private IConference conferenceBusiness;
	
	public void init( ){
		
		//======================= DATABASE PARAMETERS ======================= 
		ServletContext sc = this.getServletContext();
		String driver = sc.getInitParameter("driver");
		String url = sc.getInitParameter("url");
		String db_user = sc.getInitParameter("db_user");
		String db_password = sc.getInitParameter("db_password");
		Connection connection = ConfigDB.getInstance().getConnection(driver, url, db_user, db_password);
		this.tutorielBusiness = new TutorielDAO(connection);
		this.conferenceBusiness = new ConferenceDAO(connection);
		
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.sendRedirect(request.getContextPath()+"/profile?tutoriel=all");
		}
		catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		try {
				String titre = request.getParameter("titre");
				String description = request.getParameter("description");
				String conference_id = request.getParameter("conference_id");
				Conference conference = conferenceBusiness.find(Integer.parseInt(conference_id));
				System.out.println("Conference: "+conference);
				Tutoriel tutoriel = new Tutoriel(0, titre, description, conference);
				Tutoriel returned_tutoriel = tutorielBusiness.add(tutoriel);
				
				if( returned_tutoriel != null ) {
					session.setAttribute("message_tutoriel_type", "success");
					session.setAttribute("message_tutoriel", "tutoriel ajouté avec succée");
					response.sendRedirect(request.getContextPath()+"/profile?tutoriel=all");
				}else {
					session.setAttribute("message_tutoriel_type", "danger");
					session.setAttribute("message_tutoriel", "Une erreur est survenue, veuillez ressayer!");
					response.sendRedirect(request.getContextPath()+"/profile?addtutoriel");
				}
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
