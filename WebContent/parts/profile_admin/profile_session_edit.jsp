<%@page import="java.util.TimeZone"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.DateFormat"%>
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

Session ses = (Session)session.getAttribute("session_edit");
List<Comite> comites = ses.getComites();

TimeZone UTC = TimeZone.getTimeZone("UTC");
String ISO_8601_24H_FULL_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSS";
SimpleDateFormat sdf = new SimpleDateFormat(ISO_8601_24H_FULL_FORMAT);
sdf.setTimeZone(UTC);
String date_start_session = sdf.format(ses.getDate_start_session());
String date_end_session = sdf.format(ses.getDate_end_session());

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
                        <h2 class="text-center"><strong style="color: #ec5339;">Modification session id=<%= ses.getId() %></strong></h2>
                        <form method="POST" action="<%= request.getAttribute("page_url") %>/updatesession" >  
									 <fieldset>
									  <legend class="text-center text-uppercase"><h4  style="color: #337ab7;">Détails de session</h4></legend>
			                              
                            <div class="row">
                            <input type="hidden" name="session_id" value="<%= ses.getId() %>" />
                           
                                <div class="col-md-12">
                                    <select required="required" name="president_id" class="my-select form-control">
                                    	<option disabled="disabled">Choisir le président</option>
                                    		<% for( Professeur prof : profBusiness.findAll() ){ %>
                                    		<% String selected="";
                                    			if( prof.getProfesseur_id() == ses.getPresident().getProfesseur_id() ){
                                    				selected = "selected";
                                    			}
                                    		%>
	                                        	<option <%= selected %> value="<%= prof.getProfesseur_id() %>"><%= prof.fullname() %> | <%= prof.getMetier() %> | <%= prof.getProfesseur_id() %></option>
                                        	<% } %>
                                    </select>
                                </div>
                                <div class="col-md-12">
                                    <select required="required" name="comite_id" class="my-select form-control" multiple="multiple">
                                    	<option disabled="disabled">Choisir les comités</option>
                                    		<% for( Professeur prof : profBusiness.findAll() ){ %>
                                    			<% String selected = ""; %>
                                    			<% for( Comite comite : comites ){ if( comite.getProfesseur_id() == prof.getProfesseur_id() ){ selected = "selected"; }} %>
	                                        	<%= selected+" IS IT" %>
	                                        	<option value="<%= prof.getProfesseur_id() %>" <%= selected %>><%= prof.fullname() %> | <%= prof.getMetier() %> | <%= prof.getProfesseur_id() %></option>
                                        	<% } %>
                                    </select>
                                </div>
                                <div class="col-md-12">
                                    <input required="required" type="text" value="<%= ses.getTitre() %>" class="form-control" name="titre" placeholder="titre">
                                </div>
                                <div class="col-md-12">
                                   	<input required="required" id="start_date_ses" type="datetime-local" value="<%= date_start_session %>" class="form-control" name="date_start_session" placeholder="Date debut session">
                                </div>
                                <div class="col-md-12">
                                   	<input required="required" id="end_date_ses" type="datetime-local" class="form-control" value="<%= date_end_session %>" name="date_end_session" placeholder="Date fin session">
                                </div>
                                <div class="col-md-12 text-center">
			                                    <button class="btn btn-default my-btn btn-color" type="submit"><i class="far fa-save"></i> Enregistrer</button>
                                </div>
                            </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
