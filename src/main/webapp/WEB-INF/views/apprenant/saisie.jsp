
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ page session="false" %>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout>
	<jsp:attribute name="pageTitle">Saisie d'un Apprenant</jsp:attribute>	

    <jsp:attribute name="title">
    	Formulaire <c:if test="${type == 'ajout'}">d'ajout</c:if><c:if test="${type == 'modif'}">de modification</c:if> d'un apprenant
    </jsp:attribute>
    
    <jsp:body>
	  	<form method="post" action="sauvegarder" class="form-horizontal" id="form">
	  		<input type="hidden" name="type" value="${type}"  id="type"/>
	  		
	  		<div class="form-group">
	  			<label for="id" class="control-label col-md-2">Numéro</label>
	  			<div class="col-md-1">
	  				<input class="form-control" type="number" name="id" value="${apprenant.numapprenant}" id="id" placeholder="num" step="1" min="1" required <c:if test="${type == 'modif'}">readonly</c:if>  />
	  			</div>
	  		</div>
	  		
	  		<div class="form-group">
	  			<label for="nom" class="control-label col-md-2">Nom de l'apprenant</label>
	  			<div class="col-md-5">
	  				<input type="text" class="form-control" placeholder="Nom du l'apprenant" name="nom" value="${apprenant.nomapprenant}" id="nom" required />
	  			</div>
	  		</div>
	  		
	  		<div class="form-group">
	  			<label for="prenom" class="control-label col-md-2">Prénom de l'apprenant</label>
	  			<div class="col-md-5">
	  				<input type="text" class="form-control" placeholder="Prenom du l'apprenant" name="prenom" value="${apprenant.prenomapprenant}" id="prenom" required />
	  			</div>
	  		</div>
	  		
	  		<div class="form-group text-right">
  				<c:if test="${type == 'ajout'}">
				    <input type="submit" class="btn btn-primary" value="Ajouter" />
  					<input type="reset" class="btn btn-warning" value="Reset" />
				</c:if>
		        <c:if test="${type == 'modif'}">
				   <input type="submit" class="btn btn-primary" value="Modifier" />
				</c:if>
				
				<a href="liste" class="btn btn-default">Retour</a>
	  		</div>
	  	</form>
    </jsp:body>
</t:layout>
