package com.conference.admin_controllers;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.conference.business.IComite;
import com.conference.business.IConference;
import com.conference.business.IInscription;
import com.conference.business.IPapier;
import com.conference.business.ISession;
import com.conference.business.ITutoriel;
import com.conference.business.IUser;
import com.conference.dao.ComiteDAO;
import com.conference.dao.ConferenceDAO;
import com.conference.dao.ConfigDB;
import com.conference.dao.InscriptionDAO;
import com.conference.dao.PapierDAO;
import com.conference.dao.SessionDAO;
import com.conference.dao.TutorielDAO;
import com.conference.dao.UserDAO;
import com.conference.entities.Comite;
import com.conference.entities.Conference;
import com.conference.entities.Inscription;
import com.conference.entities.Papier;
import com.conference.entities.Session;
import com.conference.entities.Tutoriel;


@WebServlet("/conference")
public class ConferenceController extends HttpServlet{
	
	//======================= GET HOME =======================
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			//======================= DATABASE PARAMETERS ======================= 
			ServletContext sc = this.getServletContext();
			String driver = sc.getInitParameter("driver");
			String url = sc.getInitParameter("url");
			String db_user = sc.getInitParameter("db_user");
			String db_password = sc.getInitParameter("db_password");
			Connection connection = ConfigDB.getInstance().getConnection(driver, url, db_user, db_password);
			//======================= GET CONFERENCE, ADMINISTRATOR, TUTOS, COMITES AND SESSIONS FROM DATABASE =======================
			IConference conferenceBusiness = new ConferenceDAO(connection);
			ITutoriel tutorielBusiness = new TutorielDAO(connection);
			ISession sessionBusiness = new SessionDAO(connection);
			IComite comiteBusiness = new ComiteDAO(connection);
			IPapier papierBusiness = new PapierDAO(connection);
			IUser userBusiness = new UserDAO(connection);
			IInscription inscriptionBusiness = new InscriptionDAO(connection);

			//======================= CONFERENCE ID =======================
			String conference_id = request.getParameter("id");
			Conference conference = conferenceBusiness.find(Integer.parseInt(conference_id));
			
			if( conference == null ) {
				response.sendRedirect(request.getContextPath());
				return;
			}
			
			for( Tutoriel tutoriel : tutorielBusiness.findAll() ) {
				if( tutoriel.getConference().getId() == conference.getId() ) 
					conference.ajouterTutoriel(tutoriel);
			}

			List<Integer> professors_ids = new ArrayList<>();
			for( Session session_conference : sessionBusiness.findAll() ) {
				if( session_conference.getConference().getId() == conference.getId() ) {
					conference.ajouterSession(session_conference);
					for( Comite comite : comiteBusiness.findAll() ) {
						if( comite.getSession().getId() == session_conference.getId() ) {
							if( !professors_ids.contains(comite.getProfesseur_id()) ) {
								session_conference.ajouterComite(comite);
								professors_ids.add(comite.getProfesseur_id());
							}
						}
					}
				}
			}
			List<Papier> papiers = new  ArrayList<Papier>();
			for( Papier papier : papierBusiness.findAll() ) {
				if( papier.getSession().getConference().getId() == conference.getId() ) {
					papiers.add(papier);
				}
			}
			for( Inscription inscription : inscriptionBusiness.findAll() ) {
				if( inscription.getSession().getConference().getId() == conference.getId() )
					conference.ajouterInscription(inscription);
			}

			//======================= SET ATTRIBUTES =======================
			request.setAttribute("conference", conference);
			request.setAttribute("papiers", papiers);
			request.setAttribute("userBusiness", userBusiness);
			request.setAttribute("inscriptionBusiness", inscriptionBusiness);
			request.setAttribute("sessionBusiness", sessionBusiness);
			request.setAttribute("comiteBusiness", comiteBusiness);
			//======================= RENDER DATA TO HOME TEMPLATE =======================
			request.getRequestDispatcher("conference.jsp").forward(request, response);
			
		
	}

}
