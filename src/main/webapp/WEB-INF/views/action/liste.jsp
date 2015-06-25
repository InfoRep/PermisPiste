<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout>
	<jsp:attribute name="pageTitle">Liste des Actions</jsp:attribute>
	
	<jsp:attribute name="title">
		Liste des actions : (${fn:length(actions)})
	</jsp:attribute>
	
	<jsp:body>
		<div class="row">
        	<div class="col-md-12">
        		<form method="get" role="search" action="liste">
			        <table class="table table-striped">
				  		<tr>
						 	<th>Numéro</th>
							<th>Libellé</th>
							<th>Action parent</th>
							<th>Libellé parent</th>
							<th></th>
				 		</tr>
					 	
					 	 <c:forEach  items="${actions}"  var="item" >
					 	 <tr>
				    	  	<td class="text-center"><b>${item.numaction}</b></td>
			      			<td class="text-center">${item.libaction}</td>
			      			<td class="text-center">${item.action.numaction}</td>
			      			<td class="text-center">${item.action.libaction}</td>
			      			<td><a href="regles?idA=${item.numaction}" class="btn btn-primary">Règles (${fn:length(item.regles)})</a></td>
						 </tr>
						 </c:forEach>	
					</table>
				</form>
			</div>
		</div>
	</jsp:body>
</t:layout>