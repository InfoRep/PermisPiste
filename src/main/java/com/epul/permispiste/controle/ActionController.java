package com.epul.permispiste.controle;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import metier.Action;
import metier.Apprenant;
import metier.Calendrier;
import metier.Obtient;
import metier.ObtientId;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.epul.permispiste.dao.ActionHClient;
import com.epul.permispiste.dao.ApprenantHClient;
import com.epul.permispiste.dao.CalendrierHClient;
import com.epul.permispiste.dao.ObtientHClient;


/**
 * Handles requests for the application home page.
 */
@Controller
public class ActionController extends MultiActionController {

	private static final Logger logger = LoggerFactory
			.getLogger(ActionController.class);

	/**
	 * Affichage de toutes les actions
	 */
	@RequestMapping(value = "/actions/liste")
	public ModelAndView liste(HttpServletRequest request,
			HttpServletResponse response, 
			RedirectAttributes redirectAttrs) 
					throws Exception {
		String destinationPage;	
		try {
			//Attribute from redirection
			for (Entry<String, Object> e : redirectAttrs.asMap().entrySet())
				request.setAttribute(e.getKey(), e.getValue()); //add attributes to the page
			
			//Liste apprenants
			List<Action> actions = new ActionHClient().findAll();
			request.setAttribute("actions", actions);
	
			destinationPage = "/action/liste";
			
		} catch (Exception e) {
			destinationPage = "/Erreur";	
			request.setAttribute("MesErreurs", e.getMessage());
		}
		
		return new ModelAndView(destinationPage);
	}	
	
	/**
	 * Affichage des regles pour une action
	 */
	@RequestMapping(value = "/actions/regles")
	public ModelAndView listeRegles(HttpServletRequest request,
			HttpServletResponse response, 
			RedirectAttributes redirectAttrs) 
					throws Exception {
		String destinationPage;	
		try {			
			String idA = request.getParameter("idA");
			if (idA == null)
			{
				redirectAttrs.addFlashAttribute("messWarning", "Cliquez sur le boutons \"Règles\" pour voir les règles d'une action.");
				
				return new ModelAndView("redirect:/actions/liste");
			} else {
				Action action = new ActionHClient().find(Integer.valueOf(idA));
				request.setAttribute("action", action);
				
				destinationPage = "/action/listeRegle";
			}						
		} catch (Exception e) {
			destinationPage = "/Erreur";	
			request.setAttribute("MesErreurs", e.getMessage());
		}
		
		return new ModelAndView(destinationPage);		
	}
	
	/**
	 * Enregistrer une action pour un apprenant (Relation Obtient)
	 */
	@RequestMapping(value = "/actions/enregScore")
	public ModelAndView enregObtient(HttpServletRequest request,
			HttpServletResponse response,
			RedirectAttributes redirectAttrs) 
					throws Exception {
		String destinationPage;	
		try {			
			int idA = Integer.valueOf(request.getParameter("idA"));
			int idAp = Integer.valueOf(request.getParameter("idAp"));
			Action action = new ActionHClient().find(idA);
			if (action != null)
			{
				Apprenant apprenant = new ApprenantHClient().getUneLigne(idAp);
				request.setAttribute("action", action);
				request.setAttribute("apprenant", apprenant);
				
				if (request.getParameter("date") != null && request.getParameter("valeurfin") != null && request.getParameter("valeurdebut") != null)
				{ //Enregistrement 
					//calendrier
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
					Date d = sdf.parse(request.getParameter("date"));
					Calendrier c = new CalendrierHClient().find(d);
					if (c == null)
						c = new Calendrier(d);
					
					//valeurs
					int valeurfin = Integer.valueOf(request.getParameter("valeurfin"));
					int valeurdebut = Integer.valueOf(request.getParameter("valeurdebut"));
										
					Obtient o = new Obtient(new ObtientId(apprenant.getNumapprenant(), c.getDatejour(), action.getNumaction()), action, apprenant, c);
					o.setValeurdebut(valeurdebut);
					o.setValeurfin(valeurfin);
					new ObtientHClient().insert(o);
					
					redirectAttrs.addFlashAttribute("messSuccess",
							"Le score de l'action a été enregistré avec succès.");
					return new ModelAndView("redirect:/actions/liste");	
				} 

				destinationPage = "action/saisieScore";
			} else {
				request.setAttribute("messError", "L'action est introuvable dans la base de donnée.");
				destinationPage = "/Erreur";
			}						
		} catch (Exception e) {
			destinationPage = "/Erreur";	
			request.setAttribute("MesErreurs", e.getMessage());
		}
		
		return new ModelAndView(destinationPage);	
	}
}

	