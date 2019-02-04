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
ISession sesBus = (SessionDAO)session.getAttribute("sessionBusiness");

Professeur prof = (Professeur)session.getAttribute("professeur");

%>

			
			
	                <div class="row" style="width: 95%; margin-left: auto;margin-right: auto;">
	                	<% if( session.getAttribute("message_assignement") != null ){ %>
							<div class="alert alert-<%= session.getAttribute("message_assignement_type") %> text-center alert-dismissible" role="alert">
							  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							  <strong><i class="fas fa-info-circle"></i> <%= session.getAttribute("message_assignement") %></strong>
							</div>
							<%
								session.removeAttribute("message_assignement");
								session.removeAttribute("message_assignement_type");
							%>
						<% } %>
	                </div>
			
			<div class="col-md-12">
                    <div class="ticket-col">
                    
                    <script>
                    var sessions = [];
		                    <% 
		                    List<Integer> professors_ids = new ArrayList<>();
		                    for( Comite comite : comiteBusiness.findAll() ){ %>
			                		sessions.push(['<%= comite.getComite_id() %>', ['<%= comite.getSession().getId() %>', '<%= comite.fullname() %> | Session: <b><%= comite.getSession().getId() %></b>']])
			            		<% }          	%>
		            var papiers = [];
				            <% for( Papier p : papierBusi.findAll() ){ %>
	                		papiers.push(['<%= p.getId() %>', ['<%= p.getSession().getId() %>', '<%= p.getTitre() %> | <%= p.getUser().fullname() %>, <%= p.getUser().getUser_id() %>']])
		            		<% } %>
		            function changeOptions(select){
		            	var session_id = $(select).val();
	            		$("#comites").empty();
		            	for( var i=0; i<sessions.length; i++ ){
		            		var row = sessions[i];
		            		var comite_id = row[0];
		            		var data = row[1];
		            		var ses_id = data[0];
		            		var option_text = data[1];
		            		if( session_id == ses_id ){
		            			var node = "<option value='"+comite_id+"'>"+option_text+"</option>";
		            			$("#comites").append(node);
		            		}
		            	}
	            		if( $('#comites option').length > 0 ){
	            			$("#comites").removeAttr('disabled');
	            		}else{
	            			$("#comites").attr('disabled', 'disabled');
	            		}

	            		$("#papiers").empty();
	            		for( var i=0; i<papiers.length; i++ ){
		            		var row = papiers[i];
		            		console.log(row);
		            		var papier_id = row[0];
		            		var data = row[1];
		            		var ses_id = data[0];
		            		var option_text = data[1];
		            		if( session_id == ses_id ){
		            			var node = "<option value='"+papier_id+"'>"+option_text+"</option>";
		            			$("#papiers").append(node);
		            			console.log(node);
		            		}
		            	}
	            		if( $('#papiers option').length > 0 ){
	            			$("#papiers").removeAttr('disabled');
	            		}else{
	            			$("#papiers").attr('disabled', 'disabled');
	            		}
	            		
		            } 
                    </script>
                    
                        <h2 class="text-center"><strong style="color: #ec5339;">Ajout d'une nouvelle affectation</strong></h2>
                        <form method="POST" action="<%= request.getAttribute("page_url") %>/addassignement" >      
									 <fieldset>
									  <legend class="text-center text-uppercase"><h4  style="color: #337ab7;">Détails d'affectation</h4></legend>
			                              
                            <div class="row">
                           
                           		<div class="col-md-12">
                                <label>Session: </label>
                                    <select onchange="changeOptions(this)"  required="required" name="conference_id" class="my-select form-control">
                                    	<option>Choisir la session</option>
                                    		<% for( Session ses : sesBus.findByPresidentId(prof.getProfesseur_id()) ){ %>
	                                        	<option value="<%= ses.getId() %>"><%= ses.getTitre() %>, <%= ses.getId() %> | Conference: <%= ses.getConference().getTitre() %>, <%= ses.getConference().getId() %></option>
                                        	<% } %>
                                    </select>
                                </div>
                                
                           		<div class="col-md-12">
                                <label>Professeur: </label>
                                    <select disabled="disabled" required="required" name="comite_id" id="comites" class="my-select form-control">
                                    </select>
                                </div>
                                
                                <div class="col-md-12">
                                <label>Papier: </label>
                                    <select disabled="disabled" required="required" name="papier_id" id="papiers" class="my-select form-control">
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
