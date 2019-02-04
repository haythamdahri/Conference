<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.conference.entities.*" %>
<%@ page import="java.util.*" %>
<%
Conference conference = (Conference)request.getAttribute("conference"); 

Administrateur administrateur = conference.getAdministrateur();
List<Papier> papiers = (List<Papier>)request.getAttribute("papiers");
IUser userBusiness = (UserDAO)request.getAttribute("userBusiness");
IInscription inscriptionBusiness = (InscriptionDAO)request.getAttribute("inscriptionBusiness");
ISession sessionBusiness = (SessionDAO)request.getAttribute("sessionBusiness");
IComite comiteBusiness = (ComiteDAO)request.getAttribute("comiteBusiness");

User user = userBusiness.find((String)session.getAttribute("email"), (String)session.getAttribute("password"));
boolean is_already_submitted = false;
Papier mypaper = null;
Calendar cal = Calendar.getInstance();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
Date dt = sdf.parse(String.valueOf(conference.getDate()));
cal.setTime(conference.getDate());

Date today = new Date();

%>

<% request.setAttribute("title", "Conference : "+conference.getTitre()); %>
<%@ include file="parts/header.jsp" %>

<body id="page-top" data-spy="scroll" data-target=".navbar-fixed-top">

    <!-- Preloader -->
    <div id="preloader">
        <div id="status"></div>
    </div>

	<%@include file="parts/nav_bar.jsp" %>




    <!-- Banner Start -->
    <section class="main-banner" style="background-image: url('<%= conference.getConverture() %>');">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="header-banner">
                        <h1><%= conference.getTitre() %></h1>
                        <h3><%= cal.get(Calendar.DAY_OF_MONTH)+", "+cal.getDisplayName(Calendar.MONTH, Calendar.LONG, Locale.FRANCE)+" "+cal.get(Calendar.YEAR) %></h3>
                        <h4><%= conference.getAdresse() %></h4>
                        <% 
                    		int month = cal.get(Calendar.MONTH);
	                        
                        	int day = cal.get(Calendar.DAY_OF_MONTH);
                        %>
                        <div class='countdown' data-date="<%= cal.get(1) %>-<%= Integer.parseInt(String.valueOf(month))+1 %>-<%= day %>"></div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    

    <!-- About Start -->
    <section class="about-area" id="about">
        <img class="left-img" src="static/images/left-img.png" alt="">
        <img class="right-img" src="static/images/right-img.png" alt="">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="about-col">
                        <h3><%= conference.getTitre() %></h3>
                        <p><%= conference.getDescription() %></p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="about-col">
                        <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
              
                   <!-- ========================== TUTORIALS ========================== -->
                            <% for( Tutoriel tutoriel : conference.getTutos() ) {%>
	                            <div class="panel panel-default">
	                                <div class="panel-heading" role="tab" id="heading<%= tutoriel.getId() %>"">
	                                    <h4 class="panel-title">
	                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse<%= tutoriel.getId() %>" aria-expanded="false" aria-controls="collapseFour">
	                                <%= tutoriel.getTitre() %>
	                            </a>
	                        </h4>
	                                </div>
	                                <div id="collapse<%= tutoriel.getId() %>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading<%= tutoriel.getId() %>">
	                                    <div class="panel-body">
	                                        <p><%= tutoriel.getDescription() %></p>
	                                    </div>
	                                </div>
	                            </div>
                            <% } %>
                   <!-- ========================== END TUTORIALS ========================== --> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Speakers Start -->
    <section class="speakers-area parallax" id="speakers">
        <div class="container">
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <div class="section-title">
                        <h2><span>Comités</span></h2>
                    </div>
                </div>
            </div>
            	
                <%
                	List<Session> sess = conference.getSessions();
                	if( sess.size() > 0 ){
                	for( Session session_conference : sess ){ 
                %>
                	<% for( Professeur professeur : session_conference.getComites() ){ %>
		                <div class="col-md-3 col-sm-6 col-xs-6 fw-600">
		                    <div class="speaker-col wow fadeInLeft animated" data-wow-duration=".5s" data-wow-delay=".3s">
		                        <div class="speaker-box">
		                            <a href="<%= professeur.getImage() %>" data-fancybox data-caption="<%= professeur.fullname() %>" >
			                            <div class="pic">
			                                <img src="<%= professeur.getImage() %>" style="width: 100%; height: 100%;" alt="" />
			                            </div>
		                            </a>
		                        </div>
		                        <div class="speaker-info">
		                            <h4><%= professeur.fullname() %></h4>
		                            <span><%= professeur.getMetier() %></span>
		                        </div>
		                    </div>
		                </div>
	                <% } } %>
                <% }else{%>
	                <div class="speaker-box">
						<div class="alert alert-info text-center">
						   <p><i class="fas fa-exclamation-triangle"></i> Aucun membre de comitée n'était choisit jusqu'a le moment!</p>
						</div>
					</div>
                <% } %>
        </div>
    </section>

    <!-- Organizer Start -->
    <section class="organizer-area" id="organizer">
        <img class="left-img" src="static/images/left-img.png" alt="">
        <img class="right-img" src="static/images/right-img.png" alt="">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="organizer-col">
                        <h3>Créée <br><span>Par</span></h3>
                        <h2><%= administrateur.getNom()+" "+administrateur.getPrenom() %></h2>
                        <h4>Contact</h4>
                        <p><i class="fa fa-phone" aria-hidden="true"></i> <%= administrateur.getTelephone() %></p>
                        <p><i class="fa fa-envelope-o" aria-hidden="true"></i> <%= administrateur.getEmail() %></p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="organizer-col" style="text-align: center;">
                    
                      	<a href="<%= administrateur.getImage() %>" data-fancybox data-caption="<%= administrateur.fullname() %>" >
	                        <img src="<%= administrateur.getImage() %>" style="height: auto; width: 60%;" alt="">
                       </a>
                    </div>
                </div>
            </div>
        </div>
    </section>



    <!-- Ticket Start -->
    <section class="ticket-area parallax" id="submitpaper">
        <div class="container">
            <div class="row">
                <div class="col-md-2">
                    <div class="ticket-col">
                        <h2>Dernier jour de soumission</h2>
                        <%
                        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                        Date end = df.parse(String.valueOf(conference.getDate_end_soumis()));
                        cal.setTime(end);
                        %>
                        <h3 class="text-center"><%= cal.get(Calendar.DAY_OF_MONTH)+", "+cal.getDisplayName(Calendar.MONTH, Calendar.LONG, Locale.FRANCE)+" "+cal.get(Calendar.YEAR) %></h3>
                    </div>
                </div>
                
                <% if ( user != null ) { 
                	//today is already declared 
	                Date date_start = conference.getDate_start_soumis();
	                Date date_end = conference.getDate_end_soumis();
	            %>
	                <!-- ========================== CHECK LIMITED DATE FOR SUBMISSION ========================== --> 
	            <%
	            	if( date_start.compareTo(today) <= 0 && date_end.compareTo(today) >= 0 && conference.getDate().compareTo(today) > 0){
	            %>
		                <% for( Papier papier : papiers ){ if( papier.getUser().getUser_id() == user.getUser_id() ){ mypaper = papier;is_already_submitted=true; } } %>
			                <% if( !is_already_submitted ){ %>
			                <!-- ========================== SUBMISSION FORM ========================== --> 
			                <div class="col-md-10">
			                    <div class="ticket-col">
			                        <h2>Soumettre votre thèse maintenant</h2>
			                        <form method="POST" id="add_these" action="<%= request.getContextPath() %>/submitpaper" >
			                            <div class="row">
			                            <input type="hidden" name="conference_id" value="<%= conference.getId() %>" />
			                            <input type="hidden" name="user_id" value="<%= user.getUser_id() %>" />
			                           
			                                <div class="col-md-12">
			                                    <select required="required" name="session_id" class="my-select form-control">
			                                    	<option disabled="disabled">Choisir la session</option>
			                                    	<% for( Session session_conference : conference.getSessions() ){ %>
				                                        <option value="<%= session_conference.getId() %>"><%= session_conference.getTitre() %></option>
			                                        <% } %>
			                                    </select>
			                                </div>
			                                
			                                <div class="col-md-12">
			                                    <input required="required" type="text" class="form-control" name="titre" placeholder="titre">
			                                </div>
			                                <div class="col-md-12" >
			                                	<textarea id="textarea_report" placeholder="description" name="description" ></textarea>
			                                </div>
			                                <div class="col-md-12 text-center" style="margin-top: 2%;">
			                                    <button class="btn btn-default my-btn btn-color" type="submit"><i class="fas fa-share-square"></i> Envoyer</button>
			                                </div>
			                            </div>
			                        </form>
			                    </div>
			                </div>
			               <!-- ========================== END SUBMISSION FORM ========================== --> 
			               <% }else{ %>
			               		<div class="col-md-10">
			                    	<div class="ticket-col">
			                    	<% boolean inscrit = false;
					                		for( Inscription ins : inscriptionBusiness.findAll() ){ if( ins.getUser().getUser_id() == user.getUser_id() && ins.getSession().getConference().getId() == conference.getId() ){ inscrit=true; } }
					                	%>
					                	
					                	
					                	<% if( !mypaper.getEtat().equals("refuse") ){ %>
					                	
					                	<% if( !inscrit ){ %>
						                	<div class="alert alert-danger text-center">
						                	<i class="fas fa-radiation"></i>
						                		Votre papier à été soumis, vous devez s'inscrir obligatoirement pour prendre en consideration votre papier!
						                		<br>
						                	
						                	<form method="POST" id="add_these" action="<%= request.getContextPath() %>/performregister" >
					                            <div class="row">
					                            <input type="hidden" name="mypaper_id" value="<%= mypaper.getId() %>" />
					                            <input type="hidden" name="user_id" value="<%= user.getUser_id() %>" />
					                                <div class="col-md-12 text-center">
													<button class="btn btn-success my-btn btn-color"><i class="far fa-check-circle"></i> S'inscrir</button>				                                </div>
					                            </div>
					                        </form>
			                        
			                        
						                	
						                	
						                	
						                	</div>
						                	
						                	<% }else{ %>
						                	
					                		<div class="alert alert-success text-center">
						                	<i class="fas fa-exclamation-circle"></i>
						                		Vous êtes déja inscrit dans cette conférence. Merci pour votre participation.
						                	</div>
						                	
						                	<% } %>
						                	
						                <% }else{ %>
						                <div class="alert alert-danger text-center">
						                	<i class="fas fa-exclamation-circle"></i>
						                		Désolé, votre papier à été refuse!
						                	</div>
					                	<% } %>
					                	
				                	</div>
			                	</div>
	               		   <% } %>
	               		   
	                <% }else{ %>
	                	<% if( conference.getDate().compareTo(today) < 0 ){ %>
				            <div class="col-md-10">
					            <div class="ticket-col">
				                	<div class="alert alert-warning text-center">
				                		<i class="fas fa-exclamation-circle"></i> La conférence est expirée
				                	</div>
			                	</div>
		                	</div>
	                	<% }else if( date_start.compareTo(today) > 0 ){ %>
				            <div class="col-md-10">
					            <div class="ticket-col">
				                	<div class="alert alert-warning text-center">
				                		<i class="fas fa-exclamation-circle"></i> La soumission des theses n'est pas encore ouverte!
				                	</div>
			                	</div>
		                	</div>
	                	<% }else{ %>
				            <div class="col-md-10">
					            <div class="ticket-col">
				                	<div class="alert alert-warning text-center">
				                		<i class="fas fa-exclamation-circle"></i> La date limite de soumission à été expirée!
				                	</div>
			                	</div>
		                	</div>
	                	<% } %>
	                <% } %>
	                <!-- ========================== END CHECK LIMITED DATE FOR SUBMISSION ========================== --> 
                <% }else{ %>
			            <div class="col-md-10">
				            <div class="ticket-col">
			                	<div class="alert alert-danger text-center">
			                		<i class="fas fa-exclamation-circle"></i> Vous n'êtes pas connecté, <a href="<%= request.getContextPath() %>/login">Se connecter</a>
			                	</div>
		                	</div>
	                	</div>
                <% } %>
            </div>
        </div>
    </section>

    <!-- Schedules Start -->
    <section class="schedule-area" id="schedules">
        <img class="left-img" src="static/images/left-img.png" alt="">
        <img class="right-img" src="static/images/right-img.png" alt="">
        <div class="container">
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <div class="section-title">
                        <h2>Sessions <span>de conference</span></h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="table-responsive schedule-table">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th><i class="far fa-calendar"></i> Session</th>
                                <th><i class="fab fa-speakap"></i> Orateur</th>
                                <th><i class="far fa-calendar"></i> Temps</th>
                            </tr>
                        </thead>
                        <tbody>
                            
                      <!-- ========================== SESSION ========================== -->
                      <% int i=1; 
                      	List<Session> sessions_conference = (List<Session>)sessionBusiness.findByConferenceId(conference.getId());
                      	if( sessions_conference.size() > 0 ){
                      %>
                            <% for( Session session_conference : sessionBusiness.findByConferenceId(conference.getId()) ){ %>
                            <tr class="<% if( i%2!=0 ){ %>table-row-bg<% } %>">
                                <td><%= String.format("%02d", i++) %></td>
                                <td><%= session_conference.getTitre() %></td>
                                <td>
									<% 
										Collection<Comite> comites = comiteBusiness.findBySessionId(session_conference.getId());
										out.println("|| ");
										for( Comite comite : comites ){
									%>
										<b><%= comite.fullname() %></b> || 
									<% } %>
									<% if( comites.size() == 0 ){ %>
										Aucun professeur!
									<% } %>
								</td>
								<% 
									Calendar calendarst = GregorianCalendar.getInstance(); // creates a new calendar instance
									calendarst.setTime(session_conference.getDate_start_session());   // assigns calendar to given date 
									calendarst.get(Calendar.HOUR_OF_DAY); // gets hour in 24h format
									calendarst.get(Calendar.HOUR);        // gets hour in 12h format
									calendarst.get(Calendar.MONTH);
									
									Calendar calendarend = GregorianCalendar.getInstance(); // creates a new calendar instance
									calendarend.setTime(session_conference.getDate_end_session());   // assigns calendar to given date 
									
								%>
                                <td><%= String.format("%02d", calendarst.get(Calendar.HOUR_OF_DAY))+":"+String.format("%02d", calendarst.get(Calendar.MINUTE)) %> - <%= String.format("%02d", calendarend.get(Calendar.HOUR_OF_DAY))+":"+String.format("%02d", calendarend.get(Calendar.MINUTE)) %></td>                            
                            </tr>
                            <% }}else{ %>
                            
                            <tr>
                            	<td colspan='4' class="alert alert-warning text-center">
			                		<i class="fas fa-exclamation-circle"></i> Aucune session n'a été ajouté!
                            	</td>
                            </tr>
                            <% } %>
                            
                            
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>


    <!-- Venue Start -->
    <section class="venue-area" id="venue">
        <div class="container">
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <div class="section-title">
                        <h2><span>Place d'organisation</span></h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3">
                    <div class="venue-col">
                        <div class="info-box">
                            <i class="flaticon-placeholder"></i>
                            <p><%= conference.getAdresse() %></p>
                        </div>
                        <div class="info-box">
                            <i class="flaticon-mail"></i>
                            <p><%= conference.getEmail() %></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="venue-col" style="text-align: center;">
                        <img src="<%= conference.getConverture() %>" style="height: auto;width: 60%;" alt="">
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="venue-col">
                        <div class="info-box">
                            <i class="flaticon-phone-call"></i>
                            <p><%= conference.getTelephone() %></p>
                        </div>
                        <div class="info-box">
                            <h4>Réseaux Sociaux</h4>
                            <ul>
                                <li><a href="javascript:void(0)"><i class="flaticon-facebook-logo-button"></i></a></li>
                                <li><a href="javascript:void(0)"><i class="flaticon-twitter-logo-button"></i></a></li>
                                <li><a href="javascript:void(0)"><i class="flaticon-linkedin-button"></i></a></li>
                                <li><a href="javascript:void(0)"><i class="flaticon-dribble-logo-button"></i></a></li>
                                <li><a href="javascript:void(0)"><i class="flaticon-google-plus-logo-button"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>


    <!-- Counter Start -->
    <section class="counter-area parallax">
        <div class="container">
            <div class="rowe">
                <div class="col-md-6 col-sm-6 col-xs-6 fw-600">
                    <div class="counter-col">
                        <div class="counter">
                            <div class="count"><%= papiers.size() %></div>
                            <img src="static/images/icon/1.png" alt="">
                        </div>
                        <p>Autheurs</p>
                    </div>
                </div>
                <div class="col-md-6 col-sm-6 col-xs-6 fw-600">
                    <div class="counter-col">
                        <div class="counter">
                            <div class="count"><%= conference.getInscriptions().size() %></div>
                            <img src="static/images/icon/2.png" alt="">
                        </div>
                        <p>Inscriptions</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Sponsors Start -->
    <section class="sponsor-area" id="sponsors">
        <img class="left-img" src="static/images/left-img.png" alt="">
        <img class="right-img" src="static/images/right-img.png" alt="">
        <div class="container">
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <div class="section-title">
                        <h2>Our Event <span>Sponsors</span></h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-2 col-sm-3 col-xs-3">
                    <div class="sponsor-col">
                        <a href="static/#"><img src="static/images/sponsor/1.png" alt=""></a>
                    </div>
                </div>
                <div class="col-md-2 col-sm-3 col-xs-3">
                    <div class="sponsor-col">
                        <a href="static/#"><img src="static/images/sponsor/2.png" alt=""></a>
                    </div>
                </div>
                <div class="col-md-2 col-sm-3 col-xs-3">
                    <div class="sponsor-col">
                        <a href="static/#"><img src="static/images/sponsor/3.png" alt=""></a>
                    </div>
                </div>
                <div class="col-md-2 col-sm-3 col-xs-3">
                    <div class="sponsor-col">
                        <a href="static/#"><img src="static/images/sponsor/4.png" alt=""></a>
                    </div>
                </div>
                <div class="col-md-2 col-sm-3 col-xs-3">
                    <div class="sponsor-col">
                        <a href="static/#"><img src="static/images/sponsor/5.png" alt=""></a>
                    </div>
                </div>
                <div class="col-md-2 col-sm-3 col-xs-3">
                    <div class="sponsor-col">
                        <a href="static/#"><img src="static/images/sponsor/6.png" alt=""></a>
                    </div>
                </div>
                <div class="col-md-2 col-sm-3 col-xs-3">
                    <div class="sponsor-col">
                        <a href="static/#"><img src="static/images/sponsor/7.png" alt=""></a>
                    </div>
                </div>
                <div class="col-md-2 col-sm-3 col-xs-3">
                    <div class="sponsor-col">
                        <a href="static/#"><img src="static/images/sponsor/8.png" alt=""></a>
                    </div>
                </div>
                <div class="col-md-2 col-sm-3 col-xs-3">
                    <div class="sponsor-col">
                        <a href="static/#"><img src="static/images/sponsor/9.png" alt=""></a>
                    </div>
                </div>
                <div class="col-md-2 col-sm-3 col-xs-3">
                    <div class="sponsor-col">
                        <a href="static/#"><img src="static/images/sponsor/10.png" alt=""></a>
                    </div>
                </div>
                <div class="col-md-2 col-sm-3 col-xs-3">
                    <div class="sponsor-col">
                        <a href="static/#"><img src="static/images/sponsor/11.png" alt=""></a>
                    </div>
                </div>
                <div class="col-md-2 col-sm-3 col-xs-3">
                    <div class="sponsor-col">
                        <a href="static/#"><img src="static/images/sponsor/12.png" alt=""></a>
                    </div>
                </div>
            </div>
        </div>
    </section>

  	
  	<!-- ========================== CONTACT INFORMATIONS ========================== -->
  	<%@include file="parts/contact_infos.jsp" %>
	
	<!-- ========================== FOOTER ========================== -->
    <%@include file="parts/footer.jsp" %>
    
    <!-- ========================== JAVASCRIPT ========================== -->
    <%@include file="parts/js.jsp" %>
    
	<!-- ========================== SWEETALERTS ========================== -->
    <%@include file="parts/sweet_alerts.jsp" %>
    
    <script>
    
    	$(".pic").css({'height':'200', 'width': '200', 'margin-right': 'auto', 'margin-left': 'auto'})
    
		<%
		if( conference.getDate().compareTo(today) < 0 ){ %>
			$("#modal_expired_conference").modal('show');
		<% } %>

    </script>
 
</body>


<!-- Mirrored from mvcsoftonline.com/html/ict/index-three.html by HTTrack Website Copier/3.x [XR&CO'2014], Sun, 30 Dec 2018 21:47:50 GMT -->
</html>