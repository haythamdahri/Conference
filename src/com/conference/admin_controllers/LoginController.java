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
import com.conference.entities.Professeur;
import com.conference.entities.User;

@WebServlet("/login")
public class LoginController extends HttpServlet{
	
	private IUser userBusiness;
	private IProfesseur professeurBusiness;
	private IAdministrateur administrateurBusiness;
	
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
	   
	}
	
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			HttpSession session = request.getSession();
			if( isConnected(session) ) {
				response.sendRedirect(request.getContextPath()+"/profile");
				return;
			}
			if( !response.isCommitted() )
				request.getRequestDispatcher("login.jsp").forward(request, response);
		}
		catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		try {
			HttpSession session = request.getSession();
			
			if( isConnected(session) ) {
				response.sendRedirect(request.getContextPath()+"/profile");
				return;
			}
			String e_mail = request.getParameter("email");
			String pass = request.getParameter("password");
			
			User user = userBusiness.find(e_mail, pass);			
			if( user != null ) {
				Professeur prof = professeurBusiness.findByUserId(user.getUser_id());
				if( prof == null ) {
					request.setAttribute("error", true);
					request.setAttribute("message", "Votre compte n'est pas encore approuvé, veuillez patienter!");
					if ( !response.isCommitted())
						request.getRequestDispatcher("login.jsp").forward(request, response);
				}else {
					Administrateur admin = administrateurBusiness.findByProfesseurId(prof.getProfesseur_id());
					if( admin != null ) {
						session.setAttribute("profile_path", request.getContextPath()+"/profile");
					}else {
						session.setAttribute("profile_path", request.getContextPath()+"/professor");
					}
					session.setAttribute("email", e_mail);
					session.setAttribute("password", pass);
					session.setAttribute("username", user.getUsername());
					response.sendRedirect(request.getContextPath()+"/profile");
					return;
				}
			}else {
				request.setAttribute("error", true);
				request.setAttribute("message", "L'adresse email ou mot de passe incorrect, veuillez ressayer!");
				if( !response.isCommitted() )
					request.getRequestDispatcher("login.jsp").forward(request, response);
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
