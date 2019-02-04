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
IAffectation affectationBusiness = (AffectationDAO)session.getAttribute("affectationBusiness");
ISession sessionBus = (SessionDAO)session.getAttribute("sessionBusiness");

Professeur prof = (Professeur)session.getAttribute("professeur");
List<Affectation> affectations = new ArrayList<Affectation>();
Affectation affect_search = (Affectation)request.getAttribute("affectation");
List<Session> sess = (List<Session>)sessionBus.findByPresidentId(prof.getProfesseur_id());


boolean is_president = false;
//Retrieve records where professor is the president or member
for( Affectation affectation : affectationBusiness.findAll() ){
	if( affectation.getPapier().getSession().getPresident().getProfesseur_id() == prof.getProfesseur_id() ){
		affectations.add(affectation);
	}
}

	


%>

<% if( request.getParameter("assignement").equals("all") || request.getParameter("assignement").equals("") ){ %>
			<div class="">
			
			
	                <div class="row" style="width: 95%; margin-left: auto;margin-right: auto;">
	                	<% if( session.getAttribute("message_assignement") != null ){ %>
							<div class="alert alert-<%= session.getAttribute("message_assignement_type") %> text-center alert-dismissible" role="alert">
							  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							  <strong><i class="fas fa-info-circle"></i> <%= session.getAttribute("message_assignement") %></strong>
							</div>
							<%
								session.removeAttribute("message_assignement");
								session.removeAttribute("message_assignement_type");
							%>
						<% } %>
	                </div>
			
			<div class="panel panel-primary">
			  <!-- Default panel contents -->
			  <div class="panel-heading">Affectations Papiers Management</div>
			  <div class="panel-body text-center">
			    <p>Il y a <%= affectations.size() %> affectation(s) en totale.</p>
			    <% if( sess.size() > 0 ){ %>
				<a href="<%= request.getAttribute("page_url") %>?addassignement"><button class="btn btn-info btn-lg"><i class="fas fa-folder-plus"></i> Ajouter affectation</button></a>
			  	<% } %>
			  </div>
			<div class="table-responsive">
			  			<!-- Table -->
			  						
						<table class="table table-hover table-bordered table-striped">
							<thead>
							<tr class="success">
								<th class="text-center">#</th>
								<th class="text-center">Papier | N°</th>
								<th class="text-center">Comite | N°</th>
								<th class="text-center" colspan="2">Actions</th>
							</tr>
							</thead>
							<tbody>
							<% if( affectations.size() > 0 ){ %>
							<% for( Affectation affectation : affectations ){ %>
								<tr class="text-center">
									<td><strong><%= affectation.getId() %></strong></td>
									<td><%= affectation.getPapier().getTitre() %> | <%= affectation.getPapier().getId() %></td>
									<td><%= affectation.getComite().fullname() %> | <%= affectation.getComite().getComite_id() %></td>
									<td>
										<form action="<%= request.getAttribute("page_url") %>/deleteassignement" method="post" id="del_assignement<%=affectation.getId()%>"><input type="hidden" name="assignement_id" value="<%= affectation.getId() %>" /></form>
										  <button type="button" onclick="deleteRow('del_assignement<%=affectation.getId()%>', 'affectation');" class="btn btn-danger"><i class="far fa-trash-alt"></i> Supprimer</button>
									</td>
									<td>
										  <a href="<%= request.getAttribute("page_url") %>?assignement=<%= affectation.getId()%>&edit"><button class="btn btn-primary"><i class="fas fa-edit"></i> Modifier</button></a>
									</td>
								</tr>
								<% }}else{ %>
									<td colspan="4" class="alert alert-warning text-center">AUCUNE AFFECTATION TROUVÉE POUR VOUS</td>
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
			    <p>Il y a <%= affectations.size() %> affectations en totale.</p>
				<a href="<%= request.getAttribute("page_url") %>?addassignement"><button class="btn btn-info btn-lg"><i class="fas fa-folder-plus"></i> Ajouter affectation</button></a>
			  </div>
			<div class="table-responsive">
			  			<!-- Table -->
			  						
						<table class="table table-hover table-bordered table-striped">
							<thead>
							<tr class="success">
								<th class="text-center">#</th>
								<th class="text-center">Papier | N°</th>
								<th class="text-center">Comite | N°</th>
								<th class="text-center" colspan="2">Actions</th>
							</tr>
							</thead>
							<tbody>
							<% if( affect_search != null ){ %>
								<tr class="text-center">
									<td><strong><%= affect_search.getId() %></strong></td>
									<td><%= affect_search.getPapier().getTitre() %> | <%= affect_search.getId() %></td>
									<td><%= affect_search.getComite().fullname() %> | <%= affect_search.getId() %></td>
									<% if( affect_search.getPapier().getSession().getPresident().getProfesseur_id() == prof.getProfesseur_id() ){ %>
										<td>
										<form action="<%= request.getAttribute("page_url") %>/deleteassignement" method="post" id="del_assignement<%=affect_search.getId()%>"><input type="hidden" name="assignement_id" value="<%= affect_search.getId() %>" /></form>
										  <button type="button" onclick="deleteRow('del_assignement<%=affect_search.getId()%>', 'affectation');" class="btn btn-danger"><i class="far fa-trash-alt"></i> Supprimer</button>
										</td>
										<td>
											  <a href="<%= request.getAttribute("page_url") %>?assignement=<%= affect_search.getId()%>&edit"><button class="btn btn-primary"><i class="fas fa-edit"></i> Modifier</button></a>
										</td>
									<% }else{ %>
										<td class="alert alert-warning">AUCUN PRIVILEGE</td>
									<% } %>
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