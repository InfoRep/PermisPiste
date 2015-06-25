<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout>
	<jsp:attribute name="pageTitle">Missions</jsp:attribute>
	
	<jsp:attribute name="title">Liste des actions triées pour <span style="color:#AAA">${apprenant.prenomapprenant} ${apprenant.nomapprenant}</span> : </jsp:attribute>
	
	<jsp:attribute name="javascripts">
		<script type="text/javascript">
			function cptMission(elems) {
				$.each(elems, function() {
					//mission
					var nbObj = cptObjectif($(this).find('.objectif')); //compter objectifs
					
					$($(this).find('.nbValid')[0]).text(nbObj.nbObjValid);
					$($(this).find('.nbMax')[0]).text(nbObj.nbObjMax);
				});	
			}
	
			function cptObjectif(elems) {
				var nbObjMax = 0;
				var nbObjValid = 0;
	
				$.each(elems, function() {
					//objectif
					var nbAction = cptAction($(this).find('.action')); //compter action
					
					
					$($(this).find('.nbValid')[0]).text(nbAction.nbActionValid);
					$($(this).find('.nbMax')[0]).text(nbAction.nbActionMax);
					nbObjMax += 1;
					nbObjValid += (nbAction.nbActionMax == nbAction.nbActionValid ? 1 : 0);
				});
				
				return {'nbObjMax' : nbObjMax, 'nbObjValid' : nbObjValid};
			}
	
			function cptAction(elems) {
				var nbActionMax = 0;
				var nbActionValid = 0;
				$.each(elems, function() {
					//action
					var val = $($(this).find('.actionValid')[0]).val()*1;
					nbActionMax += 1;
					nbActionValid += val;
				});
				
				return {'nbActionMax' : nbActionMax, 'nbActionValid' : nbActionValid};
			}
			
			$(document).ready(function() {
				var missions = $(".mission");
				if (missions.length > 0)
				{
					cptMission(missions); //compter mission
				} else {
					var objs = $(".objectif");
					if (objs.length > 0)
					{
						cptObjectif(objs);
					}
					
				}
				
				$('.panel-title a').click(function() { $(location).prop('href', $(this).attr('href')); });
			});
		</script>
	</jsp:attribute>
	
	<jsp:body>
		<c:set var="size" value="${fn:length(objs)}"></c:set>
		<c:set var="cpt" value="1"></c:set>
		<c:if test="${size > 0}">
			<c:choose>
				<c:when test="${not empty idO}">
					<a class="btn btn-default" href="?idA=${apprenant.numapprenant}&idC=${idC}&idJ=${idJ}&idM=${idM}">Retour par mission</a>
				</c:when>
				<c:when test="${not empty idM}">
					<a class="btn btn-default" href="?idA=${apprenant.numapprenant}&idC=${idC}&idJ=${idJ}">Retour par jeu</a>
				</c:when>
			</c:choose>
			
			<c:if test="${not empty idO or not empty idM or not empty idJ or not empty idC}">
				<a class="btn btn-default" href="?idA=${apprenant.numapprenant}">Retour à la racine</a>
			</c:if>
			<p class="text-danger">Le score obtenu pour une action doit avoir été enregistré après l'inscription au jeu pour être pris en compte.</p>
			<p>Cliquez sur les icônes pour n'afficher que les jeux, missions ou objectifs</p>
			
			<c:if test="${empty idO && empty idM }">
				<p class="text-success">Cliquez sur un jeu pour voir les missions</p>
			</c:if>
			
			<c:set var="i"></c:set>
			<c:set var="m"></c:set>
			<c:set var="o"></c:set>
			<c:set var="cpt" value="1"></c:set>
			
			<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
			<c:forEach  items="${objs}"  var="item" >
				<c:set var="action" value="${item[0]}"></c:set>
				<c:set var="objectif" value="${item[1]}"></c:set>
				<c:set var="mission" value="${item[2]}"></c:set>
				<c:set var="inscrit" value="${item[3]}"></c:set>
				<c:set var="jeu" value="${ inscrit.jeu }"></c:set>
				
				<c:set var="actVal" value="0"></c:set>
				<c:set var="actDate" value=""></c:set>
				<c:forEach items="${inscrit.apprenant.obtients}" var="obt">
					<c:if test="${obt.action == action && obt.calendrier.datejour >= inscrit.calendrier.datejour && obt.valeurfin-obt.valeurdebut > actVal}">
						<c:set var="actVal" value="${obt.valeurfin-obt.valeurdebut}"></c:set>					
						<c:set var="actDate" value="${obt.calendrier}"></c:set>
					</c:if>					
				</c:forEach>
						
				<c:if test="${i != inscrit && not empty i && empty idO && empty idM}">
					<c:set var="m" value="0"></c:set>
					<c:set var="o" value="0"></c:set>
				</c:if>		
						
				<c:if test="${o != objectif && not empty o}">
								</table>
							</div>
						</div>
					</div>
				</c:if>				
								
				<c:if test="${m != mission && not empty m && empty idO}">
								</div>
							</div>
						</div>
					</div>
				</c:if>				
								
				<c:if test="${i != inscrit}">
					<c:if test="${not empty idM or not empty idO}">
						<h3>${ jeu.libellejeu } <span class="text-warning">inscrit le ${ inscrit.calendrier.datejour }</span></h3>
					</c:if>
					
					<c:if test="${empty idM && empty idO}">
						<c:if test="${not empty i}">
									</div>
								</div>
							</div>
						</div>	
						<br />
						</c:if>						
						<div class="panel panel-primary inscrit">
							<div class="panel-heading" role="tab">	
								<div class="panel-title row" role="button" data-parent="#accordion" data-toggle="collapse" href="#${ cpt }-${ jeu.numjeu }" aria-expanded="false" aria-controls="jeu">
									<div class="col-md-2">
										<span class="glyphicon glyphicon-menu-down"></span>
										&nbsp;&nbsp;&nbsp;
										<a href="?idA=${apprenant.numapprenant}&idC=${inscrit.calendrier.datejour}&idJ=${jeu.numjeu}">
											<img src="resources/images/game.png" width="30" height="30" />
										</a>
									</div>
									<div class="col-md-8">
										${ jeu.libellejeu } <span class="text-warning">inscrit le ${ inscrit.calendrier.datejour }</span>
									</div>
									<div class="col-md-2 text-right">
										<i class="glyphicon glyphicon-triangle-bottom"></i>
									</div>
								</div>
							</div>
							<c:if test="${not empty idJ}"><c:set value="in" var="collaJ" /></c:if>
							<div id="${cpt}-${ jeu.numjeu }" class="panel-collapse collapse ${collaJ}" role="tabpanel">
								<div class="panel-body">
									<p class="text-success">Cliquez sur une mission pour voir les objectifs</p>
									<div class="panel-group" id="accordion-${cpt}-${ jeu.numjeu }" role="tablist" aria-multiselectable="true">
					</c:if>
					<c:set var="i" value="${inscrit}"></c:set>
				</c:if>
				
				<c:if test="${m != mission}">
					<c:set var="m" value="${mission}"></c:set>
					<c:if test="${not empty idO}">
						<h3 class="text-success">${mission.libmission}</h3>
					</c:if>
					<c:if test="${empty idO}">
						<div class="panel panel-success mission">
							<div class="panel-heading" role="tab">
								<div class="panel-title row" role="button" data-parent="#accordion-${cpt}-${jeu.numjeu}" data-toggle="collapse" href="#${cpt}-${jeu.numjeu}_${mission.nummission}" aria-expanded="false" aria-controls="jeu">	
									<div class="col-md-2">
										<span class="glyphicon glyphicon-menu-down"></span>
										&nbsp;&nbsp;&nbsp;
										<a href="?idA=${apprenant.numapprenant}&idC=${inscrit.calendrier.datejour}&idJ=${jeu.numjeu}&idM=${mission.nummission}">
											<img src="resources/images/note.png" width="20" height="20" />
										</a>
									</div>
									<div class="col-md-5">
										${mission.libmission}</a>
									</div>
									<div class="col-md-3 text-right">
										<span class="nbValid"></span> / <span class="nbMax"></span>
									</div>
									<div class="col-md-2 text-right">
										<i class="glyphicon glyphicon-triangle-bottom"></i>
									</div>
								</div>
							</div>
							<c:if test="${not empty idM}"><c:set value="in" var="collaM" /></c:if>
							<div id="${cpt}-${jeu.numjeu}_${mission.nummission}" class="panel-collapse collapse ${collaM}" role="tabpanel">
								<div class="panel-body">
									<p class="text-success">Cliquez sur un objectif pour le détail avec les actions</p>
									<div style="font-size:24px" class="panel-group" id="accordion-${cpt}-${jeu.numjeu}_${mission.nummission}" role="tablist" aria-multiselectable="true">
					</c:if>			
				</c:if>
				
				<c:if test="${o != objectif}">
					<c:set var="o" value="${objectif}"></c:set>
					<div class="panel panel-warning objectif">
						<div class="panel-heading" role="tab">	
							<div class="panel-title row" role="button" data-parent="#accordion-${cpt}-${jeu.numjeu}_${mission.nummission}" data-toggle="collapse" href="#${cpt}-${jeu.numjeu}_${mission.nummission}_${objectif.numobjectif}" aria-expanded="false" aria-controls="jeu">
								<div class="col-md-2">
									<span class="glyphicon glyphicon-menu-down"></span>
									&nbsp;&nbsp;&nbsp;
									<a href="?idA=${apprenant.numapprenant}&idC=${inscrit.calendrier.datejour}&idJ=${jeu.numjeu}&idM=${mission.nummission}&idO=${objectif.numobjectif}">
										<img src="resources/images/objectif.png" width="30" height="30" />
									</a>
								</div>
								<div class="col-md-5">
									${objectif.libobectif}
								</div>
								<div class="col-md-3 text-right">
									<span class="nbValid"></span> / <span class="nbMax"></span>
								</div>
								<div class="col-md-2 text-right">
									<i class="glyphicon glyphicon-triangle-bottom"></i>
								</div>
							</div>
						</div>
						<c:if test="${not empty idO}"><c:set value="in" var="collaO" /></c:if>
						<div id="${cpt}-${jeu.numjeu}_${mission.nummission}_${objectif.numobjectif}" class="panel-collapse collapse ${collaO}" role="tabpanel">
							<div class="panel-body" style="font-size:24px">
								<table class="table table-striped">
				</c:if>
				
				<tr class="action">
					<td>
						<a href="actions/regles?idA=${action.numaction}" style="color:black; text-decoration:none">${action.libaction}</a>
					</td>
					<td>
						<c:if test="${not empty actDate}">
						Score : <span style="color:#AAA">${actVal}</span> le <span style="color:#AAA">${actDate.datejour}</span>
						</c:if>
					</td>
					<td width="100" class="text-right">
						<!-- Check Action parent  -->
						<c:set var="okActParent" value="false" />
						<c:set var="obtParent" value="" />
						<c:choose>
							<c:when test="${not empty action.action}">
								<c:forEach  items="${action.action.obtients}"  var="obtP" >
									<c:if test="${obtP.apprenant == i.apprenant && obtP.calendrier.datejour >= i.calendrier.datejour && 
									(empty obtParent || (not empty obtParent && obtParent.valeurfin-obtParent.valeurdebut < obtP.valeurfin-obtP.valeurdebut))}">
										<c:set var="obtParent" value="${obtP}" />
									</c:if>
								</c:forEach>
								<c:if test="${not empty obtParent}">
									<c:set value="true" var="okActParent" />
									<c:forEach items="${action.action.regles}" var="regP">
										<c:if test="${regP.scoremin > obtParent.valeurfin-obtParent.valeurdebut}">
											<c:set value="false" var="okActParent" />
										</c:if>
									</c:forEach>
								</c:if>
							</c:when>
							<c:otherwise>
								<c:set var="okActParent" value="true" />
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${not empty actDate && okActParent == true}">
								<c:set var="okAction" value="true" />
								<c:forEach items="${action.regles}" var="regP">
									<c:if test="${regP.scoremin > actVal}">
										<c:set value="false" var="okAction" />
									</c:if>
								</c:forEach>							
							
								<c:choose>
									<c:when test="${okAction == true}">
										<div class="btn btn-success" style="cursor:default">Validé</div>
										<input type="hidden" class="actionValid" value="1" />
									</c:when>
									<c:otherwise>
										<div class="btn btn-danger" style="cursor:default">Echec</div>
										<input type="hidden" class="actionValid" value="0" />
									</c:otherwise>
								</c:choose>										     				
							</c:when>
							<c:when test="${okActParent != true}">
								<input type="hidden" class="actionValid" value="0" />
								<div class="btn btn-danger" style="cursor:default">"${action.action.libaction}" requis</div>
							</c:when>
							<c:otherwise>
								<input type="hidden" class="actionValid" value="0" />
								<a href="actions/enregScore?idA=${action.numaction}&idAp=${i.apprenant.numapprenant}" class="btn btn-primary">Entrer un score</a>
							</c:otherwise>
						</c:choose>	
					</td>
				</tr>
				
				<c:set var="cpt" value="${cpt+1}"></c:set>
			</c:forEach>
			</table></div></div></div>
			<c:if test="${empty idO}">
				</div></div></div></div>
			</c:if>
			<c:if test="${empty idM && empty idO}">
				</div></div></div></div>
			</c:if>
			</div>
		</c:if>
		<c:if test="${size == 0}">
			<div class="text-center">
				<h3 class="text-danger">Cet aprennant n'est inscrit à aucun jeu.</h3>
				<a href="jeux/liste">Cliquez ici pour les inscriptions</a>
			</div>
		</c:if>
	</jsp:body>
</t:layout>