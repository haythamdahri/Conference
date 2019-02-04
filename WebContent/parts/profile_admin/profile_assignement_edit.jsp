<%@page import="java.util.ArrayList"%>
<%@page import="java.util.*"%>
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
IPapier papierBusi = (PapierDAO)session.getAttribute("papierBusiness");
Affectation affectation = (Affectation)session.getAttribute("affectation");


%>

			
			
	                <div class="row" style="width: 95%; margin-left: auto;margin-right: auto;">
	                	<% if( session.getAttribute("message_assignement_edit") != null ){ %>
							<div class="alert alert-<%= session.getAttribute("message_assignement_edit_type") %> text-center alert-dismissible" role="alert">
							  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							  <strong><i class="fas fa-info-circle"></i> <%= session.getAttribute("message_assignement_edit") %></strong>
							</div>
							<%
								session.removeAttribute("message_assignement_edit");
								session.removeAttribute("message_assignement_edit_type");
							%>
						<% } %>
	                </div>
			
			<div class="col-md-12">
                    <div class="ticket-col">
                    
                    
                    
                    
                        <h2 class="text-center"><strong style="color: #ec5339;">Ajout d'une nouvelle affectation</strong></h2>
                        <form method="POST" action="<%= request.getAttribute("page_url") %>/updateassignement" >  
									 <fieldset>
									  <legend class="text-center text-uppercase"><h4  style="color: #337ab7;">Détails d'affectation</h4></legend>
			                              
                        
                        	<input type="hidden" value="<%= affectation.getId() %>" name="assignement_id" />
                            <div class="row">                           
                           		<div class="col-md-12">
                                <label>Professeur: </label>
                                    <select required="required" name="comite_id" id="comites" class="my-select form-control">
                                    	<option disabled="disabled">Choisir le professeur</option>
                                    		<% for( Comite comite : comiteBusiness.findBySessionId(affectation.getPapier().getSession().getId()) ){ %>
                                    		<% String selected="";
                                    			if( comite.getSession().getId() == affectation.getPapier().getSession().getId() ){
	                                    			if( comite.getComite_id() == affectation.getComite().getComite_id() ){
	                                    				selected = "selected";
	                                    			}
	                                    	%>
	                                    	      	<option value="<%= comite.getComite_id() %>" <%= selected %>><%= comite.fullname() %> | Session: <%= comite.getSession().getId() %></option>
                                        	<% }} %>
                                    </select>
                                </div>
                                
                                <div class="col-md-12">
                                <label>Papier: </label>
                                    <select required="required" name="papier_id" id="papiers" class="my-select form-control">
	                                        	<option  disabled="disabled" selected value="<%= affectation.getPapier().getId() %>"><%= affectation.getPapier().getTitre() %> | <%= affectation.getPapier().getUser().fullname() %>, <%= affectation.getPapier().getUser().getUser_id() %></option>
                                    </select>
                                </div>
                                
                                <div class="col-md-12 text-center">
			                                    <button class="btn btn-default my-btn btn-color" type="submit"><i class="far fa-save"></i> Enregistrer</button>
                                </div>
                            </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
