<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.conference.entities.*" %>
<%@ page import="java.util.*" %>
<% request.setAttribute("title", "Conference : Acceuil"); %>
<%@ include file="parts/header.jsp" %>

<% List<Conference> conferences = (List<Conference>)request.getAttribute("conferences"); %>


<body id="page-top" data-spy="scroll" data-target=".navbar-fixed-top">

    <!-- Preloader -->
    <div id="preloader">
        <div id="status"></div>
    </div>

	<%@include file="parts/navbar_not_transparent.jsp" %>
    
	<section class="contact-area" id="contact">
	    <div class="container">
			<div class="row">
					<div class="[ col-xs-12 col-sm-offset-2 col-sm-8 ]">
						<ul class="event-list">
						<% for( Conference conference : conferences ){ %>
							<li>
								<%
									Calendar cal = Calendar.getInstance();
									cal.setTime(conference.getDate());
								%>
								<time datetime="<%= conference.getDate() %>">
									<span class="day"><%= conference.getDate().getDate() %></span>
									<span class="month"><%= cal.getDisplayName(Calendar.MONTH, Calendar.LONG, Locale.FRANCE) %></span>
									<span class="year"><%= conference.getDate().getYear() %></span>
									<span class="time"><%= conference.getDate().getTime() %></span>
								</time>
								<img alt="Independence Day" src="<%= conference.getConverture() %>" />
								<div class="info text-center">
									<h2 class="title" style="font-size: 1.5em"><%= conference.getTitre() %></h2>
									<ul>
										<li style="width:50%;"><a href="<%= request.getContextPath() %>/conference?id=<%= conference.getId() %>"><span class="fa fa-plus"></span> Voir plus</a></li>
									</ul>
								</div>
							</li>
						<% } %>
						</ul>
					</div>
			</div>
		</div>
	</section>

    <!-- ========================== JAVASCRIPT ========================== -->
    <%@include file="parts/js.jsp" %>
    
    

</body>


</html>