package com.conference.admin_controllers;

import java.io.File;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.conference.business.IUser;
import com.conference.dao.ConfigDB;
import com.conference.dao.UserDAO;
import com.conference.entities.User;

@WebServlet("/profile/updatesettings")
public class UserSettingsController extends HttpServlet{

	private boolean isMultipart;
	private String filePath;
	private int maxFileSize = 100 * 1024;
	private int maxMemSize = 8 * 1024;
	private File file ;
	private String LOCAL_DIR;
	private IUser userBusiness;

	public void init( ){
		
		//======================= DATABASE PARAMETERS ======================= 
		ServletContext sc = this.getServletContext();
		String driver = sc.getInitParameter("driver");
		String url = sc.getInitParameter("url");
		String db_user = sc.getInitParameter("db_user");
		String db_password = sc.getInitParameter("db_password");
		Connection connection = ConfigDB.getInstance().getConnection(driver, url, db_user, db_password);
		this.userBusiness = new UserDAO(connection);
		//======================= SAVE DIR PARAMETERS ======================= 	
		LOCAL_DIR = "media/images/";
		filePath = getServletContext().getInitParameter("APPDIR")+LOCAL_DIR; 
		
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.sendRedirect(request.getContextPath()+"/profile");
		}
		catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		try {
			HttpSession session = request.getSession();
			
			if( !isConnected(session) ) {
				response.sendRedirect(request.getContextPath()+"/login");
				return;
			}
			
			String e_mail = (String)session.getAttribute("email");
			String pass = (String)session.getAttribute("password");

			User user = userBusiness.find(e_mail, pass);
			System.out.println("User: "+user);
		
			if( user != null ) {
				
				updateSettings(request, response, user, session);
				
			}else {
				request.setAttribute("error", true);
				request.setAttribute("message", "L'adresse email ou mot de passe incorrect, veuillez ressayer!");
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
	
	private void updateSettings(HttpServletRequest request, HttpServletResponse response, User user, HttpSession session) {
		try {
			
		
		Map<String, String> dict = new HashMap<>();
		// Check that we have a file upload request
	      isMultipart = ServletFileUpload.isMultipartContent(request);

	      if( !isMultipart ) {
	    	session.setAttribute("message_settings_type", "danger");
			session.setAttribute("message_settings", "Une erreur est survenue, veuillez verifier les champs puis ressayer!");
	        response.sendRedirect(request.getContextPath()+"/profile?settings");
	        return;
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
	               // Rename file to have unique file per user
	               String file_extension = fileName.substring(fileName.lastIndexOf(".")+1, fileName.length());
	               String new_file_name = String.format("userPic%s.%s",  user.getUser_id()+user.fullname(), file_extension);
	               File temp_file = new File(file.getParentFile(), new_file_name);
	               
	               fi.write( temp_file ) ;
	               dict.put(fi.getFieldName(), LOCAL_DIR+temp_file.getName());
	               
	            }else {
	            	String fieldname = fi.getFieldName();
	                String fieldvalue = fi.getString();
	                dict.put(fieldname, fieldvalue);
	            }
	         }
	         for( Entry<String, String> p : dict.entrySet() ) {
	        	 if( p.getKey().equals("username") ) {
	        		 user.setUsername(p.getValue());
	        	 }else if( p.getKey().equals("nom") ) {
	        		 user.setNom(p.getValue());
	        	 }else if( p.getKey().equals("prenom") ) {
	        		 user.setPrenom(p.getValue());	 
	        	 }else if( p.getKey().equals("email") ) {
	        		 user.setEmail(p.getValue());
	        	 }else if( p.getKey().equals("password") ) {
	        		 user.setPassword(p.getValue());
	        	 }else if( p.getKey().equals("telephone") ) {
	        		 user.setTelephone(p.getValue());
	        	 }else if( p.getKey().equals("image") ) {
	        		 user.setImage(p.getValue());
	        	 }
	         }
	         boolean is_updated = userBusiness.update(user);
	         System.out.println("is updated: "+is_updated);
	         if( is_updated ) {
	 	        session.setAttribute("message_settings_type", "success");
				session.setAttribute("message_settings", "vos parametres sont enregistrés avec succé");
	        	session.setAttribute("email", user.getEmail());
	        	session.setAttribute("password", user.getPassword());
	        	session.setAttribute("username", user.getUsername());
	        	System.out.println(user.getImage());
		        response.sendRedirect(request.getContextPath()+"/profile?settings");
	         }else {
	 	        session.setAttribute("message_settings_type", "danger");
				session.setAttribute("message_settings", "Une erreur est survenue, veuillez verifier les champs puis ressayer!");
		        response.sendRedirect(request.getContextPath()+"/profile?settings");
	         }
		}
		catch(Exception ex) {
	    	session.setAttribute("message_settings_type", "danger");
			session.setAttribute("message_settings", "Une erreur est survenue, veuillez verifier les champs puis ressayer!");
	        try {
	        	System.out.println(ex.getMessage());
	        	response.sendRedirect(request.getContextPath()+"/profile?settings");
	        	return;
	        }
	        catch(Exception e) {
	        	System.out.println(e.getMessage());
	        }
		}
	}
	
}
