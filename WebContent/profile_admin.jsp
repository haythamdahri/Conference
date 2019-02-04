<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.conference.entities.*" %>
<%@ page import="com.conference.dao.*" %>
<%@ page import="com.conference.business.*" %>
<%@ page import="java.util.*" %>
<%@page import="com.conference.entities.*" %>
<% request.setAttribute("title", "Conference : Profile"); %>
<%@ include file="parts/header.jsp" %>

<%
IUser userBusiness = (UserDAO)session.getAttribute("userBusiness");
IProfesseur professeurBusiness = (ProfesseurDAO)session.getAttribute("professeurBusiness");
IAdministrateur administrateurBusiness = (AdministrateurDAO)session.getAttribute("administrateurBusiness");
IConference conferenceBusiness = (ConferenceDAO)session.getAttribute("conferenceBusiness");
IPapier papierBusiness = (PapierDAO)session.getAttribute("papierBusiness");
ITutoriel tutBusiness = (TutorielDAO)session.getAttribute("tutorielBusiness");
IInscription inscrB = (InscriptionDAO)session.getAttribute("inscriptionBusiness");
IAffectation affectationB= (AffectationDAO)session.getAttribute("affectationBusiness");
ISession sesB = (SessionDAO)session.getAttribute("sessionBusiness");

Conference conference_search = (Conference)request.getAttribute("conference");
User user_search = (User)request.getAttribute("user_search");
Session session_search = (Session)request.getAttribute("session");

User user = (User)session.getAttribute("user");
Professeur professeur = (Professeur)session.getAttribute("professeur");
Administrateur administrateur = (Administrateur)session.getAttribute("administrateur");

List<Conference> conferences = (List<Conference>)conferenceBusiness.findAll();

List<User> users = (List<User>)request.getAttribute("users");


%>

<style>body{background-color: #f3f3f3;}</style>
<body id="page-top" data-spy="scroll" data-target=".navbar-fixed-top">

    <!-- Preloader -->
    <div id="preloader">
        <div id="status"></div>
    </div>

	<%@include file="parts/navbar_not_transparent.jsp" %>
	
<section class="venue-area" id="venue">
	<div class="container-fluid">
		<div class="row">
		
    	<div class="col-2 col-md-2 col-sm-2 col-xs-2 col-lg-2" >
			<div class="navbar row navbar-inverse navbar-fixed-left"  style="padding: 0;background-color: #4987ce;border-color: #4987ce;font-size: 20px;text-transform: capitalize; box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19); ">
			  <ul class="nav navbar-nav" style="width: 100%;">
				<li class='<% if( request.getParameterMap().isEmpty() || (request.getParameter("addconference") == null && request.getParameter("addregistration") == null && request.getParameter("addtutoriel") == null && request.getParameter("addsession") == null && request.getParameter("addassignement") == null && request.getParameter("assignement") == null && request.getParameter("registration") == null && request.getParameter("tutoriel") == null && request.getParameter("conference") == null && request.getParameter("session") == null && request.getParameter("user") == null && request.getParameter("paper") == null && request.getParameter("mypaper") == null) ){ %>active<% } %>' style="font-size:1.35vw; box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);"><a style="color: #FFF;" href="<%= request.getAttribute("page_url") %>" ><i class="fas fa-user-alt"></i> Mon profil</h4> </a></li>
				<li class='<% if( request.getParameter("conference") != null || request.getParameter("addconference") != null ){ %>active<% } %>' style="font-size:1.2vw; box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);"><a style="color: #FFF;" href="<%= request.getAttribute("page_url") %>?conference=all" ><i class="fab fa-meetup"></i> Les conférences <span class="badge" style="font-size:1.35vw;background-color: #ec5339; box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);"><%= conferences.size() %></span></a></li>
				<li class="<% if( request.getParameter("user") != null ){ %>active<% } %>" style="font-size:1.2vw; box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);"><a style="color: #FFF;" href="<%= request.getAttribute("page_url") %>?user=all"><i class="fas fa-users-cog"></i> Les utilisateurs</h4> <span class="badge" style="font-size:1.35vw;background-color: #ec5339; box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);"><%= users.size() %></span></a></li>
				<li class="<% if( request.getParameter("session") != null || request.getParameter("addsession") != null ){ %>active<% } %>" style="font-size:1.2vw; box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);"><a style="color: #FFF;" href="<%= request.getAttribute("page_url") %>?session=all"><i class="far fa-calendar"></i> Les sessions <span class="badge" style="font-size:1.35vw;background-color: #ec5339; box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);"><%= sesB.findAll().size() %></span></a></li>
			   	<li class="<% if( request.getParameter("paper") != null ){ %>active<% } %>" style="font-size:1.2vw; box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);"><a style="color: #FFF;" href="<%= request.getAttribute("page_url") %>?paper=all" ><i class="fas fa-paperclip"></i> Les papiers  soumis</h4> <span class="badge" style="font-size:1.35vw;background-color: #ec5339; box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);"><%= papierBusiness.findAll().size() %></span></a></li>
			   	<li class="<% if( request.getParameter("mypaper") != null ){ %>active<% } %>" style="font-size:1.2vw; box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);"><a style="color: #FFF;" href="<%= request.getAttribute("page_url") %>?mypaper" ><i class="fas fa-paper-plane"></i> Mes papiers  soumis <span class="badge" style="font-size:1.35vw;background-color: #ec5339; box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);"><%=  papierBusiness.findByUserId(user.getUser_id()).size() %></span> </a></li>
			   	<li class="<% if( request.getParameter("tutoriel") != null || request.getParameter("addtutoriel") != null ){ %>active<% } %>" style="font-size:1.2vw; box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);"><a style="color: #FFF;" href="<%= request.getAttribute("page_url") %>?tutoriel" ><i class="fas fa-magic"></i> Les tutoriels</h4> <span class="badge" style="font-size:1.35vw;background-color: #ec5339; box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);"><%= tutBusiness.findAll().size() %></span></a></li>
				<li class="<% if( request.getParameter("registration") != null || request.getParameter("addregistration") != null ){ %>active<% } %>" style="font-size:1.2vw; box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);"><a style="color: #FFF;" href="<%= request.getAttribute("page_url") %>?registration" ><i class="fas fa-greater-than-equal"></i> Les inscriptions</h4> <span class="badge" style="font-size:1.35vw;background-color: #ec5339; box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);"><%= inscrB.findAll().size() %></span></a></li>
				<li class="<% if( request.getParameter("assignement") != null || request.getParameter("addassignement") != null ){ %>active<% } %>" style="font-size:1.2vw; box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);"><a style="color: #FFF;" href="<%= request.getAttribute("page_url") %>?assignement" ><i class="fas fa-hand-point-right"></i> Les affectations</h4> <span class="badge" style="font-size:1.35vw;background-color: #ec5339; box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);"><%= affectationB.findAll().size() %></span></a></li>		  
			  </ul>
			</div>
    	</div>
    	
    	<div class="col-10 col-md-10 col-sm-10 col-xs-10 col-lg-10"  style="margin-top: 2%;float: right">
        
        
			<% if( request.getAttribute("message") != null ){ %>
				<div class="alert alert-<%= request.getAttribute("message_type") %> text-center alert-dismissible" role="alert">
				  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				  <strong><i class="fas fa-info-circle"></i> <%= request.getAttribute("message") %></strong>
				</div>
			<% } %>
			
			
        
	
		<% if( request.getParameter("conference") != null && request.getParameterMap().size() == 1 ){ %>
			
			<%@include file="parts/profile_admin/profile_conference.jsp" %>
			
		<% }else if( request.getParameter("user") != null && request.getParameterMap().size() == 1  ){ %>
			<form style="margin-bottom: 2%;">
				<div class="input-group">
				  <span class="input-group-addon" id="sizing-addon2">ID</span>
				  <input type="number" value="<%= request.getParameter("user") %>" class="form-control" placeholder="ID USER" name="user" aria-describedby="sizing-addon2">
				</div>
			</form>
			
			<%@ include file="parts/profile_admin/profile_user.jsp" %>
			
		<% }else if( request.getParameter("session") != null && request.getParameterMap().size() == 1 ){ %>
			<form style="margin-bottom: 2%;">
				<div class="input-group">
				  <span class="input-group-addon" id="sizing-addon2">ID</span>
				  <input type="number" value="<%= request.getParameter("session") %>" class="form-control" placeholder="ID SESSION" name="session" aria-describedby="sizing-addon2">
				</div>
			</form>
			
			<%@ include file="parts/profile_admin/profile_session.jsp" %>
			
		<% }else if( request.getParameter("settings") != null ){%>
			
			<%@ include file="parts/profile_admin/profile_settings.jsp" %>
		
		<% }else if( request.getParameter("addsession") != null ){ %>
			
			<%@ include file="parts/profile_admin/profile_session_add.jsp" %>
			
		<% }else if( request.getParameter("paper") != null && request.getParameterMap().size() == 1  ){ %>
			<form style="margin-bottom: 2%;">
				<div class="input-group">
				  <span class="input-group-addon" id="sizing-addon2">ID</span>
				  <input type="number" value="<%= request.getParameter("paper") %>" class="form-control" placeholder="ID PAPIER" name="paper" aria-describedby="sizing-addon2">
				</div>
			</form>
			
			<%@ include file="parts/profile_admin/profile_paper.jsp" %>
			
		<% }else if( request.getParameter("paper") != null && request.getParameter("edit") != null && request.getParameterMap().size() == 2 ){ %>
		
			<%@ include file="parts/profile_admin/profile_paper_edit.jsp" %>
		
		<% }else if( request.getParameter("mypaper") != null && request.getParameterMap().size() == 1 ){ %>
			<form style="margin-bottom: 2%;">
				<div class="input-group">
				  <span class="input-group-addon" id="sizing-addon2">ID</span>
				  <input type="number" value="<%= request.getParameter("mypaper") %>" class="form-control" placeholder="ID PAPIER" name="mypaper" aria-describedby="sizing-addon2">
				</div>
			</form>
			
			<%@ include file="parts/profile_admin/profile_mypaper.jsp" %>
		
		<% }else if( request.getParameter("session") != null && request.getParameter("edit") != null && request.getParameterMap().size() == 2 ){ %>

			<%@ include file="parts/profile_admin/profile_session_edit.jsp" %>
			
		<% }else if( request.getParameter("mypaper") != null && request.getParameter("edit") != null && request.getParameterMap().size() == 2 ){ %>
				
			<%@ include file="parts/profile_admin/profile_mypaper_edit.jsp" %>	
				
		<%}else if( request.getParameter("conference") != null && request.getParameter("edit") != null && request.getParameterMap().size() == 2 ){ %>
		
	        <%@ include file="parts/profile_admin/profile_conference_edit.jsp" %>
	        
	    <% }else if( request.getParameter("addconference") != null ){ %>
	    
	    	<%@ include file="parts/profile_admin/profile_conference_add.jsp" %>
	    
	    <% }else if( request.getParameter("tutoriel") != null && request.getParameterMap().size() == 1 ){ %>
	    
	    	<%@ include file="parts/profile_admin/profile_tutoriel.jsp" %>
	    
	    <% }else if( request.getParameter("tutoriel") != null && request.getParameter("edit") != null && request.getParameterMap().size() == 2 ){ %>
	    	
	    	<%@ include file="parts/profile_admin/profile_tutoriel_edit.jsp" %>
	    	
	    <% }else if( request.getParameter("addtutoriel") != null ){ %>
	    	
	    	<%@ include file="parts/profile_admin/profile_tutoriel_add.jsp" %>
	    
	    <% }else if( request.getParameter("registration") != null && request.getParameterMap().size() == 1 ){ %>
	    	<form style="margin-bottom: 2%;">
				<div class="input-group">
				  <span class="input-group-addon" id="sizing-addon2">ID</span>
				  <input type="number" value="<%= request.getParameter("registration") %>" class="form-control" placeholder="ID INSCRIPTION" name="registration" aria-describedby="sizing-addon2">
				</div>
			</form>
			
	    	<%@ include file="parts/profile_admin/profile_registration.jsp" %>
	    	
	    <% }else if( request.getParameter("assignement") != null && request.getParameterMap().size() == 1 ){ %>
	    	<form style="margin-bottom: 2%;">
				<div class="input-group">
				  <span class="input-group-addon" id="sizing-addon2">ID</span>
				  <input type="number" value="<%= request.getParameter("assignement") %>" class="form-control" placeholder="ID AFFECTATION PAPIER" name="assignement" aria-describedby="sizing-addon2">
				</div>
			</form>
			
	    	<%@ include file="parts/profile_admin/profile_assignement.jsp" %>
    	
    	<% }else if( request.getParameter("assignement") != null && request.getParameter("edit") != null && request.getParameterMap().size() == 2 ){ %>
    	
    	<%@ include file="parts/profile_admin/profile_assignement_edit.jsp" %>
	    	
	    <% }else if( request.getParameter("addassignement") != null ){ %>
	    	
	    	<%@ include file="parts/profile_admin/profile_assignement_add.jsp" %>
	    
		<% }else{ %>
        
        <!-- Profile details -->
        <div class="panel panel-default">
               <div class="panel-heading resume-heading" style=" box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19); ">
                  <div class="row">
                  <div class="col-lg-12 text-center">
                  	<h1><span class="label label-primary" style=" background-color: #4987cd;box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19); ">
                  	<% if( administrateur != null ){ %>
                  	<i class="fas fa-user-tie"></i> ADMINISTRATEUR
                  	<% }else if( professeur != null ){ %>
                  	<i class="fas fa-chalkboard-teacher"></i> PROFESSEUR
                  	<% }else{ %>
                  	<i class="fas fa-user"></i> UTILISATEUR
                  	<% } %>
                  	</span></h1>
                  </div>
                     <div class="col-lg-12">
                        <div class="col-xs-12 col-sm-4">
                           <figure style=" margin-top: 8%; ">
                              <a href="<%= professeur.getImage() %>" data-fancybox data-caption="<%= professeur.fullname() %>" >
                              	<img class="img-circle img-responsive" id="user-pic" alt="" src="<%= user.getImage() %>" style=" box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19); height: 100%; width: 100%; margin-right: auto; margin-left: auto; " />
                           	  </a>   
                        </div>
                        <div class="col-xs-12 col-sm-8" >
                           <ul class="list-group" style=" margin-top: 3%;box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19); ">
                              <li class="list-group-item"><%= user.getUsername() %></li>
                              <li class="list-group-item"><%= user.fullname() %></li>
                              <% if( professeur != null ){ %>
                              <li class="list-group-item"><%= professeur.getMetier() %></li>
                              <% }else{ %>
                              <li class="list-group-item">Utilisateur</li>
                              <% } %>
                              <li class="list-group-item"><i class="fa fa-phone"></i> <%= user.getTelephone() %> </li>
                              <li class="list-group-item"><i class="fa fa-envelope"></i> <%= user.getEmail() %></li>
                           </ul>
                        </div>
         </div>
        <!-- resume -->

    	</div>
	</div>
	
	
	
	    
   <!-- =============================== STATISTICS =============================== --> 
   <canvas style=" box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19); " id="myChart" style="margin-bottom: 10%;"  height="40vh" width="80vw"></canvas>
	
	
	
	
	</div>
	<% } %>
	
	

	
	
	</div>
	</div>
	</div>
</section>
    


   
  	<!-- ========================== CONTACT INFORMATIONS ========================== -->

    <!-- ========================== JAVASCRIPT ========================== -->
    <%@include file="parts/js.jsp" %>
    
    
    

</body>


</html>