<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.conference.entities.*" %>
<%@ page import="com.conference.dao.*" %>
<%@ page import="com.conference.business.*" %>
<%@ page import="java.util.*" %>
<%@page import="com.conference.entities.*" %>

<%

IInscription inscriptionBusiness = (InscriptionDAO)session.getAttribute("inscriptionBusiness");
List<Inscription> inscriptions = (List<Inscription>)inscriptionBusiness.findAll();

Inscription inscription_search = (Inscription)request.getAttribute("inscription");

%>

<% if( request.getParameter("registration").equals("all") || request.getParameter("registration").equals("") ){ %>
		
		<div class="">
		
		<div class="row" style="width: 95%; margin-left: auto;margin-right: auto;">
	                	<% if( session.getAttribute("message_inscription") != null ){ %>
							<div class="alert alert-<%= session.getAttribute("message_inscription_type") %> text-center alert-dismissible" role="alert">
							  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							  <strong><i class="fas fa-info-circle"></i> <%= session.getAttribute("message_inscription") %></strong>
							</div>
							<%
								session.removeAttribute("message_inscription");
								session.removeAttribute("message_inscription_type");
							%>
						<% } %>
	                </div>
			
			<div class="panel panel-primary">
			  <!-- Default panel contents -->
			  <div class="panel-heading">Inscriptions Management</div>
			  <div class="panel-body">
			    <p>Il y a <%= inscriptions.size() %> inscription(s) </p>
			  </div>
			<div class="table-responsive">
			  			<!-- Table -->
			  						
						<table class="table table-hover table-bordered table-striped">
							<thead>
							<tr class="success">
								<th class="text-center">#</th>
								<th class="text-center">Nom | Prenom | N°</th>
								<th class="text-center">Session | N°</th>
								<th class="text-center">Conference | N°</th>
								<th class="text-center" colspan="2">Actions</th>
							</tr>
							</thead>
							<tbody>
							<% if( inscriptions.size() > 0 ){ %>
							<% for( Inscription ins : inscriptions ){ %>
								<tr class="text-center">
									<td><%= ins.getInscription_id() %></td>
									<td><%= ins.getUser().getNom() %> | <%= ins.getUser().getPrenom() %> | <%= ins.getUser().getUser_id() %></td>
									<td><%= ins.getSession().getTitre() %> | <%= ins.getSession().getId() %></td>
									<td><%= ins.getSession().getConference().getTitre() %> | <%= ins.getSession().getConference().getId() %></td>
									<td>
										<form action="<%= request.getAttribute("page_url") %>/cancelregistration" method="post" id="cancel_registration<%=ins.getInscription_id() %>"><input type="hidden" name="registration_id" value="<%= ins.getInscription_id() %>" /></form>
										  <button type="button" onclick="doAction('cancel_registration<%=ins.getInscription_id() %>', 'inscription', 'annuler');" class="btn btn-danger"><i class="fas fa-ban"></i> Annuler</button>
									</td>								
							<% }}else{ %>
								<td colspan="5" class="alert alert-warning text-center">AUCUNE INSCRIPTION EFFECTUÉE</td>
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
			    <p>Il y a <%= inscriptions.size() %> inscription </p>
			  </div>
			<div class="table-responsive" >
			  			<!-- Table -->
			  						
						<table class="table table-hover table-bordered table-striped">
							<thead>
							<tr class="success">
								<th class="text-center">#</th>
								<th class="text-center">Nom | Prenom | N°</th>
								<th class="text-center">Conférence | N°</th>
								<th class="text-center" colspan="2">Actions</th>
							</tr>
							</thead>
							<tbody>
							
							<tbody>
								<% if( inscription_search != null ){ %>
								<tr class="text-center">
									<td><%= inscription_search.getInscription_id() %></td>
									<td><%= inscription_search.getUser().getNom() %> | <%= inscription_search.getUser().getPrenom() %> | <%= inscription_search.getUser().getUser_id() %></td>
									<td><%= inscription_search.getSession().getConference().getTitre() %> | <%= inscription_search.getSession().getConference().getId() %></td>
									<td>
										<form action="<%= request.getAttribute("page_url") %>/cancelregistration" method="post" id="cancel_registration<%=inscription_search.getInscription_id() %>"><input type="hidden" name="registration_id" value="<%= inscription_search.getInscription_id() %>" /></form>
										  <button type="button" onclick="doAction('cancel_registration<%=inscription_search.getInscription_id() %>', 'inscription', 'annuler');" class="btn btn-danger"><i class="fas fa-ban"></i> Annuler</button>
									</td>
								</tr>
							<% }else{ %>
								<td class="alert alert-danger text-center" colspan="4">
									<strong><i class="fas fa-info-circle"></i> Aucun enregistrement à afficher</strong>
								</td>
							<% } %>
							</tbody>
						</table>
				</div>
			</div>
			</div>
			
		<% } %>			