<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<c:set var="now" value="<%=new java.util.Date()%>" />


<t:layout>
	<jsp:attribute name="pageTitle">Inscription</jsp:attribute>

    <jsp:attribute name="title">Inscription</jsp:attribute>
    
    <jsp:body>
    	<h3>Information de l'apprenant : </h3>
    	<p>L'inscription se fait à la date d'aujourd'hui : <fmt:formatDate pattern="yyyy-MM-dd" value="${now}" /></p>
    	<br />
   		<form method="post" class="form-horizontal" action="?">
   			<input type="hidden" value="1" name="valid" />
   			<input type="hidden" value="${idJeu}" name="j" />
   			
   			<div class="form-group">
   				<label for="nom" class="control-label col-md-2">Nom : </label>
   				<div class="col-md-5">
   					<input type="text" id="nom" name="nom" placeholder="Nom" class="form-control" required />
   				</div>
   			</div>
   			
   			<div class="form-group">
 				<label for="prenom" class="control-label col-md-2">Prenom : </label>
   				<div class="col-md-5">
   					<input type="text" name="prenom" id="prenom" placeholder="Prenom" class="form-control" required />
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
