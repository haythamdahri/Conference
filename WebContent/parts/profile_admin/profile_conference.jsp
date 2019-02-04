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

Conference confer_search = (Conference)request.getAttribute("conference");
User us_search1 = (User)request.getAttribute("user_search");
Session ses_search = (Session)request.getAttribute("session");

User us = (User)session.getAttribute("user");
Professeur prof = (Professeur)session.getAttribute("professeur");
Administrateur admin = (Administrateur)session.getAttribute("administrateur");
List<Conference> conf_s = admin.getConferences();


List<Session> sess = new ArrayList<Session>();
 for( Conference conference : conf_s ){
	  sess.addAll(conference.getSessions());
	} 


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
	                
	                
				
				<div class="panel panel-primary">
				  <!-- Default panel contents -->
				  <div class="panel-heading">Conférences Management</div>
				  <div class="panel-body text-center">
				    <p>Il y a <%= conf_s.size() %> conférence(s) </p>
				    				
				    				<a href="<%= request.getAttribute("page_url") %>?addconference"><button class="btn btn-info btn-lg"><i class="fas fa-folder-plus"></i> Ajouter conference</button></a>
				   
				  </div>
				<div class="table-responsive">
				  			<!-- Table -->
				  						
							<table class="table table-hover table-bordered table-striped" id="dev-table">
								<thead>
								<tr class="success">
									<th class="text-center">#</th>
									<th class="text-center">Titre</th>
									<th class="text-center">Date</th>
									<th class="text-center">N° sessions</th>
									<th class="text-center">N° papiers soumis</th>
									<th class="text-center">N° comités</th>
									<th class="text-center" colspan="4">Actions</th>
								</tr>
								</thead>
								<tbody>
								<% for( Conference conference : conf_s ){ %>
									<tr class="text-center">
										<td><strong><%= conference.getId() %></strong></td>
										<td><%= conference.getTitre() %></td>
										<td><%= conference.getDate() %></td>
										<td><%= conference.getSessions().size() %></td>
										<td><%= conference.nbPapiersSoumis() %></td>
										<td><%= conference.nbComites() %></td>
										<td>
											<form action="<%= request.getAttribute("page_url") %>/deleteconference" method="post" id="del_conference<%=conference.getId()%>"><input type="hidden" name="conference_id" value="<%= conference.getId() %>" /></form>
											  <button type="button" onclick="deleteRow('del_conference<%=conference.getId()%>', 'conférence');" class="btn btn-danger"><i class="far fa-trash-alt"></i> Supprimer</button>
										</td>
										<td>
											  <a href="<%= request.getAttribute("page_url") %>?conference=<%= conference.getId() %>&edit"><button class="btn btn-primary"><i class="fas fa-edit"></i> Modifier</button></a>
										</td>
										<td>
											  <a href="<%= request.getContextPath() %>/conference?id=<%= conference.getId() %>" target="_blank"><button class="btn btn-info"><i class="far fa-eye"></i> Voir</button></a>
										</td>
									</tr>
									<% } %>
								</tbody>
							</table>
					</div>
				</div>
				</div>
			<% }else{ %>
				<div class="">
				
				<div class="panel panel-primary">
				  <!-- Default panel contents -->
				  <div class="panel-heading">Conférences Management</div>
				 <div class="panel-body text-center">
				    <p>Il y a <%= conf_s.size() %> conférence(s) </p>
				    				
				    				<a href="<%= request.getAttribute("page_url") %>?addconference"><button class="btn btn-info btn-lg"><i class="fas fa-folder-plus"></i> Ajouter conference</button></a>
				   
				  </div>
				<div class="table-responsive">
				  			<!-- Table -->
				  						
							<table class="table table-hover table-bordered table-striped" id="dev-table">
								<thead>
								<tr class="success">
									<th class="text-center">#</th>
									<th class="text-center">Titre</th>
									<th class="text-center">Date</th>
									<th class="text-center">N° sessions</th>
									<th class="text-center">N° papiers soumis</th>
									<th class="text-center">N° comités</th>
									<th class="text-center" colspan="3">Actions</th>
								</tr>
								</thead>
								<tbody>
								<% if( confer_search != null ){ %>
									<tr class="text-center">
										<td><strong><%= confer_search.getId() %></strong></td>
										<td><%= confer_search.getTitre() %></td>
										<td><%= confer_search.getDate() %></td>
										<td><%= confer_search.getSessions().size() %></td>
										<td><%= confer_search.nbPapiersSoumis() %></td>
										<td><%= confer_search.nbComites() %></td>
										<td>
											<form action="<%= request.getAttribute("page_url") %>/deleteconference" method="post" id="del_conference<%=confer_search.getId()%>"><input type="hidden" name="conference_id" value="<%= confer_search.getId() %>" /></form>
											  <button type="button" onclick="deleteRow('del_conference<%=confer_search.getId()%>', 'conférence');" class="btn btn-danger"><i class="far fa-trash-alt"></i> Supprimer</button>
										</td>
										<td>
											  <a href="<%= request.getAttribute("page_url") %>?conference=<%= confer_search.getId() %>&edit"><button class="btn btn-primary"><i class="fas fa-edit"></i> Modifier</button></a>
										</td>
										<td>
											  <a href="<%= request.getContextPath() %>/conference?id=<%= confer_search.getId() %>" target="_blank"><button class="btn btn-info"><i class="far fa-eye"></i> Voir</button></a>
										</td>
									</tr>
								<% }else{ %>
									<td class="alert alert-danger text-center" colspan="7">
										<strong><i class="fas fa-info-circle"></i> Aucun enregistrement à afficher</strong>
									</td>
								<% } %>
								</tbody>
							</table>
					</div>
				</div>
				</div>
			<% } %>