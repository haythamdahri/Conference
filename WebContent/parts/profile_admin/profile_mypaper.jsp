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
IInscription inscBus = (InscriptionDAO)session.getAttribute("inscriptionBusiness");

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
		  for( Papier p : sess.getPapiers() ){
			  if( p.getUser().getUser_id() == user_r.getUser_id() ){
				  papers.add(p);
			  }
		  }
	  }
	} 


%>

<% if( request.getParameter("mypaper").equals("all") || request.getParameter("mypaper").equals("") ){ %>
			<div class="">
			
			
	                <div class="row" style="width: 95%; margin-left: auto;margin-right: auto;">
	                	<% if( session.getAttribute("message_mypaper") != null ){ %>
							<div class="alert alert-<%= session.getAttribute("message_mypaper_type") %> text-center alert-dismissible" role="alert">
							  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							  <strong><i class="fas fa-info-circle"></i> <%= session.getAttribute("message_mypaper") %></strong>
							</div>
							<%
								session.removeAttribute("message_mypaper");
								session.removeAttribute("message_mypaper_type");
							%>
						<% } %>
	                </div>
			
			<div class="panel panel-primary">
			  <!-- Default panel contents -->
			  <div class="panel-heading">Papiers Management</div>
			  <div class="panel-body text-center">
			    <p>Vous avez soumis <%= papers.size() %> papier(s).</p>
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
								<th class="text-center" colspan="2">Actions</th>
							</tr>
							</thead>
							<tbody>
							<% if( papers.size() != 0 ){ %>
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
									<% if( inscBus.findBySessionId(p.getSession().getId()) == null ){ %>
										<td>
											<form action="<%= request.getAttribute("page_url") %>/deletemypaper" method="post" id="del_mypaper<%=p.getId()%>"><input type="hidden" name="mypaper_id" value="<%= p.getId() %>" /></form>
											  <button type="button" onclick="deleteRow('del_mypaper<%=p.getId()%>', 'votre papier');" class="btn btn-danger"><i class="far fa-trash-alt"></i> Supprimer</button>
										</td>
										<td>
											  <a href="<%= request.getAttribute("page_url") %>?mypaper=<%= p.getId()%>&edit"><button class="btn btn-primary"><i class="fas fa-edit"></i> Modifier</button></a>
										</td>
									<% }else if( p.getEtat().equals("refuse") ){ %>
											<td class="alert alert-danger" colspan="2">Votre papier à été refusé.</td>
									<% }else if( p.getEtat().equals("") ){ %>
											<td class="alert alert-warning" colspan="2"><strong>Vous avez déja effectué l'inscription.</strong></td>
									<% }else{ %>
											<td class="alert alert-success" colspan="2"><strong>Congratulation, votre papier à été <%= p.getEtat() %>.</strong></td>
									<% }%>
									<% }}else{ %>
										<td class="alert alert-warning text-center" colspan="9">
											<strong><i class="fas fa-info-circle"></i> AUCUN PAPIER TROUVÉ</strong>
										</td>
									<% } %>
									</tr>
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
			    <p>Vous avez soumis <%= papers.size() %> papier(s).</p>
			  </div>
			<div class="table-responsive">
			  			<!-- Table -->
			  						
						<table class="table table-hover table-bordered table-striped">
								<thead>
									<tr class="success">
										<th class="text-center">#</th>
										<th class="text-center">Titre</th>
										<th class="text-center">Utilisateur | N°</th>
										<th class="text-center">Conference | N°</th>
										<th class="text-center">Session | N°</th>
										<th class="text-center">Etat</th>
										<th class="text-center">Note</th>
										<th class="text-center" colspan="2">Actions</th>
									</tr>
								</thead>
								<tbody>
							<% if( papier_search != null ){ %>
									<tr class="text-center">
										<td><strong><%= papier_search.getId() %></strong></td>
										<td><%= papier_search.getTitre() %></td>
										<td><%= papier_search.getUser().fullname() %> | <%= papier_search.getUser().getUser_id() %></td>
										<td><%= papier_search.getSession().getConference().getTitre() %> | <%= papier_search.getSession().getConference().getId() %></td>
										<td><%= papier_search.getSession().getTitre() %> | <%= papier_search.getSession().getId() %></td>
										<td><%= papier_search.getEtat() %></td>
										<td><%= papier_search.getNote() %></td>
									<% if( inscBus.findBySessionId(papier_search.getSession().getId()) == null ){ %>
										<td>
											<form action="<%= request.getAttribute("page_url") %>/deletemypaper" method="post" id="del_mypaper<%=papier_search.getId()%>"><input type="hidden" name="mypaper_id" value="<%= papier_search.getId() %>" /></form>
											  <button type="button" onclick="deleteRow('del_mypaper<%=papier_search.getId()%>', 'votre papier');" class="btn btn-danger"><i class="far fa-trash-alt"></i> Supprimer</button>
										</td>
										<td>
											  <a href="<%= request.getAttribute("page_url") %>?mypaper=<%= papier_search.getId()%>&edit"><button class="btn btn-primary"><i class="fas fa-edit"></i> Modifier</button></a>
										</td>
										<% }else if( papier_search.getEtat().equals("refuse") ){ %>
												<td class="alert alert-danger" colspan="2">Votre papier à été refusé.</td>
										<% }else if( inscBus.findByUserId(prof.getUser_id()) != null && papier_search.getEtat().equals("") ){ %>
												<td class="alert alert-warning" colspan="2"><strong>Vous avez déja effectué l'inscription.</strong></td>
										<% }else if( inscBus.findByUserId(prof.getUser_id()) != null ){ %>
												<td class="alert alert-success" colspan="2"><strong>Congratulation, votre papier à été <%= papier_search.getEtat() %>.</strong></td>
										<% } %>
									</tr>
							<% }else{ %>
								<td class="alert alert-danger text-center" colspan="8">
									<strong><i class="fas fa-info-circle"></i> Aucun enregistrement à afficher</strong>
								</td>
							<% } %>
							</tbody>
						</table>
				</div>
			</div>
			</div>
			
			<% } %>