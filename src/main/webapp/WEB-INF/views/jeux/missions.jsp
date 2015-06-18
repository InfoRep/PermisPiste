<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout>
	<jsp:attribute name="pageTitle">Missions</jsp:attribute>
	
	<jsp:attribute name="title">Liste des missions par jeux</jsp:attribute>
	
	<jsp:body>
		<h2>Pour l'apprenant ${apprenant.prenomapprenant} ${apprenant.nomapprenant}  : </h2>
		<br />
		<p class="text-success">Cliquez sur un jeu pour voir les missions</p>
		<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
			<c:forEach  items="${objs}"  var="item" >
			<div class="panel panel-primary">
				<div class="panel-heading" role="tab">	
					<div class="panel-title row" role="button" data-parent="#accordion" data-toggle="collapse" href="#${item.jeu.numjeu}" aria-expanded="false" aria-controls="jeu">
						<div class="col-md-1"><span class="glyphicon glyphicon-menu-down"></span></div>
						<div class="col-md-9">
							${item.jeu.libellejeu}
						</div>
						<div class="col-md-2 text-right">
							<i class="glyphicon glyphicon-triangle-bottom"></i>
						</div>
					</div>
				</div>
				
				<div id="${item.jeu.numjeu}" class="panel-collapse collapse" role="tabpanel">
					<div class="panel-body" style="font-size:24px">
						<table class="table table-striped">
						<c:forEach  items="${item.jeu.missions}"  var="mission" >
							<tr>
								<td>${mission.libmission}</td>
							</tr>
						</c:forEach>
						</table>
					</div>
				</div>
			</div>
			<br />
			</c:forEach>	
		</div>
	</jsp:body>
</t:layout>