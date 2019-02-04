<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.conference.entities.*" %>
<%@ page import="java.util.*" %>
<% request.setAttribute("title", "Conference : Register"); %>
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
                    <div class="col-md-4 col-sm-6">
                        <div class="contact-col contact-infobox">
                            <i class="fas fa-user-alt" aria-hidden="true"></i>
                            <p>Creer votre premier compte</p>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="contact-col contact-infobox">
                            <i class="fas fa-paperclip" aria-hidden="true"></i>
                            <p>Beneficier des chances de vie</p>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="contact-col contact-infobox">
                            <i class="fab fa-envira"></i>
                            <p>Realiser vos objectifs et attentes</p>
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
            			<% } %>
            	</div>
            </div>
            
            <div class="row contact-form-row">
                <div class="col-md-8 col-md-offset-2">
                    <div class="row">
                        <div class="contact-col">
                            <form method="post" action="<%= request.getContextPath() %>/register" enctype="multipart/form-data" >
                                <div class="col-md-6">
                                    <input type="text" name="username" id="username" class="form-control" placeholder="Username" required="required">
                                </div>
                                <div class="col-md-6">
                                    <input type="text" name="nom" id="nom" class="form-control" placeholder="Nom" required="required">
                                </div>
                                <div class="col-md-6">
                                    <input type="text" name="prenom" id="prenom" class="form-control" placeholder="Prenom" required="required">
                                </div>
                                <div class="col-md-6">
                                    <input type="email" name="email" id="email" class="form-control" placeholder="Email" required="required">
                                </div>
                                <div class="col-md-6">
                                    <input type="password" name="password" id="password" class="form-control" placeholder="Mot de passe" required="required">
                                </div>
                                <div class="col-md-6">
                                    <input type="number" name="telephone" id="telephone" class="form-control" placeholder="Telephone" required="required">
                                </div>
                                <div class="col-md-12" style="padding-bottom: 10px;">
                                <label>Image: </label>
                                	<input type="file" name="image" />
                                </div>
                                <div class="col-md-12">
                                        <button class="btn btn-default my-btn btn-color text-center" type="submit" value="Creer compte"><i class="fas fa-share-square"></i> Creer compte</button>
                                </div>
                                <div id="form-messages"></div>
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