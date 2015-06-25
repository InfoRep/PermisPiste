<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout>
	<jsp:attribute name="pageTitle">Accueil</jsp:attribute>

    <jsp:attribute name="title">Accueil</jsp:attribute>
    
    <jsp:body>
   		<h3 style="margin-top:0">Bienvenue dans l'application Permis Piste !</h3>
   		<div class="row">
   			<div class="col-md-1"></div>
   			<div class="col-md-7">
	   			<h4>Nous sommes le ${serverTime}</h4>
   				<br/>
		   		<p>Cette application vous permettra de suivre pas à pas votre apprentissage.</p>
		   		<h5>En vous souhaitant une agréable visite !</h5>
		   		<br />
		   		
		   		<h3>Pour commencer, vous pouvez vous : </h3>
		   		<ul>
		   			<li>1) <a href="apprenant/saisie">Enregistrer en tant qu'apprenant</a></li>
		   			<li>2) <a href="jeux/liste">Inscrire à un jeu depuis la liste</a></li>
					<li>3) <a href="missions">Accéder à la liste des missions pour valider des actions</a></li>
		   		</ul>
		   		<h4 class="text-success">D'autres informations comme la liste des apprenants ou des actions sont disponibles en haut à droite.</h4>
			</div>
			<div class="col-md-4">
	   			<img src="resources/images/polytech.png" width="300" alt="" />
			</div>
   		</div>
    </jsp:body>
</t:layout>
