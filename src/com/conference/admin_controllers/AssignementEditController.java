package com.conference.admin_controllers;

import java.sql.Connection;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.conference.business.IAffectation;
import com.conference.business.IComite;
import com.conference.business.IPapier;
import com.conference.dao.AffectationDAO;
import com.conference.dao.ComiteDAO;
import com.conference.dao.ConfigDB;
import com.conference.dao.PapierDAO;
import com.conference.entities.Affectation;
import com.conference.entities.Comite;
import com.conference.entities.Papier;

@WebServlet("/profile/updateassignement")
public class AssignementEditController extends HttpServlet {

	private IAffectation affectationBusiness;
	private IPapier papierBusiness;
	private IComite comiteBusiness;
	
	public void init( ){
		
		//======================= DATABASE PARAMETERS ======================= 
		ServletContext sc = this.getServletContext();
		String driver = sc.getInitParameter("driver");
		String url = sc.getInitParameter("url");
		String db_user = sc.getInitParameter("db_user");
		String db_password = sc.getInitParameter("db_password");
		Connection connection = ConfigDB.getInstance().getConnection(driver, url, db_user, db_password);
		this.affectationBusiness = new AffectationDAO(connection);
		this.comiteBusiness = new ComiteDAO(connection);
		this.papierBusiness = new PapierDAO(connection);
		
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.sendRedirect(request.getContextPath()+"/profile?assignement=all");
		}
		catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		try {
				String affectation_id = request.getParameter("assignement_id");
				String comite_id = request.getParameter("comite_id");
				Affectation affectation = affectationBusiness.find(Integer.parseInt(affectation_id));
				Comite comite = comiteBusiness.find(Integer.parseInt(comite_id));
				Papier papier = affectation.getPapier();
				affectation.setComite(comite);
				
				boolean is_updated = affectationBusiness.update(affectation);
				
				if( is_updated ) {
					session.setAttribute("message_assignement_type", "success");
					session.setAttribute("message_assignement", "Le papier "+papier.getTitre()+" est affecté au professeur "+comite.fullname()+" avec succée");
					response.sendRedirect(request.getContextPath()+"/profile?assignement=all");
				}else {
					session.setAttribute("message_assignement_edit_type", "danger");
					session.setAttribute("message_assignement_edit", "le papier choisit est déja affecté!");
					response.sendRedirect(request.getContextPath()+"/profile?assignement="+affectation_id+"&edit");
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
