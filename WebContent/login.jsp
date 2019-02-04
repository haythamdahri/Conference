<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.conference.entities.*" %>
<%@ page import="java.util.*" %>
<% request.setAttribute("title", "Conference : Login"); %>
<%@ include file="parts/header.jsp" %>


<body id="page-top" data-spy="scroll" data-target=".navbar-fixed-top">

    <!-- Preloader -->
    <div id="preloader">
        <div id="status"></div>
    </div>

	<%@include file="parts/navbar_not_transparent.jsp" %>
	
	<section class="contact-area" id="contact">
        <img class="left-img" src="static/images/left-img.png" alt="">
        <img class="right-img" src="static/images/right-img.png" alt="">
        <div class="container">
            <div class="row">
                <div class="">
                    <div class="col-md-12 col-sm-12">
                        <div class="contact-col contact-infobox">
                            <i class="fas fa-user-alt" aria-hidden="true"></i>
                            <p>Ouverture du compte</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- ========================== ERRORS ========================== -->
            <div class="container">
            	<div class="row">
            			<% if( request.getAttribute("message") != null && request.getAttribute("error") != null && (boolean)request.getAttribute("error") ){ %>
            				<div class="alert alert-danger text-center text-bold">
            					<p><i class="fas fa-exclamation-triangle"></i> <%= request.getAttribute("message") %></p>
            				</div>
            			<% }else if( session.getAttribute("message") != null && session.getAttribute("success") != null && (boolean)session.getAttribute("success") ){ %>
        					<div class="alert alert-success text-center text-bold">
		    					<p><i class="fas fa-check-double"></i> <%= session.getAttribute("message") %></p>
		    				</div>
		    			<% 
		    				session.removeAttribute("message");
		    				session.removeAttribute("success");
            			} %>
            	</div>
            </div>
            
            <div class="row contact-form-row">
                <div class="col-md-8 col-md-offset-2">
                    <div class="row">
                        <div class="contact-col">
                            <form method="post" action="<%= request.getContextPath() %>/login" >
                                <div class="col-md-12">
                                    <input type="email" name="email" id="email" class="form-control" placeholder="Email" required="required">
                                </div>
                                <div class="col-md-12">
                                    <input type="password" name="password" id="password" class="form-control" placeholder="Mot de passe" required="required">
                                </div>
                                <div class="col-md-12">
                                        <button class="btn btn-default my-btn btn-color text-center" type="submit" ><i class="fas fa-sign-in-alt"></i> Se connecter</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    


   
  	<!-- ========================== CONTACT INFORMATIONS ========================== -->
	
	<!-- ========================== FOOTER ========================== -->
    <%@include file="parts/footer.jsp" %>
    
    <!-- ========================== JAVASCRIPT ========================== -->
    <%@include file="parts/js.jsp" %>
    
    

</body>


</html>