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

Conference confer_search = (Conference)request.getAttribute("conference");
User us_search1 = (User)request.getAttribute("user_search");
Session ses_search = (Session)request.getAttribute("session");

User us = (User)session.getAttribute("user");
Professeur prof = (Professeur)session.getAttribute("professeur");
Administrateur admin = (Administrateur)session.getAttribute("administrateur");


TimeZone UTC = TimeZone.getTimeZone("UTC");
String ISO_8601_24H_FULL_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSS";
SimpleDateFormat sdf = new SimpleDateFormat(ISO_8601_24H_FULL_FORMAT);
sdf.setTimeZone(UTC);
String date_start_soumis = sdf.format(confer_search.getDate_start_soumis());
String date_end_soumis = sdf.format(confer_search.getDate_end_soumis());
String date = sdf.format(confer_search.getDate());

%>

							
							 <div class="row" style="width: 95%; margin-left: auto;margin-right: auto;">
			                	<% if( session.getAttribute("message_conference_edit") != null ){ %>
								<div class="alert alert-<%= session.getAttribute("message_conference_edit_type") %> text-center alert-dismissible" role="alert">
								  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
								  <strong><i class="fas fa-info-circle"></i> <%= session.getAttribute("message_conference_edit") %></strong>
								</div>
								<%
									session.removeAttribute("message_conference_edit");
									session.removeAttribute("message_conference_edit_type");
								%>
							<% } %>
			                </div>
	                
	      <div class="col-md-12" style="padding-bottom: 20%;">
                    <div class="ticket-col">
                        <h2 class="text-center"><strong style="color: #ec5339;">Modification Conference id=<%= confer_search.getId() %></strong></h2>
                        
			                            <form method="post" action="<%= request.getAttribute("page_url") %>/updateconference" enctype="multipart/form-data" >
			                                  
									 <fieldset>
									  <legend class="text-center text-uppercase"><h4  style="color: #337ab7;">Détails de conference</h4></legend>
			                              
			                              <input type="hidden" value="<%= confer_search.getId() %>" name="conference_id" />
			                                <div class="col-md-12">
			                                    <input type="text" name="titre" value="<%= confer_search.getTitre() %>" id="titre" class="form-control" placeholder="Titre" required="required">
			                                </div>
			                                <div class="col-md-12" >
			                                	<textarea id="textarea_report" placeholder="description" name="description" ></textarea>
			                                </div>
			                                <script>
			                                document.onreadystatechange = function(){
			                                    if (document.readyState === "complete") {
			                                    	var content = "<%= confer_search.getDescription().replaceAll("\"", "\\\\\"").replaceAll("\n", "<br/>") %>";
			                                    	tinymce.get('textarea_report').setContent(content);
			                                    }
			                                    else {
			                                       window.onload = function () {
				                                    	var content = "<%= confer_search.getDescription().replaceAll("\"", "\\\\\"").replaceAll("\n", "<br/>") %>";
				                                    	tinymce.get('textarea_report').setContent(content);
			                                       };
			                                    };
			                                }
			                                </script>
			                                <div class="col-md-12">
			                                <label>Date commence soumission:</label>
			                                    	<input required="required" id="start_date_soum" type="datetime-local" value="<%= date_start_soumis %>" class="form-control" name="date_start_soumis" placeholder="Date debut soumission">
			                                </div>
			                                <div class="col-md-12">
			                                <label>Date fin soumission:</label>
			                                    	<input required="required" id="end_date_soum" type="datetime-local" class="form-control" value="<%= date_end_soumis %>" name="date_end_soumis" placeholder="Date fin soumission">
			                                </div>
			                                
			                                <div class="col-md-12">
			                                    <input type="text" name="adresse" adresse"" id="adresse" class="form-control" value="<%= confer_search.getAdresse() %>" placeholder="Adresse" required="required">
			                                </div>
			                                <div class="col-md-12">
			                                    <input type="number" name="telephone" id="telephone" value="<%= confer_search.getTelephone() %>" class="form-control" placeholder="Telephone" required="required">
			                                </div>
			                                <div class="col-md-12">
			                                <label>Date conference:</label>
			                                    <input type="datetime-local" name="date" id="ate" value="<%= date %>" class="form-control" placeholder="Date" required="required">
			                                </div>
											<div class="col-md-12">
			                                    <input type="email" name="email" id="email" value="<%= confer_search.getEmail() %>" class="form-control" placeholder="Email" required="required">
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
			            