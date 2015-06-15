<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout>
	<jsp:attribute name="pageTitle">Inscription</jsp:attribute>

    <jsp:attribute name="title">Inscription</jsp:attribute>
    
    <jsp:body>
    	<h3>Information de l'apprenant : </h3>
    	<br />
   		<form method="post" class="form-horizontal">
   			<input type="hidden" value="1" name="valid" />
   			
   			<div class="form-group">
   				<label for="nom" class="control-label col-md-2">Nom : </label>
   				<div class="col-md-5">
   					<input type="text" id="nom" name="nom" placeholder="Nom" class="form-control" />
   				</div>
   			</div>
   			
   			<div class="form-group">
 				<label for="prenom" class="control-label col-md-2">Prenom : </label>
   				<div class="col-md-5">
   					<input type="text" name="prenom" id="prenom" placeholder="Prenom" class="form-control" />
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
