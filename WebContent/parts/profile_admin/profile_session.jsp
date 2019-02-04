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
User us_search = (User)request.getAttribute("user_search");
Session ses_search = (Session)request.getAttribute("session");

User user_r = (User)session.getAttribute("user");
Professeur prof = (Professeur)session.getAttribute("professeur");
Administrateur admin = (Administrateur)session.getAttribute("administrateur");
List<Conference> conf_s = admin.getConferences();

List<User> uss = (List<User>)request.getAttribute("users");

List<Session> sess = new ArrayList<Session>();
 for( Conference conference : conf_s ){
	  sess.addAll(conference.getSessions());
	} 


%>

<% if( request.getParameter("session").equals("all") || request.getParameter("session").equals("") ){ %>
			<div class="">
			
			
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
			    <p>Il y a <%= sess.size() %> session(s) en totale.</p>
				<a href="<%= request.getAttribute("page_url") %>?addsession"><button class="btn btn-info btn-lg"><i class="fas fa-folder-plus"></i> Ajouter session</button></a>
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
								<th class="text-center" colspan="2">Actions</th>
							</tr>
							</thead>
							<tbody>
							<% for( Session ses : sess ){ %>
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
									<td>
										<form action="<%= request.getAttribute("page_url") %>/deletesession" method="post" id="del_session<%=ses.getId()%>"><input type="hidden" name="session_id" value="<%= ses.getId() %>" /></form>
										  <button type="button" onclick="deleteRow('del_session<%=ses.getId()%>', 'session');" class="btn btn-danger"><i class="far fa-trash-alt"></i> Supprimer</button>
									</td>
									<td>
										  <a href="<%= request.getAttribute("page_url") %>?session=<%= ses.getId()%>&edit"><button class="btn btn-primary"><i class="fas fa-edit"></i> Modifier</button></a>
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
			  <div class="panel-heading">Sessions Management</div>
			  <div class="panel-body text-center">
			    <p>Il y a <%= sess.size() %> sessions en totale.</p>
				<a href="<%= request.getAttribute("page_url") %>?addsession"><button class="btn btn-info btn-lg"><i class="fas fa-folder-plus"></i> Ajouter session</button></a>
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
									<td>
										<form action="<%= request.getAttribute("page_url") %>/deletesession" method="post" id="del_session<%=ses_search.getId()%>"><input type="hidden" name="session_id" value="<%= ses_search.getId() %>" /></form>
										  <button type="button" onclick="deleteRow('del_session<%=ses_search.getId()%>', 'session');" class="btn btn-danger"><i class="far fa-trash-alt"></i> Supprimer</button>
									</td>
									<td>
										  <a href="<%= request.getAttribute("page_url") %>?session=<%= ses_search.getId()%>&edit"><button class="btn btn-primary"><i class="fas fa-edit"></i> Modifier</button></a>
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