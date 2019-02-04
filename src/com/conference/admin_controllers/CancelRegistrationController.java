package com.conference.admin_controllers;

import java.io.IOException;
import java.sql.Connection;
import java.text.DecimalFormat;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.conference.business.IConference;
import com.conference.business.IInscription;
import com.conference.business.IUser;
import com.conference.dao.ConferenceDAO;
import com.conference.dao.ConfigDB;
import com.conference.dao.InscriptionDAO;
import com.conference.dao.UserDAO;
import com.conference.entities.Conference;
import com.conference.entities.Inscription;
import com.conference.entities.Papier;
import com.conference.entities.User;

@WebServlet("/profile/cancelregistration")
public class CancelRegistrationController extends HttpServlet {


	private IInscription inscriptionBusiness;
	
	public void init( ){
		
		//======================= DATABASE PARAMETERS ======================= 
		ServletContext sc = this.getServletContext();
		String driver = sc.getInitParameter("driver");
		String url = sc.getInitParameter("url");
		String db_user = sc.getInitParameter("db_user");
		String db_password = sc.getInitParameter("db_password");
		Connection connection = ConfigDB.getInstance().getConnection(driver, url, db_user, db_password);
		this.inscriptionBusiness = new InscriptionDAO(connection);
		
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.sendRedirect(request.getContextPath()+"/profile?registration=all");
		}
		catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		try {
				String inscription_id = request.getParameter("registration_id");
				Inscription inscription = inscriptionBusiness.find(Integer.parseInt(inscription_id));
				boolean is_deleted = inscriptionBusiness.delete(Integer.parseInt(inscription_id));

				if( is_deleted ) {
					session.setAttribute("message_inscription_type", "success");
					session.setAttribute("message_inscription", "Inscription de "+inscription.getUser().fullname()+" est annulée");
				}else {				
					session.setAttribute("message_inscription_type", "success");
					session.setAttribute("message_inscription", "Une erreur est survenue, veuillez ressayer!");
				}
				response.sendRedirect(request.getContextPath()+"/profile?registration=all");
		}
		catch(Exception ex) {
			try {
				response.sendRedirect(request.getContextPath());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	private boolean isConnected(HttpSession session) {
		if( session.getAttribute("email") != null && session.getAttribute("password") != null && session.getAttribute("username") != null)
			return true;
		return false;
	}
	
}
