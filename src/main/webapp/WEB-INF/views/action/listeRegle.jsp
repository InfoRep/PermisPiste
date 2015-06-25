<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout>
	<jsp:attribute name="pageTitle">Liste des Actions</jsp:attribute>
	
	<jsp:attribute name="title">
		Règles pour l'action <span style="color:#AAA">${action.libaction}</span> : (${fn:length(regles)})
	</jsp:attribute>
	
	<jsp:body>
		<div class="row">
        	<div class="col-md-12">
        		<form method="get" role="search" action="liste">
			        <table class="table table-striped">
				  		<tr>
						 	<th>Numéro</th>
							<th>Libellé</th>
							<th>Score min</th>
				 		</tr>
					 	
					 	 <c:forEach  items="${action.regles}"  var="item" >
					 	 <tr>
				    	  	<td class="text-center"><b>${item.numregle}</b></td>
			      			<td class="text-center">${item.libregle}</td>
			      			<td class="text-center">${item.scoremin }</td>
						 </tr>
						 </c:forEach>	
					</table>
				</form>
        		<p><a href="liste" class="btn btn-default">Retour</a></p>
			</div>
		</div>
	</jsp:body>
</t:layout>