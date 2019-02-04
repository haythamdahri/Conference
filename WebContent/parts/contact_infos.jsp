<%@page import="com.conference.entities.*" %>
<!-- Contact Start -->
    <section class="contact-area" id="contact">
        <img class="left-img" src="static/images/left-img.png" alt="">
        <img class="right-img" src="static/images/right-img.png" alt="">
        <div class="container">
            <div class="row">
                <div class="">
                    <div class="col-md-4 col-sm-6">
                        <div class="contact-col contact-infobox">
                            <i class="fa fa-envelope" aria-hidden="true"></i>
                            <p><%= ((Conference)request.getAttribute("conference")).getEmail() %></p>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="contact-col contact-infobox">
                            <i class="fa fa-phone" aria-hidden="true"></i>
                            <p><%= ((Conference)request.getAttribute("conference")).getTelephone() %></p>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="contact-col contact-infobox">
                            <i class="fa fa-map-marker" aria-hidden="true"></i>
                            <p><%= ((Conference)request.getAttribute("conference")).getAdresse() %></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>