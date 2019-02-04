package com.conference.admin_controllers;

import java.sql.Connection;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.conference.business.IComite;
import com.conference.business.IPresident;
import com.conference.business.IProfesseur;
import com.conference.business.ISession;
import com.conference.dao.ComiteDAO;
import com.conference.dao.ConfigDB;
import com.conference.dao.PresidentDAO;
import com.conference.dao.ProfesseurDAO;
import com.conference.dao.SessionDAO;
import com.conference.entities.Comite;
import com.conference.entities.President;
import com.conference.entities.Professeur;
import com.conference.entities.Session;

@WebServlet("/profile/updatesession")
public class SessionEditController extends HttpServlet {

	private ISession sessionBusiness;
	private IPresident presidentBusiness;
	private IComite comiteBusiness;
	private IProfesseur professeurBusiness;
	
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
		String session_id = request.getParameter("session_id");
		
		try {
			Session ses = sessionBusiness.find(Integer.parseInt(session_id));
			if( ses != null ) {
				String president_id = request.getParameter("president_id");
				String[] comite_ids = request.getParameterValues("comite_id");
				String titre = request.getParameter("titre");
				String date_start_session = request.getParameter("date_start_session");
				String date_end_session = request.getParameter("date_end_session");
				System.out.println("DATE START: "+date_start_session);
				System.out.println("DATE END: "+date_end_session);
				Professeur professeur = professeurBusiness.find(Integer.parseInt(president_id));
				President president = presidentBusiness.findByProfesseurId(professeur.getProfesseur_id());
				if( president == null ) {
					President old_president = presidentBusiness.find(ses.getPresident().getPresident_id());
					System.out.println("OLD PRESIDENT: "+old_president);
					presidentBusiness.delete(old_president.getPresident_id());
					president = new President(0, professeur.getProfesseur_id(), professeur.getMetier(), professeur.getUser_id(), professeur.getUsername(), professeur.getNom(), professeur.getPrenom(), professeur.getEmail(), professeur.getPassword(),professeur.getTelephone(), professeur.getImage());
					President returned_president = presidentBusiness.add(president);
					ses.setPresident(returned_president);
				}
				ses.setDate_start_session( new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(date_start_session));
				ses.setDate_end_session(new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(date_end_session));
				ses.setTitre(titre);
				boolean is_updated = sessionBusiness.update(ses);
				if( is_updated ) {
					//========================== Add selected Committees ==========================
					comiteBusiness.deleteBySessionId(ses.getId());
					for( String co_id : comite_ids ) {
						Professeur prof = professeurBusiness.find(Integer.parseInt(co_id));
						Comite comite = new Comite(0, prof.getProfesseur_id(), prof.getMetier(), prof.getUser_id(), prof.getUsername(), prof.getNom(), prof.getPrenom(), prof.getEmail(), prof.getPassword(), prof.getTelephone(), prof.getImage(), ses);
						comiteBusiness.add(comite);
					}
					
					session.setAttribute("message_session_type", "success");
					session.setAttribute("message_session", "session id="+ses.getId()+" est mis à jour avec succès");
					response.sendRedirect(request.getContextPath()+"/profile?session=all");
				}else {
					session.setAttribute("message_session_edit_type", "danger");
					session.setAttribute("message_session_edit", "Une erreur est survenue, veuillez ressayer!");
					response.sendRedirect(request.getContextPath()+"/profile?session="+session_id+"&edit");
				}
			}else {
				session.setAttribute("message_session_edit_type", "danger");
				session.setAttribute("message_session_edit", "Une erreur est survenue, veuillez ressayer!");
				response.sendRedirect(request.getContextPath()+"/profile?session="+session_id+"&edit");
			}
		}
		catch(Exception ex) {
			try {
			session.setAttribute("message_session_edit_type", "danger");
			session.setAttribute("message_session_edit", "Veuillez remplir tous les champs");
			response.sendRedirect(request.getContextPath()+"/profile?session="+session_id+"&edit");
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
