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

User us = (User)session.getAttribute("user");
Professeur prof = (Professeur)session.getAttribute("professeur");
Administrateur admin = (Administrateur)session.getAttribute("administrateur");




%>

							
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
	                
	      <div class="col-md-12">
                    <div class="ticket-col">
                        <h2 class="text-center"><strong style="color: #ec5339;">Ajout d'une nouvelle conference</strong></h2>
                        
			                            <form method="post" action="<%= request.getAttribute("page_url") %>/addconference" enctype="multipart/form-data" >
			                               
									 <fieldset>
									  <legend class="text-center text-uppercase"><h4  style="color: #337ab7;">Détails de conference</h4></legend>
			                               <input type="hidden" name="administrateur_id" value="<%= ((Administrateur)session.getAttribute("administrateur")).getAdmin_id() %>" />
			                                <div class="col-md-12">
			                                <label>Titre:</label>
			                                    <input type="text" name="titre" id="titre" class="form-control" placeholder="Titre" required="required">
			                                </div>
			                                <div class="col-md-12" >
			                                <label>Description:</label>
			                                	<textarea id="textarea_report" placeholder="description" name="description" ></textarea>
			                                </div>
			                                <div class="col-md-12">
			                                	<label>Date debut soumission:</label>
			                                    	<input required="required" id="start_date_soum" type="datetime-local" class="form-control" name="date_start_soumis" placeholder="Date debut soumission">
			                                </div>
			                                <div class="col-md-12">
			                                <label>Date fin soumission:</label>
			                                    	<input required="required" id="end_date_soum" type="datetime-local" class="form-control" name="date_end_soumis" placeholder="Date fin soumission">
			                                </div>
			                                
			                                <div class="col-md-12">
			                                <label>Adresse:</label>
			                                    <input type="text" name="adresse" adresse"" id="adresse" class="form-control" placeholder="Adresse" required="required">
			                                </div>
			                                <div class="col-md-12">
			                                <label>Telephone:</label>
			                                    <input type="number" name="telephone" id="telephone" class="form-control" placeholder="Telephone" required="required">
			                                </div>
			                                <div class="col-md-12">
			                                <label>Date conference:</label>
			                                    <input type="datetime-local" name="date" id="ate" class="form-control" placeholder="Date" required="required">
			                                </div>
											<div class="col-md-12">
			                                <label>Email:</label>
			                                    <input type="email" name="email" id="email" class="form-control" placeholder="Email" required="required">
			                                </div>
			                                <div class="col-md-12">
			                                <label>Couverture: </label>
			                                    <input type="file" name="couverture" id="couverture" required="required">
			                                </div><br>
			                                <div class="col-md-12 text-center">
			                                    <button class="btn btn-default my-btn btn-color" type="submit"><i class="far fa-save"></i> Enregistrer</button>
			                                </div>
			                                <div id="form-messages"></div>
			                            </fieldset>
			                            </form>
			                        </div>
			                    </div>
			            