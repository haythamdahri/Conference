    

<!-- PAPER SUBMITED -->
<% if( session.getAttribute("paper_submited") != null && (boolean)session.getAttribute("paper_submited") ){
	session.removeAttribute("paper_submited");	
%>
   <script>
   
   Swal(
		   'Papier soumis avec succ�!',
		   'Votre these � �t� soumise avec succ�!',
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
		   'Inscription effectu�e!',
		   'Vous avez effectu� votre inscription avec succ�, merci pour votre int�r�t!',
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