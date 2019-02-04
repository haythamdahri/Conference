package com.conference.admin_controllers;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.conference.business.IComite;
import com.conference.business.IConference;
import com.conference.business.IPresident;
import com.conference.business.IProfesseur;
import com.conference.business.ISession;
import com.conference.dao.ComiteDAO;
import com.conference.dao.ConferenceDAO;
import com.conference.dao.ConfigDB;
import com.conference.dao.PresidentDAO;
import com.conference.dao.ProfesseurDAO;
import com.conference.dao.SessionDAO;
import com.conference.entities.Comite;
import com.conference.entities.Conference;
import com.conference.entities.President;
import com.conference.entities.Professeur;
import com.conference.entities.Session;

@WebServlet("/profile/addsession")
public class SessionAddController extends HttpServlet {


	private ISession sessionBusiness;
	private IPresident presidentBusiness;
	private IComite comiteBusiness;
	private IProfesseur professeurBusiness;
	private IConference conferenceBusiness;
	
	public void init( ){
		
		//======================= DATABASE PARAMETERS ======================= 
		ServletContext sc = this.getServletContext();
		String driver = sc.getInitParameter("driver");
		String url = sc.getInitParameter("url");
		String db_user = sc.getInitParameter("db_user");
		String db_password = sc.getInitParameter("db_password");
		Connection connection = ConfigDB.getInstance().getConnection(driver, url, db_user, db_password);
		this.sessionBusiness = new SessionDAO(connection);
		this.presidentBusiness = new PresidentDAO(connection);
		this.comiteBusiness = new ComiteDAO(connection);
		this.professeurBusiness = new ProfesseurDAO(connection);
		this.conferenceBusiness = new ConferenceDAO(connection);
		
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.sendRedirect(request.getContextPath()+"/profile?session=all");
		}
		catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		try {
				String president_id = request.getParameter("president_id");
				String[] comite_ids = request.getParameterValues("comite_id");
				String titre = request.getParameter("titre");
				String conference_id = request.getParameter("conference_id");
				String date_start_session = request.getParameter("date_start_session");
				String date_end_session = request.getParameter("date_end_session");
				System.out.println("DATE START: "+date_start_session);
				System.out.println("DATE END: "+date_end_session);
				Conference conference = conferenceBusiness.find(Integer.parseInt(conference_id));
				Professeur professeur = professeurBusiness.find(Integer.parseInt(president_id));
				President pre_sident = new President(0, professeur.getProfesseur_id(), professeur.getMetier(), professeur.getUser_id(), professeur.getUsername(), professeur.getNom(), professeur.getPrenom(), professeur.getEmail(), professeur.getPassword(), professeur.getTelephone(), professeur.getImage());
				President president = presidentBusiness.add(pre_sident);
				Session ses = new Session(titre, new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(date_start_session) , new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(date_end_session), conference, president);
				Session added_session = sessionBusiness.add(ses);
				if( added_session != null ) {

					List<Comite> comites = (List<Comite>)comiteBusiness.findBySessionId(added_session.getId());
					//========================== Add selected Committees ==========================
					for( String co_id : comite_ids ) {
						Professeur prof = professeurBusiness.find(Integer.parseInt(co_id));
						if( !comites.contains(prof) ) {
							Comite comite = new Comite(0, prof.getProfesseur_id(), prof.getMetier(), prof.getUser_id(), prof.getUsername(), prof.getNom(), prof.getPrenom(), prof.getEmail(), prof.getPassword(), prof.getTelephone(), prof.getImage(), added_session);
							comiteBusiness.add(comite);
						}
					}
					
					session.setAttribute("message_session_type", "success");
					session.setAttribute("message_session", "session ajoutée avec succée");
					response.sendRedirect(request.getContextPath()+"/profile?session=all");
				}else {
					session.setAttribute("message_session_type", "danger");
					session.setAttribute("message_session", "Une erreur est survenue, veuillez ressayer!");
					response.sendRedirect(request.getContextPath()+"/profile?addsession");
				}
		}
		catch(Exception ex) {
			try{
				session.setAttribute("message_session_type", "danger");
				session.setAttribute("message_session", "Veuillez remplir tous les champs");
				response.sendRedirect(request.getContextPath()+"/profile?addsession");
			}
			catch(Exception e) {
				System.out.println(e.getMessage());
			}
		}
	}
	
	private boolean isConnected(HttpSession session) {
		if( session.getAttribute("email") != null && session.getAttribute("password") != null && session.getAttribute("username") != null)
			return true;
		return false;
	}
	
}
