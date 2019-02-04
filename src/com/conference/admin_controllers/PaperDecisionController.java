package com.conference.admin_controllers;

import java.sql.Connection;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.conference.business.IPapier;
import com.conference.dao.ConfigDB;
import com.conference.dao.PapierDAO;
import com.conference.entities.Papier;

@WebServlet("/profile/paperdecide")
public class PaperDecisionController extends HttpServlet {
	
	private IPapier papierBusiness;
	
	public void init( ){
		
		//======================= DATABASE PARAMETERS ======================= 
		ServletContext sc = this.getServletContext();
		String driver = sc.getInitParameter("driver");
		String url = sc.getInitParameter("url");
		String db_user = sc.getInitParameter("db_user");
		String db_password = sc.getInitParameter("db_password");
		Connection connection = ConfigDB.getInstance().getConnection(driver, url, db_user, db_password);
		this.papierBusiness = new PapierDAO(connection);
		
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.sendRedirect(request.getContextPath()+"/profile?paper=all");
		}
		catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		try {
			System.out.println("HALLO");
			String paper_id = request.getParameter("paper_id");
			String decision = request.getParameter("decision");
			
			Papier papier = papierBusiness.find(Integer.parseInt(paper_id));
			boolean is_state_changed = false;
			String action ="";
			switch(decision) {
			case "0":
				papier.setEtat("refuse");
				is_state_changed = papierBusiness.update(papier);
				action = "refusé";
				break;
			case "1":
				papier.setEtat("accepte");
				is_state_changed = papierBusiness.update(papier);
				action = "accepté";
				break;
			case "2":
				papier.setEtat("poste");
				is_state_changed = papierBusiness.update(papier);
				action = "posté";
				break;
			}
			if( is_state_changed ) {
				session.setAttribute("message_paper_type", "success");
				session.setAttribute("message_paper", "Le papier dont id="+papier.getId()+" de "+papier.getUser().fullname()+" à été "+action);
			}else {
				session.setAttribute("message_paper_type", "danger");
				session.setAttribute("message_paper", "Une erreur est survenue, veuillez ressayer!");
			}	
			//============ Redirect Admin to submitted papers ============ 
			response.sendRedirect(request.getContextPath()+"/profile?paper=all");
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
