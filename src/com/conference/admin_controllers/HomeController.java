package com.conference.admin_controllers;

import javax.servlet.http.HttpServlet;

import com.conference.business.*;
import com.conference.dao.AdministrateurDAO;
import com.conference.dao.ComiteDAO;
import com.conference.dao.ConferenceDAO;
import com.conference.dao.ConfigDB;
import com.conference.dao.InscriptionDAO;
import com.conference.dao.PapierDAO;
import com.conference.dao.SessionDAO;
import com.conference.dao.TutorielDAO;
import com.conference.entities.Administrateur;
import com.conference.entities.Comite;
import com.conference.entities.Conference;
import com.conference.entities.Inscription;
import com.conference.entities.Papier;
import com.conference.entities.Session;
import com.conference.entities.Tutoriel;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.util.*;


@WebServlet("")
public class HomeController extends HttpServlet{
	
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
			IInscription inscriptionBusiness = new InscriptionDAO(connection);

			//======================= CONFERENCE ID =======================
			String conference_id = request.getParameter("id");
			List<Conference> conferences = (List<Conference>) conferenceBusiness.findAll();
			
			for( Conference conference : conferences ) {
				for( Tutoriel tutoriel : tutorielBusiness.findAll() ) {
					if( tutoriel.getConference().getId() == conference.getId() ) 
						conference.ajouterTutoriel(tutoriel);
				}
				
				for( Session session_conference : sessionBusiness.findAll() ) {
					if( session_conference.getConference().getId() == conference.getId() ) {
						conference.ajouterSession(session_conference);
						for( Comite comite : comiteBusiness.findAll() ) {
							if( comite.getSession().getId() == session_conference.getId() ) {
								session_conference.ajouterComite(comite);
							}
						}
					}
				}
				for( Inscription inscription : inscriptionBusiness.findAll() ) {
					if( inscription.getSession().getConference().getId() == conference.getId() )
						conference.ajouterInscription(inscription);
				}
			}
			//======================= SET ATTRIBUTES =======================
			request.setAttribute("conferences", conferences);
			//======================= RENDER DATA TO HOME TEMPLATE =======================
			request.getRequestDispatcher("home.jsp").forward(request, response);
			
		
	}

}
