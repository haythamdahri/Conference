package com.conference.professor_controllers;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.conference.business.IAdministrateur;
import com.conference.business.IAffectation;
import com.conference.business.IComite;
import com.conference.business.IConference;
import com.conference.business.IInscription;
import com.conference.business.IPapier;
import com.conference.business.IPresident;
import com.conference.business.IProfesseur;
import com.conference.business.ISession;
import com.conference.business.ITutoriel;
import com.conference.business.IUser;
import com.conference.dao.AdministrateurDAO;
import com.conference.dao.AffectationDAO;
import com.conference.dao.ComiteDAO;
import com.conference.dao.ConferenceDAO;
import com.conference.dao.ConfigDB;
import com.conference.dao.InscriptionDAO;
import com.conference.dao.PapierDAO;
import com.conference.dao.PresidentDAO;
import com.conference.dao.ProfesseurDAO;
import com.conference.dao.SessionDAO;
import com.conference.dao.TutorielDAO;
import com.conference.dao.UserDAO;
import com.conference.entities.Administrateur;
import com.conference.entities.Affectation;
import com.conference.entities.Comite;
import com.conference.entities.Conference;
import com.conference.entities.Inscription;
import com.conference.entities.Papier;
import com.conference.entities.Professeur;
import com.conference.entities.Session;
import com.conference.entities.Tutoriel;
import com.conference.entities.User;

@WebServlet("/professor")
public class ProfessorController extends HttpServlet {
	
	private String filePath;
	private IUser userBusiness;
	private IProfesseur professeurBusiness;
	private IAdministrateur administrateurBusiness;
	private IConference conferenceBusiness;
	private ISession sessionBusiness;
	private ITutoriel tutorielBusiness;
	private IComite comiteBusiness;
	private IPapier papierBusiness;
	private IPresident presidentBusiness;
	private IInscription inscriptionBusiness;
	private IAffectation affectationBusiness;

	public void init( ){
		
		//======================= DATABASE PARAMETERS ======================= 
		ServletContext sc = this.getServletContext();
		String driver = sc.getInitParameter("driver");
		String url = sc.getInitParameter("url");
		String db_user = sc.getInitParameter("db_user");
		String db_password = sc.getInitParameter("db_password");
		Connection connection = ConfigDB.getInstance().getConnection(driver, url, db_user, db_password);
		this.userBusiness = new UserDAO(connection);
		this.professeurBusiness = new ProfesseurDAO(connection);
		this.administrateurBusiness = new AdministrateurDAO(connection);
		this.conferenceBusiness = new ConferenceDAO(connection);
		this.sessionBusiness = new SessionDAO(connection);
		this.tutorielBusiness = new TutorielDAO(connection);
		this.comiteBusiness = new ComiteDAO(connection);
		this.papierBusiness = new PapierDAO(connection);
		this.presidentBusiness = new PresidentDAO(connection);
		this.inscriptionBusiness = new InscriptionDAO(connection);
		this.affectationBusiness = new AffectationDAO(connection);
		//======================= SAVE DIR PARAMETERS ======================= 		
		filePath = getServletContext().getInitParameter("APPDIR")+"WebContent/media/images/"; 
		
	}
	
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		Professeur professeur = null;
		Administrateur administrateur = null;
		List<Conference> conferences = null;
		
		try {

			HttpSession session = request.getSession();
			if( !isConnected(session) ) {
				response.sendRedirect(request.getContextPath()+"/login");
				return;
			}
			String email = (String) session.getAttribute("email");
			String password = (String) session.getAttribute("password");
			User user = userBusiness.find(email, password);
			checkifadmin(user, request, response);
			if( user != null ) {
				session.setAttribute("user", user);
				session.setAttribute("userBusiness", this.userBusiness);
				session.setAttribute("professeurBusiness", this.professeurBusiness);
				session.setAttribute("administrateurBusiness", this.administrateurBusiness);
				session.setAttribute("conferenceBusiness", this.conferenceBusiness);
				session.setAttribute("comiteBusiness", this.comiteBusiness);
				session.setAttribute("papierBusiness", this.papierBusiness);
				session.setAttribute("tutorielBusiness", this.tutorielBusiness);
				session.setAttribute("sessionBusiness", this.sessionBusiness);
				session.setAttribute("inscriptionBusiness", this.inscriptionBusiness);
				session.setAttribute("affectationBusiness", this.affectationBusiness);
				session.setAttribute("presidentBusiness", this.presidentBusiness);
				
				request.setAttribute("showStatistics", true);
				
				
				professeur = professeurBusiness.findByUserId(user.getUser_id());
				conferences = (List<Conference>) this.conferenceBusiness.findByAdministrateur(professeur.getProfesseur_id());

				session.setAttribute("conferences", conferences);
				session.setAttribute("professeur", professeur);
				request.setAttribute("page_url", request.getRequestURI());

						
				checkParameters(professeur, request, response, session);
				if( !response.isCommitted() )
					request.getRequestDispatcher("profile_professor.jsp").forward(request, response);
			
			}else{
				response.sendRedirect(request.getContextPath()+"/logout");
			}
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		
		doGet(request, response);
		
	}
	
	private boolean isConnected(HttpSession session) {
		if( session.getAttribute("email") != null && session.getAttribute("password") != null && session.getAttribute("username") != null)
			return true;
		return false;
	}
	
	private void addComite(Session session) {
		try {
			for( Comite comite : comiteBusiness.findBySessionId(session.getId()) ) {
				session.ajouterComite(comite);
			}
		}
		catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
	} 
	
	private void addPapier(Session session) {
		try {
			for( Papier papier : papierBusiness.findBySessionId(session.getId()) ) {
				session.ajouterPapier(papier);
			}
		}
		catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
	} 
	
	private void addSessions(Conference conference) {
		try {
			for( Session session : sessionBusiness.findByConferenceId(conference.getId()) ) {
				addPapier(session);
				addComite(session);
				conference.ajouterSession(session);
			}
		}
		catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
	
	
	
	
	private void checkParameters(Professeur professeur, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
		//==================== DISPLAY NUMBER OF USERS ====================
		request.setAttribute("users", userBusiness.findAll());
		
		//==================== DISPLAY MESSAGES FOR USERS ====================
		if( request.getParameter("conference") != null && request.getParameterMap().size() == 1 ) {
			if( request.getParameter("conference").equals("all") || request.getParameter("conference").equals("")  ) {
				request.setAttribute("message", "voici la liste des conférences");
				request.setAttribute("message_type", "info");
			}else {
				String conference_id=request.getParameter("conference");
				Conference conf = conferenceBusiness.find(Integer.parseInt(conference_id));
				if( conf != null ) {
					request.setAttribute("conference", conf);
					request.setAttribute("message", "voici la conference: <em>"+conf.getTitre()+"</em>");
					request.setAttribute("message_type", "info");
				}else {
					session.setAttribute("message_conference", "La conference dont id="+conference_id+" n'éxiste pas!");
					session.setAttribute("message_conference_type", "danger");
					response.sendRedirect(request.getContextPath()+"/professor?conference=all");
					return;
				}
			}
		}
		if( request.getParameter("session") != null && request.getParameterMap().size() == 1 ) {
			if( request.getParameter("session").equals("all") || request.getParameter("session").equals("")  ) {
				request.setAttribute("message", "voici la liste des sessions");
				request.setAttribute("message_type", "info");
			}else {
				String session_id=request.getParameter("session");
				Session ses = null;
				try {
					ses = sessionBusiness.find(Integer.parseInt(session_id));
					boolean member = false;
					for( Comite comite : comiteBusiness.findAll() ) {
						if( comite.getProfesseur_id() == professeur.getProfesseur_id() ) {
							member = true;
							break;
						}
					}
				}
				catch(Exception ex) {
					System.out.println("Session: "+ex.getMessage());
				}
				if( ses != null ) {
					request.setAttribute("session", ses);
					request.setAttribute("message", "voici la session: <em>"+ses.getTitre()+"</em>");
					request.setAttribute("message_type", "info");
				}else {
					session.setAttribute("message_session", "La session dont id="+session_id+" n'éxiste pas!");
					session.setAttribute("message_session_type", "danger");
					
				}
			}
		}
		if( request.getParameter("session") != null && request.getParameter("edit") != null && request.getParameterMap().size() == 2 ) {
			String session_id = request.getParameter("session");
			Session ses = sessionBusiness.find(Integer.parseInt(session_id));
			if( ses != null ) {
				if( professeur.getProfesseur_id() == ses.getPresident().getProfesseur_id() ) {
					session.setAttribute("session_edit", ses);
					request.setAttribute("message_session_edit_type", "info");
					request.setAttribute("message_session_edit", "Modification de session id="+session_id);
					ses.setComites((List<Comite>)comiteBusiness.findBySessionId(ses.getId()));
				}else {
					session.setAttribute("message_session_type", "danger");
					session.setAttribute("message_session", "Vous n'avez pas les privilges pour modifier la session!");
					response.sendRedirect(request.getContextPath()+"/professor?session=all");
					return;
				}
			}else {
				request.setAttribute("message_session", "La session dont id="+session_id+" n'éxiste pas!");
				request.setAttribute("message_session_type", "danger");
				response.sendRedirect(request.getContextPath()+"/professor?session=all");
				return;
			}
		}
		
		if( request.getParameter("paper") != null && request.getParameterMap().size() == 1 ) {
			if( request.getParameter("paper").equals("all") || request.getParameter("paper").equals("") ) {
				request.setAttribute("message", "voici la liste des papiers soumis");
				request.setAttribute("message_type", "info");
			}else {
				String papier_id=request.getParameter("paper");
				Papier papier = null;
				try {
					papier = papierBusiness.find(Integer.parseInt(papier_id));
				}
				catch(Exception ex) {
					System.out.println(ex.getMessage());
				}
				if( papier != null ) {
					request.setAttribute("papier", papier);
					request.setAttribute("message", "voici le papier: <em>"+papier.getTitre()+"</em>");
					request.setAttribute("message_type", "info");
				}else {
					request.setAttribute("message", "Le papier dont id="+papier_id+" n'éxiste pas!");
					request.setAttribute("message_type", "danger");
				}
			}
		}
		if( request.getParameter("mypaper") != null && request.getParameterMap().size() == 1 ) {
			if( request.getParameter("mypaper").equals("all") || request.getParameter("mypaper").equals("") ) {
				request.setAttribute("message", "voici la liste de vos papiers soumis");
				request.setAttribute("message_type", "info");
			}else {
				String papier_id=request.getParameter("mypaper");
				Papier papier = null;
				try {
					papier = papierBusiness.find(Integer.parseInt(papier_id));
				}
				catch(Exception ex) {
					System.out.println(ex.getMessage());
				}
				if( papier != null ) {
					if( papier.getUser().getUser_id() == professeur.getUser_id() ) {
					request.setAttribute("papier", papier);
					request.setAttribute("message", "voici votre papier: <em>"+papier.getTitre()+"</em>");
					request.setAttribute("message_type", "info");
					}else {
						session.setAttribute("message_mypaper_type", "danger");
						session.setAttribute("message_mypaper", "Le papier dont id="+papier_id+" n'est pas votre papier!");
						response.sendRedirect(request.getContextPath()+"/professor?mypaper=all");
						return;	
					}
				}else {
					request.setAttribute("message", "Le papier dont id="+papier_id+" n'éxiste pas!");
					request.setAttribute("message_type", "danger");
				}
			}
		}
		if( request.getParameter("assignement") != null && request.getParameterMap().size() == 1 ) {
			if( request.getParameter("assignement").equals("all") || request.getParameter("assignement").equals("") ) {
				request.setAttribute("message", "voici la liste des affectations des papiers");
				request.setAttribute("message_type", "info");
			}else {
				String affectation_id = request.getParameter("assignement");
				Affectation affectation = null;
				try {
					affectation = affectationBusiness.find(Integer.parseInt(affectation_id));
				}
				catch(Exception ex) {
					System.out.println(ex.getMessage());
				}
				if( affectation != null ) {
					request.setAttribute("affectation", affectation);
					request.setAttribute("message", "voici l'affectation du papier de: <em>"+affectation.getComite().fullname()+"</em>");
					request.setAttribute("message_type", "info");
				}else {
					request.setAttribute("message", "L'affectation dont id="+affectation_id+" n'éxiste pas!");
					request.setAttribute("message_type", "danger");
				}
			}
		}
		if( request.getParameter("assignement") != null && request.getParameter("edit") != null && request.getParameterMap().size() == 2 ) {
			String affectation_id = request.getParameter("assignement");
			Affectation affectation = affectationBusiness.find(Integer.parseInt(affectation_id));
			if( affectation != null ) {
				if( affectation.getComite().getSession().getPresident().getProfesseur_id() == professeur.getProfesseur_id() ) {
					request.setAttribute("affectation", affectation);
					session.setAttribute("message_assignement_edit_type", "info");
					session.setAttribute("message_assignement_edit", "Modification d'affectation id="+affectation_id);
				}else {
					session.setAttribute("message_assignement_type", "danger");
					session.setAttribute("message_assignement", "Vous n'avez pas les privileges pour modifier cette affectation!");
					response.sendRedirect(request.getContextPath()+"/professor?assignement=all");
					return;
					
				}
			}else {
				session.setAttribute("message_assignement_type", "danger");
				session.setAttribute("message_assignement", "L'affectation dont id="+affectation_id+" n'éxiste pas!");
				response.sendRedirect(request.getContextPath()+"/professor?assignement=all");
				return;
			}
		}
		if( request.getParameter("mypaper") != null && request.getParameter("edit") != null && request.getParameterMap().size() == 2 ) {
			String mypapier_id = request.getParameter("mypaper");
			Papier pap = papierBusiness.find(Integer.parseInt(mypapier_id));
			if( pap != null ) {
				if( pap.getUser().getUser_id() == professeur.getUser_id() ) {
					String message = "";
					System.out.println("ETAT: "+pap.getEtat());
					Inscription inscription = inscriptionBusiness.findByUserId(professeur.getUser_id());
					if( inscription != null && inscription.getSession().getId() == pap.getSession().getId() && !pap.getEtat().equals("") ){ 
						if( pap.getEtat().equals("refuse") ){
								message = "Votre papier à été refusé.";
						}
						else{
								message = "Votre papier à été accepté, la modification est impossible!";
						}
						session.setAttribute("message_mypaper_type", "warning");
						session.setAttribute("message_mypaper", message);
						response.sendRedirect(request.getContextPath()+"/professor?mypaper=all");
						return;
					}else {
						String description = pap.getDescription().replaceAll("(\r\n|\n)", "<br/>");
						pap.setDescription(description);
						System.out.println(pap.getDescription());
						session.setAttribute("mypaper_edit", pap);
						session.setAttribute("message_mypaper_edit_type", "info");
						session.setAttribute("message_mypaper_edit", "Modification de papier id="+mypapier_id);
					}
				}else {
					session.setAttribute("message_mypaper_type", "danger");
					session.setAttribute("message_mypaper", "Le papier dont id="+mypapier_id+" n'est pas votre papier!");
					response.sendRedirect(request.getContextPath()+"/professor?mypaper=all");
					return;	
				}
			}else {
				session.setAttribute("message_mypaper_type", "danger");
				session.setAttribute("message_mypaper", "Le papier dont id="+mypapier_id+" n'éxiste pas!");
				response.sendRedirect(request.getContextPath()+"/professor?mypaper=all");
				return;
			}
		}
		if( request.getParameter("paper") != null && request.getParameter("edit") != null && request.getParameterMap().size() == 2 ) {
			String papier_id = request.getParameter("paper");
			Papier pap = papierBusiness.find(Integer.parseInt(papier_id));
			if( pap != null ) {
				Session ses = pap.getSession();
				boolean is_member = false;
				List<Comite> comites = (List<Comite>)comiteBusiness.findBySessionId(ses.getId());
				for( Comite comite : comites ) {
					if( comite.getProfesseur_id() == professeur.getProfesseur_id() ) {
						is_member = true;
						break;
					}
				}
				if( professeur.getProfesseur_id() == ses.getPresident().getProfesseur_id() || is_member ) {
					String description = pap.getDescription().replaceAll("(\r\n|\n)", "<br/>");
					pap.setDescription(description);
					session.setAttribute("paper_edit", pap);
					session.setAttribute("message_paper_edit_type", "info");
					session.setAttribute("message_paper_edit", "Modification de papier id="+papier_id);
				}else {
					session.setAttribute("message_paper_type", "danger");
					session.setAttribute("message_paper", "Le papier dont id="+pap.getId()+" s'appartient à une session ou vous n'êtes ni comité ni président!");
					response.sendRedirect(request.getContextPath()+"/professor?paper=all");
					return;
				}
			}else {
				session.setAttribute("message_paper_type", "danger");
				session.setAttribute("message_paper", "Le papier dont id="+papier_id+" n'éxiste pas!");
				response.sendRedirect(request.getContextPath()+"/professor?paper=all");
				return;
			}
		}
		if( request.getParameter("addassignement") != null && request.getParameterMap().size() == 1 ) {
			List<Session> sessions = (List<Session>)sessionBusiness.findAll();
			boolean is_president = false;
			for( Session s : sessions ) {
				if( s.getPresident().getProfesseur_id() == professeur.getProfesseur_id() ) {
					is_president = true;
				}
			}
			if( !is_president ) {
				session.setAttribute("message_assignement_type", "danger");
				session.setAttribute("message_assignement", "Vous n'avez pas les previleges pour ajouter une affectation!");
				response.sendRedirect(request.getContextPath()+"/professor?assignement=all");
				return;
			}

		}
	}
	
	private void checkifadmin(User user, HttpServletRequest request, HttpServletResponse response) {
		boolean found = false;
		for( Administrateur admin : this.administrateurBusiness.findAll() ) {
			if( admin.getUser_id() == user.getUser_id() ) {
				found = true;
			}
		}
		try {
			if( found ) {
				response.sendRedirect(request.getContextPath()+"/profile");
				return;
			}
		}
		catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
	
	
	
	
	
	
	
	
	
	
	

}
