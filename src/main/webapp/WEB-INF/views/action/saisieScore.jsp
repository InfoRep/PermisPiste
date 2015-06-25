<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout>
	<jsp:attribute name="pageTitle">Score action</jsp:attribute>

    <jsp:attribute name="title">Entrer un score pour l'action <span style="color:#AAA">${action.libaction}</span></jsp:attribute>
    
    <jsp:body>
    	<h3>Informations : </h3>
    	<p>Pour l'apprenant <b>${apprenant.prenomapprenant} ${apprenant.nomapprenant}</b> concernant l'action <b>${action.numaction}</b> avec le libellé <b>${action.libaction}</b>.</p>
    	<p>Le score final se calcul avec la différence entre la valeur de fin et la valeur de début.</p>
    	<br />
   		<form method="post" class="form-horizontal" action="?">
   			<input type="hidden" value="${apprenant.numapprenant}" name="idAp" />
   			<input type="hidden" value="${action.numaction}" name="idA" />
   			
   			<div class="form-group">
   				<label for="valeurdebut" class="control-label col-md-2">Valeur début : </label>
   				<div class="col-md-5">
   					<input type="number" id="valeurdebut" name="valeurdebut" min="0" placeholder="Number" class="form-control" required />
   				</div>
   			</div>
   			
   			<div class="form-group">
 				<label for="valeurfin" class="control-label col-md-2">Valeur fin : </label>
   				<div class="col-md-5">
   					<input type="number" name="valeurfin" id="valeurfin" min="0" placeholder="Number" class="form-control" required />
   				</div>
   			</div>			
   			
   			<div class="form-group">
 				<label for="date" class="control-label col-md-2">Date de l'action : </label>
   				<div class="col-md-5">
   					<input type="text" name="date" class="date form-control" id="date" placeholder="YYYY/MM/DD" required />
   				</div>
   			</div>	
   			
   			<div class="form-group">
   				<div class="col-md-offset-3 col-md-9">
   					<button type="submit" class="btn btn-primary">S'inscrire</button>
   				</div>
   			</div>
   		</form>
    </jsp:body>
</t:layout>
