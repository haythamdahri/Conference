<%@include file="modals.jsp" %>

<!-- jQuery -->
    <script src="static/js/jquery.min.js"></script>

    <!-- Bootstrap Min js -->
    <script src="static/js/bootstrap.min.js"></script>
    <!-- scrolling-nav JS -->
    <script src="static/js/scrolling-nav.js"></script>
    <!-- jquery easing JS -->
    <script src="static/js/jquery.easing.min.js"></script>
    <!-- counterup -->
    <script src="static/js/jquery.counterup.min.js"></script>
    <!-- waypoints -->
    <script src="static/js/jquery.waypoints.min.js"></script>
    <!-- carousel -->
    <script src="static/js/owl.carousel.min.js"></script>
    <!-- wow js -->
    <script src="static/js/wow.min.js"></script>
    <!-- particles js -->
    <script src="static/js/particles.min.js"></script>
    <!-- app js -->
    <script src="static/js/app.js"></script>
    <!-- countdown JS -->
    <script src="static/js/countdown.js"></script>
    <!-- jquery.plate JS -->
    <script src="static/js/jquery.plate.js"></script>
    <!-- jarallax JS -->
    <script src="static/js/jarallax.min.js"></script>
    <!-- jquery scrollUp  JS -->
    <script src="static/js/jquery.scrollUp.min.js"></script>
    <!-- tinyMce JS -->
    <script src="static/js/tinymce.min.js"></script>
    <!-- Chart JS -->
    <script src="static/js/Chart.min.js"></script>
    <!-- Sweetalert JS -->
    <script src="static/js/sweetalert2.all.min.js"></script>
    
    <!-- FancyBox JS -->
    <script src="static/js/jquery.fancybox.min.js"></script>
    
    <!-- Main Custom JS -->
    <script src="static/js/custom.js"></script>
    
    
    
    
    <script type="text/javascript">
    
    $("#user-pic").css({'height':'200','width':'200', 'margin-left': 'auto', 'margin-right': 'auto'});
    
	    tinymce.init({
	        selector: '#textarea_report',
	        max_height: 500,
	        max_width: 500,
	        min_height: 100,
	        min_width: 400,
	        height: 400,
	        statusbar: false,
	        force_br_newlines : true,
	        force_p_newlines : false,
	        forced_root_block : ''
	      });
	    
	    tinyMCE.init({
	        setup : function(ed) {
	            ed.onBeforeSetContent.add(function(ed, o) {
	                if (o.initial) {
	                    o.content = o.content.replace(/\r?\n/g, '<br />');
	                }
	            });
	        }
	    });
	    
	    function CountCharacters() {
	        var body = tinymce.get("textarea_report").getBody();
	        var content = tinymce.trim(body.innerText || body.textContent);
	        return content.length;
	    };
	    
	    function setContent(textarea_report, content){
	    	$("#"+textarea_report).html(content);
	    }
	    
	    function ViewPaper(paper_id){
	    	$("#modal_description_view"+paper_id).modal('show');
	    }
	    
	    
	    /*$("#add_these").on('submit', (event)=>{
	    	event.preventDefault();
	    	var count = CountCharacters();
	    	if( count < 30 ){
	    		$("#modal_error_these").modal("show");
	    		console.log(count);
	    	}else{
	    		$("#add_these").submit();
	    	}
	    });*/
	    
	    function deleteRow(form_id, label){
	    	Swal({
	    		  title: 'Voulez-vous vraiment supprimer '+label+'?',
	    		  text: "Attention!",
	    		  type: 'warning',
	    		  showCancelButton: true,
	    		  confirmButtonColor: '#3085d6',
	    		  cancelButtonColor: '#d33',
	    		  cancelButtonText: '<i class="fas fa-ban"></i> Annuler',
	    		  confirmButtonText: '<i class="fas fa-radiation-alt"></i> Oui, supprimer '+label+'!'
	    		}).then((result) => {
	    		  if (result.value) {
	    		    $("#"+form_id).submit();
	    		  }
	    		})
	    }
	    
	    function doAction(form_id, label, action){
	    	Swal({
	    		  title: 'Voulez-vous vraiment '+action+' '+label+'?',
	    		  text: "Attention!",
	    		  type: 'warning',
	    		  showCancelButton: true,
	    		  confirmButtonColor: '#3085d6',
	    		  cancelButtonColor: '#d33',
	    		  cancelButtonText: '<i class="fas fa-ban"></i> Annuler',
	    		  confirmButtonText: '<i class="fas fa-radiation-alt"></i> Oui, '+action+' '+label+'!'
	    		}).then((result) => {
	    		  if (result.value) {
	    		    $("#"+form_id).submit();
	    		  }
	    		})
	    }
	    
    </script>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.conference.entities.*" %>
<%@ page import="com.conference.dao.*" %>
<%@ page import="com.conference.business.*" %>
<%@ page import="java.util.*" %>
<%@page import="com.conference.entities.*" %>
<%
IProfesseur professeurBus = (ProfesseurDAO)session.getAttribute("professeurBusiness");
IAdministrateur administrateurBus = (AdministrateurDAO)session.getAttribute("administrateurBusiness");
IConference conferenceBus = (ConferenceDAO)session.getAttribute("conferenceBusiness");
IPapier papierBus = (PapierDAO)session.getAttribute("papierBusiness");
ITutoriel tutoBus = (TutorielDAO)session.getAttribute("tutorielBusiness");
ISession sessionBus = (SessionDAO)session.getAttribute("sessionBusiness");
IInscription inscriptionBus = (InscriptionDAO)session.getAttribute("inscriptionBusiness");
IUser userBus = (UserDAO)session.getAttribute("userBusiness");
IComite comiteBus = (ComiteDAO)session.getAttribute("comiteBusiness");
IAffectation affectationBus = (AffectationDAO)session.getAttribute("affectationBusiness");
IPresident presidentBus = (PresidentDAO)session.getAttribute("presidentBusiness");


%>
    
<% if( request.getAttribute("showStatistics") != null && (boolean)request.getAttribute("showStatistics") ){ %> 
<script>

var ctx = document.getElementById("myChart").getContext('2d');
var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ['Utiliateurs', 'Professeurs', 'Administrateurs', 'Conferences', 'Presidents', 'Comites', 'Papiers', 'Affectations', 'Tutoriels', 'Sessions', 'Inscriptions'],
        datasets: [{
            label: 'Compteur ',
            data: [<%= userBus.findAll().size() %>, <%= professeurBus.findAll().size() %>, <%= administrateurBus.findAll().size() %>, <%= conferenceBus.findAll().size() %>,
            	<%= presidentBus.findAll().size() %>, <%= comiteBus.findAll().size() %>, <%= papierBus.findAll().size() %>, <%= affectationBus.findAll().size() %>, <%= tutoBus.findAll().size() %>, <%= sessionBus.findAll().size() %>, <%= inscriptionBus.findAll().size() %>],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],

            borderWidth:1,
            borderColor:'#777',
            hoverBorderWidth:3,
            hoverBorderColor:'#000'

        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }]
        },
        legend: {
        	display: true,
        	position: 'right',
        	labels:{
        		fontColor: '#000',
        	}
        },
        title: {
        	display: true,
        	text: "Statistiques administratives",
        	fontSize: 25
        },
        layout:{
        	padding: {
            	left: 50,
            	right: 50,
            	bottom: 50,
            	top: 50
        	}
        },
        tooltips:{
        	enabled: true
        }
    }
});
</script>
<% } %>    
    
    
    
    
    
    
    
    
    
    
    
    