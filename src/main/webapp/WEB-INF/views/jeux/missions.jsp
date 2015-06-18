<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout>
	<jsp:attribute name="pageTitle">Missions</jsp:attribute>
	
	<jsp:attribute name="title">Liste des missions par jeux pour "${apprenant.prenomapprenant} ${apprenant.nomapprenant}"" : </jsp:attribute>
	
	<jsp:body>
		<c:set var="sizeJeux" value="${fn:length(objs)}"></c:set>
		<c:set var="cpt" value="1"></c:set>
		<c:if test="${sizeJeux > 0}">
			<div class="form-group text-right">
				 <input type="submit" class="btn btn-success" value="Mettre à jour" />
				 <a href="liste" class="btn btn-default">Retour</a>
			</div>
			<br />
			<p class="text-success">Cliquez sur un jeu pour voir les missions</p>
			<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
				<c:forEach  items="${objs}"  var="item" >
				<div class="panel panel-primary">
					<div class="panel-heading" role="tab">	
						<div class="panel-title row" role="button" data-parent="#accordion" data-toggle="collapse" href="#${cpt}-${item.jeu.numjeu}" aria-expanded="false" aria-controls="jeu">
							<div class="col-md-1">
								<span class="glyphicon glyphicon-menu-down"></span>
								&nbsp;&nbsp;&nbsp;<img src="resources/images/game.png" width="30" height="30" />
							</div>
							<div class="col-md-9">
								${item.jeu.libellejeu} <span class="text-warning">inscrit le ${ item.calendrier.datejour }</span>
							</div>
							<div class="col-md-2 text-right">
								<i class="glyphicon glyphicon-triangle-bottom"></i>
							</div>
						</div>
					</div>
					
					<div id="${cpt}-${item.jeu.numjeu}" class="panel-collapse collapse" role="tabpanel">
						<div class="panel-body">
							<p class="text-success">Cliquez sur une mission pour voir les objectifs</p>
							<div class="panel-group" id="accordion-${cpt}-${item.jeu.numjeu}" role="tablist" aria-multiselectable="true">
								<c:forEach  items="${item.jeu.missions}"  var="mission" >	
								<div class="panel panel-success">
									<div class="panel-heading" role="tab">	
										<div class="panel-title row" role="button" data-parent="#accordion-${cpt}-${item.jeu.numjeu}" data-toggle="collapse" href="#${cpt}-${item.jeu.numjeu}_${mission.nummission}" aria-expanded="false" aria-controls="jeu">
											<div class="col-md-1">
												<span class="glyphicon glyphicon-menu-down"></span>
												&nbsp;&nbsp;&nbsp;<img src="resources/images/note.png" width="20" height="20" />
											</div>
											<div class="col-md-6">
												${mission.libmission}
											</div>
											<div class="col-md-3 text-right">
												0 / 100
											</div>
											<div class="col-md-2 text-right">
												<i class="glyphicon glyphicon-triangle-bottom"></i>
											</div>
										</div>
									</div>
									
									<div id="${cpt}-${item.jeu.numjeu}_${mission.nummission}" class="panel-collapse collapse" role="tabpanel">
										<div class="panel-body">
											<p class="text-success">Cliquez sur un objectif pour le détail avec les actions</p>
											<div style="font-size:24px" class="panel-group" id="accordion-${cpt}-${item.jeu.numjeu}_${mission.nummission}" role="tablist" aria-multiselectable="true">
												<c:forEach  items="${mission.objectifs}"  var="obj" >
												<div class="panel panel-warning">
													<div class="panel-heading" role="tab">	
														<div class="panel-title row" role="button" data-parent="#accordion-${cpt}-${item.jeu.numjeu}_${mission.nummission}" data-toggle="collapse" href="#${cpt}-${item.jeu.numjeu}_${mission.nummission}_${obj.numobjectif}" aria-expanded="false" aria-controls="jeu">
															<div class="col-md-1">
																<span class="glyphicon glyphicon-menu-down"></span>
																&nbsp;&nbsp;&nbsp;<img src="resources/images/objectif.png" width="30" height="30" />
															</div>
															<div class="col-md-6">
																${obj.libobectif}
															</div>
															<div class="col-md-3 text-right">
																0 / 100
															</div>
															<div class="col-md-2 text-right">
																<i class="glyphicon glyphicon-triangle-bottom"></i>
															</div>
														</div>
													</div>
													
													<div id="${cpt}-${item.jeu.numjeu}_${mission.nummission}_${obj.numobjectif}" class="panel-collapse collapse" role="tabpanel">
														<div class="panel-body" style="font-size:24px">
															<table class="table table-striped">
																<c:forEach  items="${obj.actions}"  var="act" >
																<tr>
																	<td>
																		${act.libaction}
																	</td>
																	<td width="100" class="text-right">
																		<input type="checkbox" name="checkObj" class="form-control" />
																	</td>
																</tr>
																</c:forEach>
															</table>
														</div>
													</div>
												</div>
												</c:forEach>
											</div>											
										</div>
									</div>
								</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
				<br />
				<c:set var="cpt" value="${cpt+1}"></c:set>
				</c:forEach>	
			</div>
			<br />
			<div class="form-group text-right">
				 <input type="submit" class="btn btn-success" value="Mettre à jour" />
				 <a href="liste" class="btn btn-default">Retour</a>
			</div>
		</c:if>
		<c:if test="${sizeJeux == 0}">
			<div class="text-center">
				<h3 class="text-danger">Cet aprennant n'est inscrit à aucun jeu.</h3>
				<a href="jeux/liste">Cliquez ici pour les inscriptions</a>
			</div>
		</c:if>
	</jsp:body>
</t:layout>