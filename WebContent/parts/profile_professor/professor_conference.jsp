<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.conference.entities.*" %>
<%@ page import="com.conference.dao.*" %>
<%@ page import="com.conference.business.*" %>
<%@ page import="java.util.*" %>
<%@page import="com.conference.entities.*" %>

<%
IUser userBusiness1 = (UserDAO)session.getAttribute("userBusiness");
IProfesseur professeurBusiness1 = (ProfesseurDAO)session.getAttribute("professeurBusiness");
IAdministrateur administrateurBusiness1 = (AdministrateurDAO)session.getAttribute("administrateurBusiness");
IConference conferenceBusiness1 = (ConferenceDAO)session.getAttribute("conferenceBusiness");
ISession sessBus = (SessionDAO)session.getAttribute("sessionBusiness");
IComite comiteBus = (ComiteDAO)session.getAttribute("comiteBusiness");
IPapier papBus = (PapierDAO)session.getAttribute("papierBusiness");

Conference confer_search = (Conference)request.getAttribute("conference");
User us_search1 = (User)request.getAttribute("user_search");
Session ses_search = (Session)request.getAttribute("session");


User us = (User)session.getAttribute("user");
Professeur prof = (Professeur)session.getAttribute("professeur");



List<Conference> conf_s = (List<Conference>)session.getAttribute("conferences");




%>

			<form style="margin-bottom: 2%;">
				<div class="input-group">
				  <span class="input-group-addon" id="sizing-addon2">ID</span>
				  <input type="number" value="<%= request.getParameter("conference") %>" class="form-control" placeholder="ID CONFERENCE" name="conference" aria-describedby="sizing-addon2">
				</div>
			</form>
		
		
			<% if( request.getParameter("conference").equals("") || request.getParameter("conference").equals("all") ){ %>	
			
				<div class="">
			 	<div class="row" style="width: 95%; margin-left: auto;margin-right: auto;">
	                	<% if( session.getAttribute("message_conference") != null ){ %>
							<div class="alert alert-<%= session.getAttribute("message_conference_type") %> text-center alert-dismissible" role="alert">
							  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							  <strong><i class="fas fa-info-circle"></i> <%= session.getAttribute("message_conference") %></strong>
							</div>
							<%
								session.removeAttribute("message_conference");
								session.removeAttribute("message_conference_type");
							%>
						<% } %>
	             </div>
	                
	                	<% if( conf_s.size() > 0 ){ %>
	                	
	                	<% for( Conference conf : conf_s ){ %>
	                	<div class="col-md-4 col-sm-12 col-lg-4 col-xs-12 text-center" style="padding-bottom: 2%;">
	                		<div class="card" style=" border: 1px solid black;  box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19); ">
							  <img src="<%= conf.getConverture() %>" class="card-img-top img-thumbnail" alt="<%= conf.getTitre() %>">
							  <div class="card-body" style=" background-color: aliceblue; padding: 5%;">
							    <h5 class="card-title" style="color: #ec5544"><%= conf.getTitre() %></h5>
							    <% if( conf.getDescription().length() > 90 ){ %>
							    	<p class="card-text"><%= conf.getDescription().substring(0, 90) %>...</p>
							    <% }else{ %>
							    	<p class="card-text"><%= conf.getDescription() %></p>
							    <% } %>
							    <a href="<%= request.getContextPath() %>/conference?id=<%= conf.getId() %>" target="_blank" class="btn btn-primary"><i class="far fa-eye"></i> Voir</a>
							  </div>
							</div>
							</div>
	                	<% }}else{ %>
	                		<div class="alert alert-warning text-center" style="width: 90%; margin-left: auto;margin-right: auto;">
	                			<i class="fas fa-exclamation-triangle"></i> AUCUNE CONFÉRENCE TROUVÉE
	                		</div>
	                	<% } %>
				</div>
				
			<% }else{ %>
				<div class=" text-center">
					<% if( confer_search != null ){ %>
                		<div class="card" style="width: 18rem;">
						  <img src="<%= confer_search.getConverture() %>" class="card-img-top  img-thumbnail" alt="<%= confer_search.getTitre() %>">
						  <div class="card-body">
						    <h5 class="card-title"><%= confer_search.getTitre() %></h5>
							    <% if( confer_search.getDescription().length() > 90 ){ %>
							    	<p class="card-text"><%= confer_search.getDescription().substring(0, 90) %>...</p>
							    <% }else{ %>
							    	<p class="card-text"><%= confer_search.getDescription() %></p>
							    <% } %>
						    <a href="<%= request.getContextPath() %>/conference?id=<%= confer_search.getId() %>" target="_blank" class="btn btn-primary"><i class="far fa-eye"></i> Voir</a>
						  </div>
						</div>
                	<% }else{ %>
                		<div class="alert alert-warning text-center" style="width: 90%; margin-left: auto;margin-right: auto;">
                			<i class="fas fa-exclamation-triangle"></i> AUCUNE CONFÉRENCE TROUVÉE
                		</div>
                	<% } %>
				</div>
			<% } %>

			
			
			