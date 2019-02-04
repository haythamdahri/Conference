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
Papier mypaper = (Papier)session.getAttribute("mypaper_edit");

%>

			
			
	                <div class="row" style="width: 95%; margin-left: auto;margin-right: auto;">
	                	<% if( session.getAttribute("message_mypaper_edit") != null ){ %>
							<div class="alert alert-<%= session.getAttribute("message_mypaper_edit_type") %> text-center alert-dismissible" role="alert">
							  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							  <strong><i class="fas fa-info-circle"></i> <%= session.getAttribute("message_mypaper_edit") %></strong>
							</div>
							<%
								session.removeAttribute("message_mypaper_edit");
								session.removeAttribute("message_mypaper_edit_type");
							%>
						<% } %>
	                </div>
			
			<div class="col-md-12">
                    <div class="ticket-col">
                        <h2 class="text-center"><strong style="color: #ec5339;">Modification Papier id=<%= mypaper.getId() %></strong></h2>
                        
           						<form method="POST" id="add_these" action="<%= request.getAttribute("page_url") %>/updatepaper" >  
									 <fieldset>
									  <legend class="text-center text-uppercase"><h4  style="color: #337ab7;">Détails de papier</h4></legend>
			                              
		                            <div class="row">
		                            <input type="hidden" name="mypaper_id" value="<%= mypaper.getId() %>" />
		                            <input type="hidden" name="user_id" value="<%= myuser.getUser_id() %>" />
		                           
		                                <div class="col-md-12">
		                                    <select required="required" name="session_id" class="my-select form-control">
		                                    	<option disabled="disabled">Choisir la session</option>
		                                    	<% for( Session session_conference : sessionB.findByConferenceId(mypaper.getSession().getConference().getId()) ){ %>
			                                        <% String selected=""; %>
			                                        <% if( session_conference.getId() == mypaper.getSession().getId() ){ selected="selected"; } %>
			                                        
			                                        	<option value="<%= session_conference.getId() %>" <%= selected %>><%= session_conference.getTitre() %></option>
		                                        <% } %>
		                                    </select>
		                                </div>
		                                
		                                <div class="col-md-12">
		                                    <input required="required" type="text" value="<%= mypaper.getTitre() %>" class="form-control" name="titre" placeholder="titre">
		                                </div>
		                                <script>
			                                document.onreadystatechange = function(){
			                                    if (document.readyState === "complete") {
			                                    	var content = "<%= mypaper.getDescription().replaceAll("\"", "\\\\\"").replaceAll("\n", "<br/>") %>";
			                                    	tinymce.get('textarea_report').setContent(content);
			                                    }
			                                    else {
			                                       window.onload = function () {
				                                    	var content = "<%= mypaper.getDescription().replaceAll("\"", "\\\\\"").replaceAll("\n", "<br/>") %>";
				                                    	tinymce.get('textarea_report').setContent(content);
			                                       };
			                                    };
			                                }
		                                </script>
		                                <div class="col-md-12" >
		                                	<textarea id="textarea_report" placeholder="description" name="description" ></textarea>
		                                </div>
		                                <div class="col-md-12" >
		                                	<h4 style="color: #FFF;"><span id="chars_counter">0</span> caracteres</h4>
		                                </div>
		                                <div class="col-md-12 text-center">
			                                    <button class="btn btn-default my-btn btn-color" type="submit"><i class="far fa-save"></i> Enregistrer</button>
		                                </div>
		                            </div>
		                            </fieldset>
		                        </form>
		                        
           						             
                    </div>
           </div>
