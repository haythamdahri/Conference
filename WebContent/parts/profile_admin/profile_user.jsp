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

<% if( request.getParameter("user").equals("all") || request.getParameter("user").equals("") ){ %>
		
		<div class="">
		
		<div class="row" style="width: 95%; margin-left: auto;margin-right: auto;">
	                	<% if( session.getAttribute("message_user") != null ){ %>
							<div class="alert alert-<%= session.getAttribute("message_user_type") %> text-center alert-dismissible" role="alert">
							  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							  <strong><i class="fas fa-info-circle"></i> <%= session.getAttribute("message_user") %></strong>
							</div>
							<%
								session.removeAttribute("message_user");
								session.removeAttribute("message_user_type");
							%>
						<% } %>
	                </div>
			
			<div class="panel panel-primary">
			  <!-- Default panel contents -->
			  <div class="panel-heading">Utilisateurs Management</div>
			  <div class="panel-body">
			    <p>Il y a <%= uss.size() %> utilisateur(s) </p>
			  </div>
			<div class="table-responsive">
			  			<!-- Table -->
			  						
						<table class="table table-hover table-bordered table-striped">
							<thead>
							<tr class="success">
								<th class="text-center">#</th>
								<th class="text-center">Nom</th>
								<th class="text-center">Prenom</th>
								<th class="text-center">Email</th>
								<th class="text-center">Mot de passe</th>
								<th class="text-center">Telephone</th>
								<th class="text-center">Role</th>
								<th class="text-center" colspan="2">Actions</th>
							</tr>
							</thead>
							<tbody>
							<% for( User us : uss ){ %>
								<tr class="text-center">
									<td><a href="<%= request.getAttribute("page_url") %>?user=<%= us.getUser_id() %>"><strong><%= us.getUser_id() %></strong></td>
									<td><%= us.getNom() %></td>
									<td><%= us.getPrenom() %></td>
									<td><%= us.getEmail() %></td>
									<td>********************</td>
									<td><%= us.getTelephone() %></td>
									<%
										boolean is_admin = false;
										boolean is_prof = false;
										Professeur temp_prof = professeurBusiness1.findByUserId(us.getUser_id());
										if( temp_prof != null ){
											is_prof = true;
											Administrateur temp_admin = administrateurBusiness1.findByProfesseurId(temp_prof.getProfesseur_id());
											if( temp_admin !=null )
												is_admin=true;
										}
									%>
									<% if( is_admin ){ %>
									<td>Administrateur</td>
									<% }else if( is_prof ){ %>
									<td>Professeur</td>
									<% }else{ %>
									<td>Utilisateur</td>
									<% } %>
									<td>
										  	<form method="POST" action="<%= request.getAttribute("page_url") %>/changeuserrole"  id="delete_user<%= us.getUser_id() %>">
										  	<input type="hidden" name="user_id" value="<%= us.getUser_id() %>" />
											  	<input type="hidden" value="0" name="position" />
										  		<button class="btn btn-danger btn-sm" type="button" onclick="doAction('delete_user<%= us.getUser_id() %>', 'professeur', 'supprimer');"><i class="fas fa-user-slash"></i> Supprimer</button>
											</form>
									</td>
										  <% if( is_admin ){ %>
									<td>
											  	<form method="POST" action="<%= request.getAttribute("page_url") %>/changeuserrole" id="set_professor<%= us.getUser_id() %>" >
											  	<input type="hidden" name="user_id" value="<%= us.getUser_id() %>" />
											  	<input type="hidden" value="1" name="position" />
											  	<button type="button" class="btn btn-info btn-sm" onclick="doAction('set_professor<%= us.getUser_id() %>', 'professeur', 'déclasser');"><i class="fas fa-download"></i> Déclasser en tant que professeur</button>
											  	</form>
									</td>
										  <% }else{ %>
												  <% if( !is_prof ){ %>
														<td>
													  	<form method="POST" action="<%= request.getAttribute("page_url") %>/changeuserrole" id="approve_professor<%= us.getUser_id() %>" >
													  	<input type="hidden" name="user_id" value="<%= us.getUser_id() %>" />
													  	<input type="hidden" value="1" name="position" />
													  	<button  type="button"class="btn btn-info btn-sm" onclick="doAction('approve_professor<%= us.getUser_id() %>', 'professeur', 'approuver');"><i class="fas fa-check-double"></i> Approuver professeur</button>
													  	</form>
														</td>
											      <% }else{%>
											      		<td>
													  	<form method="POST" action="<%= request.getAttribute("page_url") %>/changeuserrole" id="set_admin<%= us.getUser_id() %>" >
													  	<input type="hidden" name="user_id" value="<%= us.getUser_id() %>" />
													  	<input type="hidden" value="2" name="position" />
													  	<button type="button" class="btn btn-info btn-sm" onclick="doAction('set_admin<%= us.getUser_id() %>', 'professeur', 'mettre à niveau');"><i class="fas fa-upload"></i> Mettre à niveau administrateur</button>
													  	</form>
														</td>
												<% } %>
										  <% } %>
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
			  <div class="panel-heading">Utilisateurs Management</div>
			  <div class="panel-body">
			    <p>Il y a <%= uss.size() %> utilisateurs </p>
			  </div>
			<div class="table-responsive">
			  			<!-- Table -->
			  						
						<table class="table table-hover table-bordered table-striped">
							<thead>
							<tr class="success">
								<th class="text-center">#</th>
								<th class="text-center">Nom</th>
								<th class="text-center">Prenom</th>
								<th class="text-center">Email</th>
								<th class="text-center">Password</th>
								<th class="text-center">Telephone</th>
								<th class="text-center" colspan="3">Actions</th>
							</tr>
							</thead>
							<tbody>
							<% if( us_search != null ){ %>
								<tr class="text-center">
									<td><strong><%= us_search.getUser_id() %></strong></td>
									<td><%= us_search.getNom() %></td>
									<td><%= us_search.getPrenom() %></td>
									<td><%= us_search.getEmail() %></td>
									<td><%= us_search.getPassword() %></td>
									<td><%= us_search.getTelephone() %></td>
									<%
										boolean is_admin = false;
										boolean is_prof = false;
										Professeur temp_prof = professeurBusiness1.findByUserId(us_search.getUser_id());
										if( temp_prof != null ){
											is_prof = true;
											Administrateur temp_admin = administrateurBusiness1.findByProfesseurId(temp_prof.getProfesseur_id());
											if( temp_admin !=null )
												is_admin=true;
										}
									%>
									<% if( is_admin ){ %>
									<td>Administrateur</td>
									<% }else if( is_prof ){ %>
									<td>Professeur</td>
									<% }else{ %>
									<td>Utilisateur</td>
									<% } %>
									<td>
										  	<form method="POST" action="<%= request.getAttribute("page_url") %>/changeuserrole"  id="delete_user<%= us_search.getUser_id() %>">
										  	<input type="hidden" name="user_id" value="<%= us_search.getUser_id() %>" />
											  	<input type="hidden" value="0" name="position" />
										  		<button type="button" class="btn btn-danger btn-sm" onclick="doAction('delete_user<%= us_search.getUser_id() %>', 'professeur', 'supprimer');"><i class="fas fa-user-slash"></i> Supprimer</button>
											</form>
									</td>
										  <% if( is_admin ){ %>
									<td>
											  	<form method="POST" action="<%= request.getAttribute("page_url") %>/changeuserrole" id="set_professor<%= us_search.getUser_id() %>" >
											  	<input type="hidden" name="user_id" value="<%= us_search.getUser_id() %>" />
											  	<input type="hidden" value="1" name="position" />
											  	<button type="button" class="btn btn-info btn-sm" onclick="doAction('set_professor<%= us_search.getUser_id() %>', 'professeur', 'déclasser');"><i class="fas fa-download"></i> Déclasser en tant que professeur</button>
											  	</form>
									</td>
										  <% }else{ %>
												  <% if( !is_prof ){ %>
														<td>
													  	<form method="POST" action="<%= request.getAttribute("page_url") %>/changeuserrole" id="approve_professor<%= us_search.getUser_id() %>" >
													  	<input type="hidden" name="user_id" value="<%= us_search.getUser_id() %>" />
													  	<input type="hidden" value="1" name="position" />
													  	<button type="button" class="btn btn-info btn-sm" onclick="doAction('approve_professor<%= us_search.getUser_id() %>', 'professeur', 'approuver');"><i class="fas fa-check-double"></i> Approuver professeur</button>
													  	</form>
														</td>
											      <% }else{%>
											      		<td>
													  	<form method="POST" action="<%= request.getAttribute("page_url") %>/changeuserrole" id="set_admin<%= us_search.getUser_id() %>" >
													  	<input type="hidden" name="user_id" value="<%= us_search.getUser_id() %>" />
													  	<input type="hidden" value="2" name="position" />
													  	<button type="button" class="btn btn-info btn-sm" onclick="doAction('set_admin<%= us_search.getUser_id() %>', 'professeur', 'mettre à niveau');"><i class="fas fa-upload"></i> Mettre à niveau administrateur</button>
													  	</form>
														</td>
												<% } %>
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