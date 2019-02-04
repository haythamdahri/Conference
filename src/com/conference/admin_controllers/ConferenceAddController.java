package com.conference.admin_controllers;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.conference.business.IAdministrateur;
import com.conference.business.IConference;
import com.conference.business.IUser;
import com.conference.dao.AdministrateurDAO;
import com.conference.dao.ConferenceDAO;
import com.conference.dao.ConfigDB;
import com.conference.dao.UserDAO;
import com.conference.entities.Administrateur;
import com.conference.entities.Conference;


@WebServlet("/profile/addconference")
public class ConferenceAddController extends HttpServlet{
	
	private boolean isMultipart;
	private String filePath;
	private int maxFileSize = 4000 * 1024;
	private int maxMemSize = 200* 1024;
	private File file ;
	private String LOCAL_DIR;
	private IUser userBusiness;
	private IConference conferenceBusiness;
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
		this.conferenceBusiness = new ConferenceDAO(connection);
		this.administrateurBusiness = new AdministrateurDAO(connection);
		//======================= SAVE DIR PARAMETERS ======================= 	
		LOCAL_DIR = "media/images/";
		filePath = getServletContext().getInitParameter("APPDIR")+LOCAL_DIR; 
		
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.sendRedirect(request.getContextPath()+"/profile?conference=all");
		}
		catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		
		try {
			HttpSession session = request.getSession();
			if( !isConnected(session) ) {
				response.sendRedirect(request.getContextPath()+"/profile");
				return;
			}
			
			//======================= UPDATE CONFERENCE ======================= 
			Conference conference = new Conference();
			
			Map<String, String> dict = new HashMap<>();
			// Check that we have a file upload request
		      isMultipart = ServletFileUpload.isMultipartContent(request);
		   
		      if( !isMultipart ) {
		    	System.out.println("Aucun couverture n'etait recu");
		        request.setAttribute("error", true);
				request.setAttribute("message", "Une erreur est survenue, veuillez verifier les champs puis ressayer!");
		        request.getRequestDispatcher("register.jsp").forward(request, response); 
		      }
		      
		      DiskFileItemFactory factory = new DiskFileItemFactory();
		      
		      // maximum size that will be stored in memory
		      factory.setSizeThreshold(maxMemSize);
		   
		      // Location to save data that is larger than maxMemSize.
		      factory.setRepository(new File(this.filePath));

		      // Create a new file upload handler
		      ServletFileUpload upload = new ServletFileUpload(factory);
		   
		      // maximum file size to be uploaded.
		      upload.setSizeMax( maxFileSize );

		         // Parse the request to get file items.
		         List fileItems = upload.parseRequest(request);
			
		         // Process the uploaded file items
		         Iterator i = fileItems.iterator();
		   
		         while ( i.hasNext () ) {
		            FileItem fi = (FileItem)i.next();
		            if ( !fi.isFormField () ) {
		               // Get the uploaded file parameters
		               String fieldName = fi.getFieldName();
		               String fileName = fi.getName();
		               String contentType = fi.getContentType();
		               boolean isInMemory = fi.isInMemory();
		               long sizeInBytes = fi.getSize();
		            
		               // Write the file
		               if( fileName.lastIndexOf("\\") >= 0 ) {
		                  file = new File( filePath + fileName.substring( fileName.lastIndexOf("\\"))) ;
		               } else {
		                  file = new File( filePath + fileName.substring(fileName.lastIndexOf("\\")+1)) ;
		               }
		               
		               // Rename file to have unique file per conference
		               String file_extension = fileName.substring(fileName.lastIndexOf(".")+1, fileName.length());
		               SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");
		               String new_file_name = String.format("conferencePic%s.%s", sdf.format( new Date() ), file_extension);
		               File temp_file=new File(file.getParentFile(), new_file_name);
		          
		               fi.write( temp_file ) ;
		               dict.put(fi.getFieldName(), LOCAL_DIR+temp_file.getName());
		               
		            }else {
		            	String fieldname = fi.getFieldName();
		                String fieldvalue = fi.getString();
		                dict.put(fieldname, fieldvalue);
		            }
		         }
		         for( Entry<String, String> p : dict.entrySet() ) {
		        	 if( p.getKey().equals("administrateur_id") ) {
		        		 Administrateur admin = administrateurBusiness.find(Integer.parseInt(p.getValue()));
		        		 System.out.println("ADMIN: "+admin);
		        		 conference.setAdministrateur(admin);
		        	 }else if( p.getKey().equals("titre") ) {
		        		 conference.setTitre(p.getValue());
		        	 }else if( p.getKey().equals("description") ) {
		        		 conference.setDescription(p.getValue());
		        	 }else if( p.getKey().equals("date_start_soumis") ) {
		        		 conference.setDate_start_soumis((new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(p.getValue())));
		        	 }else if( p.getKey().equals("date_end_soumis") ) {
		        		 conference.setDate_end_soumis((new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(p.getValue())));
		        	 }else if( p.getKey().equals("adresse") ) {
		        		 conference.setAdresse(p.getValue());
		        	 }else if( p.getKey().equals("telephone") ) {
		        		 conference.setTelephone(p.getValue());
		        	 }else if( p.getKey().equals("date") ) {
		        		 conference.setDate((new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(p.getValue())));
		        	 }else if( p.getKey().equals("email") ) {
		        		 conference.setEmail(p.getValue());
		        	 }else if( p.getKey().equals("couverture") ) {
		        		 conference.setConverture(p.getValue());
		        	 }
		         }
		         //==================== RETRIEVE CONFERENCE FROM DATABASE ==================== 
		         Conference added_conference = conferenceBusiness.add(conference);
		        		 
		         if( added_conference != null ) {
					session.setAttribute("message_conference_type", "success");
					session.setAttribute("message_conference", "La conference est ajoutée avec succé");
					response.sendRedirect(request.getContextPath()+"/profile?conference=all");
		         }else {
					session.setAttribute("message_conference_type", "danger");
					session.setAttribute("message_conference", "Une erreur est survenue, veuillez ressayer!");
					response.sendRedirect(request.getContextPath()+"/profile?addconference");
		         }


		      
			} catch (Exception e) {
				// TODO Auto-generated catch block
		    	System.out.println(e.getMessage());
	        	request.setAttribute("error", true);
				request.setAttribute("message", "Une erreur est survenue, veuillez verifier les champs puis ressayer!");
				try {
					request.getRequestDispatcher("register.jsp").forward(request, response);
				} catch (ServletException | IOException e1) {
					// TODO Auto-generated catch block
					try {
						System.out.println(e.getMessage());
			        	request.setAttribute("error", true);
						request.setAttribute("message", "Une erreur est survenue, veuillez verifier les champs puis ressayer!");
						response.sendRedirect(request.getContextPath());
						return;
					} catch (IOException e2) {
						// TODO Auto-generated catch block
						e2.printStackTrace();
					}
				}
			}
	}
	
	private boolean isConnected(HttpSession session) {
		if( session.getAttribute("email") != null && session.getAttribute("password") != null && session.getAttribute("username") != null)
			return true;
		return false;
	}
}
