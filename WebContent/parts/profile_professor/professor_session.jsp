<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.conference.entities.*" %>
<%@ page import="com.conference.dao.*" %>
<%@ page import="com.conference.business.*" %>
<%@ page import="java.util.*" %>
<%@page import="com.conference.entities.*" %>

<%
IUser userBusiness1 = (UserDAO)session.getAttribute("userBusiness");
IProfesseur professeurBusiness1 = (ProfesseurDAO)session.getAttribute("professeurBusiness");
ISession sessionBus = (SessionDAO)session.getAttribute("sessionBusiness");
IComite comiteBus = (ComiteDAO)session.getAttribute("comiteBusiness");

Session ses_search = (Session)request.getAttribute("session");

User user_r = (User)session.getAttribute("user");

Professeur prof = (Professeur)session.getAttribute("professeur");

List<Session> sessions = (List<Session>)sessionBus.findAll();
%>

<% if( request.getParameter("session").equals("all") || request.getParameter("session").equals("") ){ %>
			<div >
			
			
	                <div class="row" style="width: 95%; margin-left: auto;margin-right: auto;">
	                	<% if( session.getAttribute("message_session") != null ){ %>
							<div class="alert alert-<%= session.getAttribute("message_session_type") %> text-center alert-dismissible" role="alert">
							  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							  <strong><i class="fas fa-info-circle"></i> <%= session.getAttribute("message_session") %></strong>
							</div>
							<%
								session.removeAttribute("message_session");
								session.removeAttribute("message_session_type");
							%>
						<% } %>
	                </div>
			
			<div class="panel panel-primary">
			  <!-- Default panel contents -->
			  <div class="panel-heading">Sessions Management</div>
			  <div class="panel-body text-center">
			    <p>Il y a <%= sessions.size() %> session(s) en totale.</p>
			  </div>
			<div class="table-responsive">
			  			<!-- Table -->
			  						
						<table class="table table-hover table-bordered table-striped">
							<thead>
							<tr class="success">
								<th class="text-center">#</th>
								<th class="text-center">Titre</th>
								<th class="text-center">Date début</th>
								<th class="text-center">Date fin</th>
								<th class="text-center">conférence | N°</th>
								<th class="text-center">president | N°</th>
								<th class="text-center">Actions</th>
							</tr>
							</thead>
							<tbody>
							<% if( sessions.size() > 0 ){ %>
							<% for( Session ses : sessions ){ %>
								<tr class="text-center">
									<td><strong><%= ses.getId() %></strong></td>
									<td><%= ses.getTitre() %></td>
									<td><%= ses.getDate_start_session() %></td>
									<td><%= ses.getDate_end_session() %></td>
									<td><%= ses.getConference().getTitre()+" | "+ses.getConference().getId() %></td>
									<td>
										<% if( ses.getPresident() != null ){ %>
											<%= ses.getPresident().fullname()+" | "+ses.getPresident().getPresident_id() %>
										<% }else{ %>
											Aucun président n'était selectionné!
										<% } %>
									</td>
									<% if( ses.getPresident().getProfesseur_id() == prof.getProfesseur_id() ){ %>
									<td>
										  <a href="<%= request.getAttribute("page_url") %>?session=<%= ses.getId()%>&edit"><button class="btn btn-primary"><i class="fas fa-edit"></i> Modifier</button></a>
									</td>
									<% }else{ %>
										<td class="alert alert-warning">AUCUN PRIVILEGE</td>
									<% } %>
								</tr>
								<% }}else{ %>
									<td class="alert alert-warning text-center" colspan="7">AUCUN PRIVILEGE</td>
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
			  <div class="panel-heading">Sessions Management</div>
			  <div class="panel-body text-center">
			    <p>Il y a <%= sessions.size() %> sessions en totale.</p>
			  </div>
			<div class="table-responsive">
			  			<!-- Table -->
			  						
						<table class="table table-hover table-bordered table-striped">
							<thead>
							<tr class="success">
								<th class="text-center">#</th>
								<th class="text-center">Titre</th>
								<th class="text-center">Date début</th>
								<th class="text-center">Date fin</th>
								<th class="text-center">conférence | N°</th>
								<th class="text-center">president | N°</th>
								<th class="text-center">Actions</th>
							</tr>
							</thead>
							<tbody>
							<% if( ses_search != null ){ %>
								<tr class="text-center">
									<td><strong><%= ses_search.getId() %></strong></td>
									<td><%= ses_search.getTitre() %></td>
									<td><%= ses_search.getDate_start_session() %></td>
									<td><%= ses_search.getDate_end_session() %></td>
									<td><%= ses_search.getConference().getTitre()+" | "+ses_search.getConference().getId() %></td>
									<td>
										<% if( ses_search.getPresident() != null ){ %>
											<%= ses_search.getPresident().fullname()+" | "+ses_search.getPresident().getPresident_id() %>
										<% }else{ %>
											Aucun président n'était selectionné!
										<% } %>
									</td>
									<% if( ses_search.getPresident().getProfesseur_id() == prof.getProfesseur_id() ){ %>
									<td>
										  <a href="<%= request.getAttribute("page_url") %>?session=<%= ses_search.getId()%>&edit"><button class="btn btn-primary"><i class="fas fa-edit"></i> Modifier</button></a>
									</td>
									<% }else{ %>
										<td class="alert alert-warning">AUCUN PRIVILEGE</td>
									<% } %>
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