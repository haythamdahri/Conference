package com.conference.admin_controllers;

import java.sql.Connection;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.conference.business.IAdministrateur;
import com.conference.business.IProfesseur;
import com.conference.business.IUser;
import com.conference.dao.AdministrateurDAO;
import com.conference.dao.ConfigDB;
import com.conference.dao.ProfesseurDAO;
import com.conference.dao.UserDAO;
import com.conference.entities.Administrateur;
import com.conference.entities.Papier;
import com.conference.entities.Professeur;
import com.conference.entities.Session;
import com.conference.entities.User;

@WebServlet("/profile/changeuserrole")
public class UserRoleUpdateController extends HttpServlet{
	
	private IUser userBusiness;
	private IAdministrateur administrateurBusiness;
	private IProfesseur professeurBusiness;

	public void init( ){
		
		//======================= DATABASE PARAMETERS ======================= 
		ServletContext sc = this.getServletContext();
		String driver = sc.getInitParameter("driver");
		String url = sc.getInitParameter("url");
		String db_user = sc.getInitParameter("db_user");
		String db_password = sc.getInitParameter("db_password");
		Connection connection = ConfigDB.getInstance().getConnection(driver, url, db_user, db_password);
		this.userBusiness = new UserDAO(connection);
		this.administrateurBusiness = new AdministrateurDAO(connection);
		this.professeurBusiness = new ProfesseurDAO(connection);
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.sendRedirect(request.getContextPath()+"/profile?user=all");
		}
		catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		try {
			String user_id = request.getParameter("user_id");
			String position = request.getParameter("position");
			User user = userBusiness.find(Integer.parseInt(user_id));

			switch( position ) {
			case "0":
				boolean is_delete = userBusiness.delete(Integer.parseInt(user_id));
				if( is_delete ) {
					session.setAttribute("message_user_type", "success");
					session.setAttribute("message_user", "L'utilisateur dont id="+user_id+" à été supprimé avec succé");
				}else {
					session.setAttribute("message_user_type", "danger");
					session.setAttribute("message_user", "Une erreur est survenue, veuillez ressayer!");
				}
				break;
			case "1":
				Professeur professor = professeurBusiness.findByUserId(Integer.parseInt(user_id));
				if( professor != null ) {
					Administrateur admin = administrateurBusiness.findByProfesseurId(professor.getProfesseur_id());
					boolean is_downgraded = administrateurBusiness.delete(admin.getAdmin_id());
					if( is_downgraded ) {
						session.setAttribute("message_user_type", "success");
						session.setAttribute("message_user", "L'utilisateur dont id="+user_id+" à été désigné en tant que professeur");
					}else {
						session.setAttribute("message_user_type", "danger");
						session.setAttribute("message_user", "Une erreur est survenue, veuillez ressayer!");
					}
				}else {
					Professeur professeur = new Professeur(0, "PROFESSEUR", user.getUser_id(), user.getUsername(), user.getNom(), user.getPrenom(), user.getEmail(), user.getPassword(), user.getTelephone(), user.getImage());
					Professeur returned_prof = professeurBusiness.add(professeur);
					if( returned_prof != null ) {
						session.setAttribute("message_user_type", "success");
						session.setAttribute("message_user", "L'utilisateur dont id="+user_id+" à été désigné en tant que professeur");
					}else {
						session.setAttribute("message_user_type", "danger");
						session.setAttribute("message_user", "Une erreur est survenue, veuillez ressayer!");
					}
				}
				break;
			case "2":
				Professeur prof = professeurBusiness.findByUserId(user.getUser_id());
				Administrateur admin = new Administrateur(0, prof.getProfesseur_id(), prof.getMetier(), prof.getUser_id(), prof.getUsername(), prof.getNom(), prof.getPrenom(), prof.getEmail(), prof.getPassword(), prof.getTelephone(), prof.getImage());
				Administrateur returned_admin = administrateurBusiness.add(admin);
				if( returned_admin != null ) {
					session.setAttribute("message_user_type", "success");
					session.setAttribute("message_user", "L'utilisateur dont id="+user_id+" à été désigné en tant qu'administrateur");
				}else {
					session.setAttribute("message_user_type", "danger");
					session.setAttribute("message_user", "Une erreur est survenue, veuillez ressayer!");
				}
				break;
			}
			//============ Redirect Admin to submitted papers ============ 
			response.sendRedirect(request.getContextPath()+"/profile?user=all");
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
