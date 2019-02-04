 <header class="main-header main-header-two">
        <!-- Navigation Start -->
        <div class="main-nav">
            <nav class="navbar navbar-default navbar-fixed-top" id="navbar-main">
                <div class="container">
                    <div class="navbar-header page-scroll">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand page-scroll" href="<%= request.getContextPath()%>/"><img class="main-logo" src="static/images/logo/logo.png" alt=""> </a>
                    </div>

                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse navbar-ex1-collapse">
                        <ul class="nav navbar-nav navbar-right">
                            <!-- Hidden li included to remove active class from about link when scrolled up past about section -->
                            <li> <a class="page-scroll" href="<%= request.getContextPath()%>/"><i class="fas fa-home"></i> Acceuil</a> </li>
                         
                            <% if ( session.getAttribute("email") != null && session.getAttribute("password") != null && session.getAttribute("username") != null ) { %>
                            
	                            <li class="dropdown">                       
	                      		<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fas fa-user-circle"></i> <%= session.getAttribute("username") %> <span class="caret"></span></a>
		                             <ul class="dropdown-menu">
		                            <!-- Hidden li included to remove active class from about link when scrolled up past about section -->
		                            <li> <a class="page-scroll" href="<%=  session.getAttribute("profile_path") %>"><i class="fas fa-user-alt"></i> Mon profil</a> </li>
		                            <li> <a class="page-scroll" href="<%=  session.getAttribute("profile_path") %>?settings"><i class="fas fa-user-shield"></i> Parametres</a> </li>
	                            </ul>
	                            </li>
                      	     
	                            <li> <a class="page-scroll" href="<%= request.getContextPath() %>/logout"><i class="fas fa-sign-out-alt"></i> Deconnexion</a> </li>
                            <%}else{ %>
	                            <li> <a class="page-scroll" href="<%= request.getContextPath() %>/login"><i class="fas fa-user-circle"></i> Se connecter</a> </li>
	                            <li> <a class="page-scroll" href="<%= request.getContextPath() %>/register"><i class="far fa-address-card"></i> Creer Compte</a> </li>
                            <% } %>
                        </ul>
                    </div>
                    <!-- /.navbar-collapse -->
                </div>
                <!-- /.container -->
            </nav>
        </div>
    </header>