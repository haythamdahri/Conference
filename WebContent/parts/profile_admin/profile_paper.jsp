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
IPapier papBusiness = (PapierDAO)session.getAttribute("papierBusiness");

Conference confer_search = (Conference)request.getAttribute("conference");
User us_search = (User)request.getAttribute("user_search");
Session ses_search = (Session)request.getAttribute("session");
Papier papier_search = (Papier)request.getAttribute("papier");

User user_r = (User)session.getAttribute("user");
Professeur prof = (Professeur)session.getAttribute("professeur");
Administrateur admin = (Administrateur)session.getAttribute("administrateur");
List<Conference> conf_s = admin.getConferences();

List<User> uss = (List<User>)request.getAttribute("users");

List<Papier> papers = new ArrayList<Papier>();
List<Session> sesss = new ArrayList<Session>();

 for( Conference conf : conf_s ){
	 sesss.addAll(conf.getSessions());
	  for( Session sess : conf.getSessions() ){
		  papers.addAll(sess.getPapiers());
	  }
	} 


%>

<% if( request.getParameter("paper").equals("all") || request.getParameter("paper").equals("") ){ %>
			<div class="">
			
	                <div class="row" style="width: 95%; margin-left: auto;margin-right: auto;">
	                	<% if( session.getAttribute("message_paper") != null ){ %>
							<div class="alert alert-<%= session.getAttribute("message_paper_type") %> text-center alert-dismissible" role="alert">
							  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							  <strong><i class="fas fa-info-circle"></i> <%= session.getAttribute("message_paper") %></strong>
							</div>
							<%
								session.removeAttribute("message_paper");
								session.removeAttribute("message_paper_type");
							%>
						<% } %>
	                </div>
			
			<div class="panel panel-primary">
			  <!-- Default panel contents -->
			  <div class="panel-heading">Papiers Management</div>
			  <div class="panel-body text-center">
			    <p>Il y a <%= papers.size() %> papier(s) soumis en totale.</p>
			  </div>
			<div class="table-responsive">
			  			<!-- Table -->
			  						
						<table class="table table-hover table-bordered table-striped">
							<thead>
							<tr class="success">
								<th class="text-center">#</th>
								<th class="text-center">Titre</th>
								<th class="text-center">Description</th>
								<th class="text-center">Utilisateur | N°</th>
								<th class="text-center">Conference | N°</th>
								<th class="text-center">Session | N°</th>
								<th class="text-center">Etat</th>
								<th class="text-center">Note</th>
								<th class="text-center" colspan="4">Actions</th>
							</tr>
							</thead>
							<tbody>
							<% for( Papier p : papers ){ %>
							
							<% request.setAttribute("papier", p); %>
							<%@ include file="/parts/modal_paper_show.jsp" %>
							
								<tr class="text-center">
									<td><strong><%= p.getId() %></strong></td>
									<td><%= p.getTitre() %></td>
									<td><button onclick="ViewPaper(<%= p.getId() %>)" class="btn btn-info"><i class="far fa-eye"></i> Voir</button></td>
									<td><%= p.getUser().fullname() %> | <%= p.getUser().getUser_id() %></td>
									<td><%= p.getSession().getConference().getTitre() %> | <%= p.getSession().getConference().getId() %></td>
									<td><%= p.getSession().getTitre() %> | <%= p.getSession().getId() %></td>
									<td><%= p.getEtat() %></td>
									<td><%= p.getNote() %></td>
									<td>
										<form action="<%= request.getAttribute("page_url") %>/paperdecide" method="post" id="paperdecide<%=p.getId()%>1"><input type="hidden" name="decision" value="1" /><input type="hidden" name="paper_id" value="<%= p.getId() %>" /></form>
										  <button type="button" onclick="doAction('paperdecide<%=p.getId()%>1', 'papier', 'accepter');" class="btn btn-success"><i class="fas fa-vote-yea"></i> Accepter</button>
									</td>
									<td>
										<form action="<%= request.getAttribute("page_url") %>/paperdecide" method="post" id="paperdecide<%=p.getId()%>2"><input type="hidden" name="decision" value="2" /><input type="hidden" name="paper_id" value="<%= p.getId() %>" /></form>
										  <button type="button" onclick="doAction('paperdecide<%=p.getId()%>2', 'papier', 'poster');" class="btn btn-primary"><i class="fas fa-paste"></i> Poster</button>
									</td>
									<td>
										<form action="<%= request.getAttribute("page_url") %>/paperdecide" method="post" id="paperdecide<%=p.getId()%>0"><input type="hidden" name="decision" value="0" /><input type="hidden" name="paper_id" value="<%= p.getId() %>" /></form>
										  <button type="button" onclick="doAction('paperdecide<%=p.getId()%>0', 'papier', 'refuser');" class="btn btn-danger"><i class="fa fa-trash-alt"></i> Refuser</button>
									</td>
									<td><a href="<%= request.getAttribute("page_url") %>?paper=<%= p.getId() %>&edit"><button class="btn btn-primary"><i class="fas fa-edit"></i> Modifier</button></a></td>
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
			  <div class="panel-heading">Papiers Management</div>
			  <div class="panel-body text-center">
			    <p>Il y a <%= papers.size() %> papiers soumis en totale.</p>
			  </div>
			<div class="table-responsive">
			  			<!-- Table -->
			  						
						<table class="table table-hover table-bordered table-striped">
								<thead>
									<tr class="success">
										<th class="text-center">#</th>
										<th class="text-center">Titre</th>
										<th class="text-center">Description</th>
										<th class="text-center">Utilisateur | N°</th>
										<th class="text-center">Conference | N°</th>
										<th class="text-center">Session | N°</th>
										<th class="text-center">Etat</th>
										<th class="text-center">Note</th>
										<th class="text-center" colspan="4">Actions</th>
									</tr>
								</thead>
								<tbody>
							<% if( papier_search != null ){ %>
									<tr class="text-center">
									
										<% request.setAttribute("papier", papier_search); %>
										<%@ include file="/parts/modal_paper_show.jsp" %>
							
										<td><strong><%= papier_search.getId() %></strong></td>
										<td><%= papier_search.getTitre() %></td>
										<td><button onclick="ViewPaper(<%= papier_search.getId() %>)" class="btn btn-info"><i class="far fa-eye"></i> Voir</button></td>
										<td><%= papier_search.getUser().fullname() %> | <%= papier_search.getUser().getUser_id() %></td>
										<td><%= papier_search.getSession().getConference().getTitre() %> | <%= papier_search.getSession().getConference().getId() %></td>
										<td><%= papier_search.getSession().getTitre() %> | <%= papier_search.getSession().getId() %></td>
										<td><%= papier_search.getEtat() %></td>
										<td><%= papier_search.getNote() %></td>
										<td>
											<form action="<%= request.getAttribute("page_url") %>/paperdecide" method="post" id="paperdecide<%=papier_search.getId()%>1"><input type="hidden" name="decision" value="1" /><input type="hidden" name="paper_id" value="<%= papier_search.getId() %>" /></form>
											  <button type="button" onclick="doAction('paperdecide<%=papier_search.getId()%>1', 'papier', 'accepter');" class="btn btn-success"><i class="fas fa-vote-yea"></i> Accepter</button>
										</td>
										<td>
											<form action="<%= request.getAttribute("page_url") %>/paperdecide" method="post" id="paperdecide<%=papier_search.getId()%>2"><input type="hidden" name="decision" value="2" /><input type="hidden" name="paper_id" value="<%= papier_search.getId() %>" /></form>
											  <button type="button" onclick="doAction('paperdecide<%=papier_search.getId()%>2', 'papier', 'poster');" class="btn btn-primary"><i class="fas fa-paste"></i> Poster</button>
										</td>
										<td>
											<form action="<%= request.getAttribute("page_url") %>/paperdecide" method="post" id="paperdecide<%=papier_search.getId()%>0"><input type="hidden" name="decision" value="0" /><input type="hidden" name="paper_id" value="<%= papier_search.getId() %>" /></form>
											  <button type="button" onclick="doAction('paperdecide<%=papier_search.getId()%>0', 'papier', 'refuser');" class="btn btn-danger"><i class="fa fa-trash-alt"></i> Refuser</button>
										</td>		
										<td><a href="<%= request.getAttribute("page_url") %>?paper=<%= papier_search.getId() %>&edit"><button class="btn btn-primary"><i class="fas fa-edit"></i> Modifier</button></a></td>
									</tr>
								</tbody>
							<% }else{ %>
								<td class="alert alert-danger text-center" colspan="9">
									<strong><i class="fas fa-info-circle"></i> Aucun enregistrement à afficher</strong>
								</td>
							<% } %>
							</tbody>
						</table>
				</div>
			</div>
			</div>
			
			<% } %>