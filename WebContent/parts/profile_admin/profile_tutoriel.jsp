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
ITutoriel tutorielBusiness = (TutorielDAO)session.getAttribute("tutorielBusiness");

Tutoriel tutoriel_search = (Tutoriel)session.getAttribute("tutoriel");
User us_search1 = (User)request.getAttribute("user_search");
Session ses_search = (Session)request.getAttribute("session");

User us = (User)session.getAttribute("user");
Professeur prof = (Professeur)session.getAttribute("professeur");
Administrateur admin = (Administrateur)session.getAttribute("administrateur");
List<Tutoriel> tutos = (List<Tutoriel>)tutorielBusiness.findAll();



%>

			<form style="margin-bottom: 2%;">
				<div class="input-group">
				  <span class="input-group-addon" id="sizing-addon2">ID</span>
				  <input type="number" value="<%= request.getParameter("tutoriel") %>" class="form-control" placeholder="ID TUTORIEL" name="tutoriel" aria-describedby="sizing-addon2">
				</div>
			</form>
		
		
			<% if( request.getParameter("tutoriel").equals("") || request.getParameter("tutoriel").equals("all") ){ %>	
			<div class="">
			
			
			 	<div class="row" style="width: 95%; margin-left: auto;margin-right: auto;">
	                	<% if( session.getAttribute("message_tutoriel") != null ){ %>
							<div class="alert alert-<%= session.getAttribute("message_tutoriel_type") %> text-center alert-dismissible" role="alert">
							  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							  <strong><i class="fas fa-info-circle"></i> <%= session.getAttribute("message_tutoriel") %></strong>
							</div>
							<%
								session.removeAttribute("message_tutoriel");
								session.removeAttribute("message_tutoriel_type");
							%>
						<% } %>
	                </div>
	                
	                
				
				<div class="panel panel-primary">
				  <!-- Default panel contents -->
				  <div class="panel-heading">Tutoriels Management</div>
				  <div class="panel-body text-center">
				    <p>Il y a <%= tutos.size() %> tutoriels(s) </p>
				    				
				    				<a href="<%= request.getAttribute("page_url") %>?addtutoriel"><button class="btn btn-info btn-lg"><i class="fas fa-folder-plus"></i> Ajouter tutoriel</button></a>
				   
				  </div>
				<div class="table-responsive">
				  			<!-- Table -->
				  						
							<table class="table table-hover table-bordered table-striped" id="dev-table">
								<thead>
								<tr class="success">
									<th class="text-center">#</th>
									<th class="text-center">Titre</th>
									<th class="text-center">Description</th>
									<th class="text-center">Conference | N°</th>
									<th class="text-center" colspan="2">Actions</th>
								</tr>
								</thead>
								<tbody>
								<% for( Tutoriel tutoriel : tutos ){ %>
									<tr class="text-center">
										<td><strong><%= tutoriel.getId() %></strong></td>
										<td><%= tutoriel.getTitre() %></td>
										<td><%= tutoriel.getDescription() %></td>
										<td><%= tutoriel.getConference().getTitre() %> | <%= tutoriel.getConference().getId() %></td>
										<td>
											<form action="<%= request.getAttribute("page_url") %>/deletetutoriel" method="post" id="del_tutoriel<%=tutoriel.getId()%>"><input type="hidden" name="tutoriel_id" value="<%= tutoriel.getId() %>" /></form>
											  <button type="button" onclick="deleteRow('del_tutoriel<%=tutoriel.getId()%>', 'tutoriel');" class="btn btn-danger"><i class="far fa-trash-alt"></i> Supprimer</button>
										</td>
										<td>
											  <a href="<%= request.getAttribute("page_url") %>?tutoriel=<%= tutoriel.getId() %>&edit"><button class="btn btn-primary"><i class="fas fa-edit"></i> Modifier</button></a>
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
				  <div class="panel-heading">Tutoriels Management</div>
				  <div class="panel-body text-center">
				    <p>Il y a <%= tutos.size() %> tutoriels(s) </p>
				    				
				    				<a href="<%= request.getAttribute("page_url") %>?addtutoriel"><button class="btn btn-info btn-lg"><i class="fas fa-folder-plus"></i> Ajouter tutoriel</button></a>
				   
				  </div>
				<div class="table-responsive" >
				  			<!-- Table -->
				  						
							<table class="table table-hover table-bordered table-striped" id="dev-table">
								<thead>
								<tr class="success">
									<th class="text-center">#</th>
									<th class="text-center">Titre</th>
									<th class="text-center">Description</th>
									<th class="text-center">Conference | N°</th>
									<th class="text-center" colspan="2">Actions</th>
								</tr>
								</thead>
								<tbody>
								<% if( tutoriel_search != null ){ %>
									<tr class="text-center">
										<td><strong><%= tutoriel_search.getId() %></strong></td>
										<td><%= tutoriel_search.getTitre() %></td>
										<td><%= tutoriel_search.getDescription() %></td>
										<td><%= tutoriel_search.getConference().getTitre() %> | <%= tutoriel_search.getConference().getId() %></td>
										<td>
											<form action="<%= request.getAttribute("page_url") %>/deletetutoriel" method="post" id="del_tutoriel<%=tutoriel_search.getId()%>"><input type="hidden" name="tutoriel_id" value="<%= tutoriel_search.getId() %>" /></form>
											  <button type="button" onclick="deleteRow('del_tutoriel<%=tutoriel_search.getId()%>', 'tutoriel');" class="btn btn-danger"><i class="far fa-trash-alt"></i> Supprimer</button>
										</td>
										<td>
											  <a href="<%= request.getAttribute("page_url") %>?tutoriel=<%= tutoriel_search.getId() %>&edit"><button class="btn btn-primary"><i class="fas fa-edit"></i> Modifier</button></a>
										</td>
									</tr>
								<% }else{ %>
									<td class="alert alert-danger text-center" colspan="5">
										<strong><i class="fas fa-info-circle"></i> Aucun enregistrement à afficher</strong>
									</td>
								<% } %>
								</tbody>
							</table>
					</div>
				</div>
				</div>
			<% } %>