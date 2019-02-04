<%@page import="com.conference.entities.Papier"%>
<% Papier papier = (Papier)request.getAttribute("papier"); %>

<div class="modal fade" tabindex="-1" role="dialog" id="modal_description_view<%= papier.getId() %>" aria-labelledby="myLargeModalLabel">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title text-center" id="paper_title"><%= papier.getTitre() %></h4>
      </div>
      <div class="modal-body">
	        <p id="paper_description"><%= papier.getDescription() %></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Fermer</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div>