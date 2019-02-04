<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.conference.entities.*" %>
<%@ page import="com.conference.dao.*" %>
<%@ page import="com.conference.business.*" %>
<%@page import="com.conference.entities.*" %>

<%
IUser usBusiness = (UserDAO)session.getAttribute("userBusiness");
IProfesseur profBusiness = (ProfesseurDAO)session.getAttribute("professeurBusiness");
IAdministrateur adminBusiness = (AdministrateurDAO)session.getAttribute("administrateurBusiness");
IConference confBusiness = (ConferenceDAO)session.getAttribute("conferenceBusiness");
IComite comiteBusiness = (ComiteDAO)session.getAttribute("comiteBusiness");



%>

			
			
	                <div class="row" style="width: 95%; margin-left: auto;margin-right: auto;">
	                	<% if( session.getAttribute("message_session_edit") != null ){ %>
							<div class="alert alert-<%= session.getAttribute("message_session_edit_type") %> text-center alert-dismissible" role="alert">
							  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							  <strong><i class="fas fa-info-circle"></i> <%= session.getAttribute("message_session_edit") %></strong>
							</div>
							<%
								session.removeAttribute("message_session_edit");
								session.removeAttribute("message_session_edit_type");
							%>
						<% } %>
	                </div>
			
			<div class="col-md-12">
                    <div class="ticket-col">
                        <h2 class="text-center"><strong style="color: #ec5339;">Ajout d'une nouvelle session</strong></h2>
                        <form method="POST" action="<%= request.getAttribute("page_url") %>/addsession" >  
									 <fieldset>
									  <legend class="text-center text-uppercase"><h4  style="color: #337ab7;">Détails de session</h4></legend>
			                              
                            <div class="row">
                           
                           		<div class="col-md-12">
                                    <select required="required" name="conference_id" class="my-select form-control">
                                    	<option disabled="disabled">Choisir la conference</option>
                                    		<% for( Conference conf : confBusiness.findAll() ){ %>
	                                        	<option value="<%= conf.getId() %>"><%= conf.getTitre() %> | <%= conf.getId() %></option>
                                        	<% } %>
                                    </select>
                                </div>
                                
                                <div class="col-md-12">
                                    <select required="required" name="president_id" class="my-select form-control">
                                    	<option disabled="disabled">Choisir le président</option>
                                    		<% for( Professeur prof : profBusiness.findAll() ){ %>
	                                        	<option value="<%= prof.getProfesseur_id() %>"><%= prof.fullname() %> | <%= prof.getMetier() %> | <%= prof.getProfesseur_id() %></option>
                                        	<% } %>
                                    </select>
                                </div>
                                
                                <div class="col-md-12">
                                    <select required="required" name="comite_id" class="my-select form-control" multiple="multiple">
                                    	<option disabled="disabled">Choisir les comités</option>
                                    		<% for( Professeur prof : profBusiness.findAll() ){ %>
	                                        	<option value="<%= prof.getProfesseur_id() %>"><%= prof.fullname() %> | <%= prof.getMetier() %> | <%= prof.getProfesseur_id() %></option>
                                        	<% } %>
                                    </select>
                                </div>
                                <div class="col-md-12">
                                    <input required="required" type="text" class="form-control" name="titre" placeholder="titre">
                                </div>
                                <div class="col-md-12">
                                    	<input required="required" id="start_date_ses" type="datetime-local" class="form-control" name="date_start_session" placeholder="Date debut session">
                                </div>
                                <div class="col-md-12">
                                    	<input required="required" id="end_date_ses" type="datetime-local" class="form-control" name="date_end_session" placeholder="Date fin session">
                                </div>
                                <div class="col-md-12 text-center">
			                                    <button class="btn btn-default my-btn btn-color" type="submit"><i class="far fa-save"></i> Enregistrer</button>
                                </div>
                            </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
