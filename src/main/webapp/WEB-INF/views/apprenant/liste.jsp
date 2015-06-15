<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ page session="false" %>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout>
	<jsp:attribute name="pageTitle">Liste apprenants</jsp:attribute>

    <jsp:attribute name="title">Liste des apprenants : (${fn:length(mesApprenants)})</jsp:attribute>
    
    <jsp:body>
   		<div class="row">
        	<div class="col-md-12">
		        <form method="post" action="supprimer"> 
			        <table class="table">
				  		<tr>
						 	<TH> 
						 		Numero 
					 		</TH>
							<TH> Nom de l'apprenant </TH>
						 	<TH> 
						 		Prénom de l'apprenant
					 		</TH>
						 	<th></th>
						 	<TH><button class="btn btn-danger"> Supprimer </button></TH>
				 		</tr>
					 	
					 	<c:forEach  items="${mesApprenants}"  var="item" >
					 	<tr class="text-center">
					     	<td class="id"><a href="modif?id=${item.numapprenant}">${item.numapprenant}</a></td>
					     	<td class="text-left libelle">${item.nomapprenant}</td>
					     	<td class="text-left libelle">${item.prenomapprenant}</td>
					       
						  	<td><a href="modif?id=${item.numapprenant}" class="btn btn-primary">Modifier</a></td>
						  	<td><input type="checkbox" name="id" value="${item.numapprenant}" /></td>
						  	
					  	</tr>
					 	</c:forEach>
					</table>
				</form>
			</div>
		</div>
    </jsp:body>
</t:layout>

