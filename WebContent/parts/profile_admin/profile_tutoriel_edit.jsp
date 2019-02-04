<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.conference.entities.*" %>
<%@ page import="com.conference.dao.*" %>
<%@ page import="com.conference.business.*" %>
<%@ page import="java.util.*" %>
<%@page import="com.conference.entities.*" %>

<%

IConference conferenceBusiness1 = (ConferenceDAO)session.getAttribute("conferenceBusiness");
Tutoriel tutoriel_search = (Tutoriel)session.getAttribute("tutoriel");

%>

							
							 <div class="row" style="width: 95%; margin-left: auto;margin-right: auto;">
			                	<% if( session.getAttribute("message_tutoriel_edit") != null ){ %>
								<div class="alert alert-<%= session.getAttribute("message_tutoriel_edit_type") %> text-center alert-dismissible" role="alert">
								  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
								  <strong><i class="fas fa-info-circle"></i> <%= session.getAttribute("message_tutoriel_edit") %></strong>
								</div>
								<%
									session.removeAttribute("message_tutoriel_edit");
									session.removeAttribute("message_tutoriel_edit_type");
								%>
							<% } %>
			                </div>
	                
	      <div class="col-md-12" style="padding-bottom: 20%;">
                    <div class="ticket-col">
                        <h2 class="text-center"><strong style="color: #ec5339;">Ajout d'un nouveau tutoriel</strong></h2>
                        
			                            <form method="post" action="<%= request.getAttribute("page_url") %>/updatetutoriel" >          
									 <fieldset>
									  <legend class="text-center text-uppercase"><h4  style="color: #337ab7;">Détails de tutoriel</h4></legend>
			                              
			                               <input type="hidden" name="tutoriel_id" value="<%= tutoriel_search.getId() %>" />
											<div class="col-md-12">
			                                    <select required="required" name="conference_id" class="my-select form-control">
			                                    	<option disabled="disabled">Choisir la conference</option>
			                                    		<% for( Conference conf : conferenceBusiness1.findAll() ){ %>
			                                    		<% String selected = "";
			                                    			if( conf.getId() == tutoriel_search.getConference().getId() ){
			                                    				selected = "selected";
			                                    			}
			                                    		%>
				                                        	<option value="<%= conf.getId() %>" <%= selected %>><%= conf.getTitre() %> | <%= conf.getId() %></option>
			                                        	<% } %>
			                                    </select>
			                                </div>
											
											<div class="col-md-12">
			                                    <input type="text" name="titre"  id="titre" value="<%= tutoriel_search.getTitre() %>" class="form-control" placeholder="Titre" required="required">
			                                </div>
											
			                                <div class="col-md-12" style="margin-bottom: 2%;">
			                                	<textarea id="textarea_report" placeholder="description" name="description" ></textarea>
			                                </div>
			                                <script>
			                                document.onreadystatechange = function(){
			                                    if (document.readyState === "complete") {
			                                    	var content = "<%= tutoriel_search.getDescription().replaceAll("\"", "\\\\\"").replaceAll("\n", "<br/>") %>";
			                                    	tinymce.get('textarea_report').setContent(content);
			                                    }
			                                    else {
			                                       window.onload = function () {
				                                    	var content = "<%= tutoriel_search.getDescription().replaceAll("\"", "\\\\\"").replaceAll("\n", "<br/>") %>";
				                                    	tinymce.get('textarea_report').setContent(content);
			                                       };
			                                    };
			                                }
			                                </script>

			                               
			                                <div class="col-md-12 text-center">
			                                    <button class="btn btn-default my-btn btn-color" type="submit"><i class="far fa-save"></i> Enregistrer</button>
			                                </div>
			                                
			                                <div id="form-messages"></div>
			                                </fieldset>
			                            </form>
			                        </div>
			                    </div>
			            