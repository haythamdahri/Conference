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
ISession sessionB = (SessionDAO)session.getAttribute("sessionBusiness");
User myuser = (User)session.getAttribute("user");
Papier paper = (Papier)session.getAttribute("paper_edit");

%>

			
			
	                <div class="row" style="width: 95%; margin-left: auto;margin-right: auto;">
	                	<% if( session.getAttribute("message_paper_edit") != null ){ %>
							<div class="alert alert-<%= session.getAttribute("message_paper_edit_type") %> text-center alert-dismissible" role="alert">
							  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							  <strong><i class="fas fa-info-circle"></i> <%= session.getAttribute("message_paper_edit") %></strong>
							</div>
							<%
								session.removeAttribute("message_paper_edit");
								session.removeAttribute("message_paper_edit_type");
							%>
						<% } %>
	                </div>
			
			<div class="col-md-12">
                    <div class="ticket-col">
                        <h2 class="text-center"><strong style="color: #ec5339;">Modification Papier id=<%= paper.getId() %></strong></h2>
                        
           						<form method="POST" id="add_these" action="<%= request.getAttribute("page_url") %>/updatepaperadmin" >  
									 <fieldset>
									  <legend class="text-center text-uppercase"><h4  style="color: #337ab7;">Détails de papier</h4></legend>
			                              
		                            <div class="row">
		                            <input type="hidden" name="paper_id" value="<%= paper.getId() %>" />
		                           
		                                <div class="col-md-12">
		                                    <select required="required" name="state" class="my-select form-control">
		                                    	<option disabled="disabled">Choisir l'état</option>
		                                    	<option value="accepte" <% if( paper.getEtat().equals("accepte") ){ %>selected<% } %>>Accepté</option>
		                                    	<option value="poste"<% if( paper.getEtat().equals("poste") ){ %>selected<% } %>>Posté</option>
		                                    	<option value="refuse"<% if( paper.getEtat().equals("refuse") ){ %>selected<% } %>>Refusé</option>
		                                    </select>
		                                </div>
		                                
		                                <div class="col-md-12">
		                                    <input required="required" type="number"  min="0" max="200" step="0.25" value="<%= paper.getNote() %>" class="form-control" name="note" placeholder="Note">
		                                </div>
		                                
		                                <div class="col-md-12 text-center">
			                                    <button class="btn btn-default my-btn btn-color" type="submit"><i class="far fa-save"></i> Enregistrer</button>
		                                </div>
		                            </div>
		                            </fieldset>
		                        </form>
		                        
           						             
                    </div>
           </div>
