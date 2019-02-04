package com.conference.admin_controllers;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.conference.business.IConference;
import com.conference.business.IInscription;
import com.conference.business.IPapier;
import com.conference.business.IUser;
import com.conference.dao.ConferenceDAO;
import com.conference.dao.ConfigDB;
import com.conference.dao.InscriptionDAO;
import com.conference.dao.PapierDAO;
import com.conference.dao.UserDAO;
import com.conference.entities.Inscription;
import com.conference.entities.Papier;
import com.conference.entities.Session;
import com.conference.entities.User;

@WebServlet("/performregister")
public class RegisterPerformController extends HttpServlet {


	private IInscription inscriptionBusiness;
	private IUser userBusiness;
	private IConference conferenceBusiness;
	private IPapier papierBusiness;
	
	public void init( ){
		
		//======================= DATABASE PARAMETERS ======================= 
		ServletContext sc = this.getServletContext();
		String driver = sc.getInitParameter("driver");
		String url = sc.getInitParameter("url");
		String db_user = sc.getInitParameter("db_user");
		String db_password = sc.getInitParameter("db_password");
		Connection connection = ConfigDB.getInstance().getConnection(driver, url, db_user, db_password);
		this.inscriptionBusiness = new InscriptionDAO(connection);
		this.userBusiness = new UserDAO(connection);
		this.conferenceBusiness = new ConferenceDAO(connection);
		this.papierBusiness = new PapierDAO(connection);
		
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.sendRedirect(request.getContextPath());
		}
		catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		try {
				String mypaper_id = request.getParameter("mypaper_id");
				String user_id = request.getParameter("user_id");
				
				User user = userBusiness.find(Integer.parseInt(user_id));
				Papier papier = papierBusiness.find(Integer.parseInt(mypaper_id));
				Session ses = papier.getSession();
				
				Inscription inscription = new Inscription(user, ses);
				Inscription returned_inscription = inscriptionBusiness.add(inscription);

				if( returned_inscription != null ) {
					session.setAttribute("registration_done", true);
					response.sendRedirect(request.getContextPath()+"/conference?id="+papier.getSession().getConference().getId());
				}else {										
					session.setAttribute("registration_done", false);
					response.sendRedirect(request.getContextPath()+"/conference?id="+papier.getSession().getConference().getId());
				}
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
