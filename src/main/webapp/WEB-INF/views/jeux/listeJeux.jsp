<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout>
	<jsp:attribute name="pageTitle">Liste des jeux</jsp:attribute>
	
	<jsp:attribute name="title">Liste de jeux</jsp:attribute>
	
	<jsp:body>
		<div class="row">
        	<div class="col-md-12">
		        <table class="table table-striped">
			  		<tr>
					 	<th>Numéro Jeu</th>
						<th>Libellé du jeu</th>
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
			</div>
		</div>
	</jsp:body>
</t:layout>