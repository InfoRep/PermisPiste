<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout>
	<jsp:attribute name="pageTitle">Liste des jeux</jsp:attribute>
	
	<jsp:attribute name="title">
		Liste de jeux<c:if test="${not empty sJeu}"> avec <span style="color:#AAA">${sJeu}</span></c:if> : (${fn:length(mesJeux)})
	</jsp:attribute>
	
	<jsp:body>
		<div class="row">
        	<div class="col-md-12">
        		<form method="get" role="search" action="liste">
			        <table class="table table-striped">
				  		<tr>
						 	<th>Numéro Jeu</th>
							<th>
								Libellé du jeu
								<div class="form-group">
						        	<div class="input-group">
							        	<span class="input-group-addon" id="basic-addon1">
							        		<button style="padding:0px;" class="btn-link glyphicon glyphicon-search"></button>
							        	</span>
							         	<input type="text" class="form-control" placeholder="Rechercher" name="sJeu" />
							         </div>
						        </div>
							</th>
							<th>Inscription</th>
				 		</tr>
					 	
					 	 <c:forEach  items="${mesJeux}"  var="item" >
					 	 <tr>
				    	  	<td class="text-center"><b>${item.numjeu}</b></td>
			      			<td class="text-center">${item.libellejeu}</td>
			      			<td class="text-center"><a href="inscription?j=${item.numjeu}" class="btn btn-primary">S'inscrire</a></td>
						 </tr>
						 </c:forEach>	
					</table>
				</form>
			</div>
		</div>
	</jsp:body>
</t:layout>