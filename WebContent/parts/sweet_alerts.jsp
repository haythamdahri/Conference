    

<!-- PAPER SUBMITED -->
<% if( session.getAttribute("paper_submited") != null && (boolean)session.getAttribute("paper_submited") ){
	session.removeAttribute("paper_submited");	
%>
   <script>
   
   Swal(
		   'Papier soumis avec succé!',
		   'Votre these à été soumise avec succé!',
		   'success'
		 )
   
   </script>
 <% }else if( session.getAttribute("paper_submited") != null && (boolean)session.getAttribute("paper_submited") ){
	session.removeAttribute("paper_submited");	
%>
 <script>
   
   Swal(
		   'Une erreur est survenue!',
		   'Veuillez ressayer!',
		   'error'
		 )
   
   </script>
 <% } %>
 
 <!-- REGISTRATION DONE -->
<% if( session.getAttribute("registration_done") != null && (boolean)session.getAttribute("registration_done") ){ 
	session.removeAttribute("registration_done");
%>
   <script>
   
   Swal(
		   'Inscription effectuée!',
		   'Vous avez effectué votre inscription avec succé, merci pour votre intérêt!',
		   'success'
		 )
   
   </script>
 <% }else if( session.getAttribute("registration_done") != null && (boolean)session.getAttribute("registration_done") ){ 
	 session.removeAttribute("registration_done");
 %>
  <script>
   
   Swal(
		   'Une erreur est survenue!',
		   'Veuillez ressayer!',
		   'error'
		 )
   
   </script>
 <% } %>