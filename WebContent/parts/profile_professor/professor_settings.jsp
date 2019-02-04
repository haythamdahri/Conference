<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.conference.entities.*" %>
<%@ page import="com.conference.dao.*" %>
<%@ page import="com.conference.business.*" %>
<%@ page import="java.util.*" %>
<%@page import="com.conference.entities.*" %>

<%
IProfesseur professeurBus = (ProfesseurDAO)session.getAttribute("professeurBusiness");
IPapier papierBus = (PapierDAO)session.getAttribute("papierBusiness");
IAffectation affectationBus = (AffectationDAO)session.getAttribute("affectationBusiness");
ISession sesBus = (SessionDAO)session.getAttribute("sessionBusiness");


User user_r = (User)session.getAttribute("user");
Professeur prof = (Professeur)session.getAttribute("professeur");




%>

<div class=" contact-form-row">
                <div class="col-md-12">
	                <div class="row">
	                	<% if( session.getAttribute("message_settings") != null ){ %>
							<div class="alert alert-<%= session.getAttribute("message_settings_type") %> text-center alert-dismissible" role="alert">
							  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							  <strong><i class="fas fa-info-circle"></i> <%= session.getAttribute("message_settings") %></strong>
							</div>
							<%
								session.removeAttribute("message_settings");
								session.removeAttribute("message_settings_type");
							%>
						<% } %>
	                </div>
                    <div class="row">
                    <div class="panel panel-primary">
					  
					  <!-- Default panel contents -->
					  <div class="panel-heading">Parametres du profil</div>
					  
							<div class="table-responsive" style="padding-bottom: 5%;padding-top: 5%;">
					
		                        <div class="contact-col">
		                            <form method="post" action="<%= request.getAttribute("page_url") %>/updatesettings" enctype="multipart/form-data" >
		                                <div class="col-md-6">
		                                    <input type="text" name="username" value="<%= user_r.getUsername() %>" id="username" class="form-control" placeholder="Username" required="required">
		                                </div>
		                                <div class="col-md-6">
		                                    <input type="text" name="nom" id="nom" value="<%= user_r.getNom() %>" class="form-control" placeholder="Nom" required="required">
		                                </div>
		                                <div class="col-md-6">
		                                    <input type="text" name="prenom" id="prenom" value="<%= user_r.getPrenom() %>" class="form-control" placeholder="Prenom" required="required">
		                                </div>
		                                <div class="col-md-6">
		                                    <input type="email" name="email" id="email" class="form-control" value="<%= user_r.getEmail() %>" placeholder="Email" required="required">
		                                </div>
		                                <div class="col-md-6">
		                                    <input type="password" name="password" id="password" class="form-control" placeholder="Mot de passe" required="required">
		                                </div>
		                                <div class="col-md-6">
		                                    <input type="number" name="telephone" id="telephone" value="<%= user_r.getTelephone() %>" class="form-control" placeholder="Telephone" required="required">
		                                </div>
		                                <div class="col-md-12" style="padding-bottom: 10px;">
		                                <label>Image: </label>
		                                	<input type="file" name="image" />
		                                </div>
		                                <div class="col-md-12">
		                                        <button class="btn btn-default my-btn btn-color text-center" type="submit" value="Modifier mon informations"><i class="fas fa-share-square"></i> Modifier mes informations</button>
		                                </div>
		                                <div id="form-messages"></div>
		                            </form>
		                        </div>
		                    </div>
		                    
                	</div>
                	</div>
                </div>
            </div>
			