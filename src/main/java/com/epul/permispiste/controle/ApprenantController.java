package com.epul.permispiste.controle;


import java.util.ArrayList;
import java.util.List;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import metier.Apprenant;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.epul.permispiste.dao.ApprenantHClient;


/**
 * Handles requests for the application home page.
 */
@Controller
public class ApprenantController extends MultiActionController {

	private static final Logger logger = LoggerFactory
			.getLogger(ApprenantController.class);

	/**
	 * Affichage de tous les apprenants
	 */
	@RequestMapping(value = "/apprenant/liste")
	public ModelAndView afficherLesApprenants(HttpServletRequest request,
			HttpServletResponse response, 
			RedirectAttributes redirectAttrs) 
					throws Exception {
		String destinationPage;	
		ApprenantHClient unGestClient = new ApprenantHClient();		
		try {
			//Attribute from redirection
			for (Entry<String, Object> e : redirectAttrs.asMap().entrySet())
				request.setAttribute(e.getKey(), e.getValue()); //add attributes to the page
			
			//Liste apprenants
			List<Apprenant> mesApprenants = unGestClient.getTouteslesLignes(request.getParameter("s"));
			request.setAttribute("mesApprenants",mesApprenants);
	
			destinationPage = "/apprenant/liste";
			
		} catch (Exception e) {
			destinationPage = "/Erreur";	
			request.setAttribute("MesErreurs", e.getMessage());
		}
		
		return new ModelAndView(destinationPage);
	}
	
	/**
	 * Saisie d'un apprenant
	 */
	@RequestMapping(value = "/apprenant/saisie")
	public ModelAndView ajoutApprenant(HttpServletRequest request,
		HttpServletResponse response) throws Exception {
		String destinationPage = "";	
		ApprenantHClient unGestClient = new ApprenantHClient();
		try {
			request.setAttribute("type", "ajout");
			
			Apprenant app = new Apprenant();
			request.setAttribute("apprenant", app);		
			
			destinationPage = "/apprenant/saisie";

		} catch (Exception e) {
			destinationPage = "/Erreur";
			request.setAttribute("MesErreurs", e.getMessage());
		}
			
		return new ModelAndView(destinationPage);
	}
	
	/**
	 * Modifier un apprenant
	 */
	@RequestMapping(value = "/apprenant/modif")
	public ModelAndView modifApprenant(HttpServletRequest request,
		HttpServletResponse response) throws Exception {
		String destinationPage = "";	
		ApprenantHClient unGestClient = new ApprenantHClient();
		try {
			request.setAttribute("type", "modif");
			
			int id = Integer.valueOf(request.getParameter("id"));
		
			Apprenant apprenant = new ApprenantHClient().getUneLigne(id);
			
			request.setAttribute("apprenant", apprenant);	

			destinationPage = "/apprenant/saisie";

		} catch (Exception e) {
			destinationPage = "/Erreur";
			request.setAttribute("MesErreurs", e.getMessage());
		}
				
		return new ModelAndView(destinationPage);
	}
	
	/**
	 * Sauvegarder un apprenant
	 */
	@RequestMapping(value = "/apprenant/sauvegarder")
	public ModelAndView saveApprenant(HttpServletRequest request,
		HttpServletResponse response, 
		RedirectAttributes redirectAttrs) 
				throws Exception {
		String destinationPage = "/Erreur";	
		ApprenantHClient unGestClient = new ApprenantHClient();
		
		try {
			
			int id = Integer.valueOf(request.getParameter("id"));
			Apprenant app = null;
			if (request.getParameter("type").equals("ajout"))
			{ //ajoute d'un apprenant
				app = new Apprenant();
			}				
			else 
			{ // modification on récupère l'apprenant courant
				app = unGestClient.getUneLigne(id);
			}
			
			app.setNumapprenant(id);
			app.setNomapprenant(request.getParameter("nom"));
			app.setPrenomapprenant(request.getParameter("prenom"));
			
			// sauvegarde du jouet
			if (request.getParameter("type").equals("modif")) {
				unGestClient.modifier(app);
				redirectAttrs.addFlashAttribute("messSuccess",
						"L'apprenant " + app.getNumapprenant()
								+ " a bien été modifié!");
			} else {
				unGestClient.ajouter(app);
				redirectAttrs.addFlashAttribute("messSuccess",
						"L'apprenant " + app.getNumapprenant()
								+ " a bien été ajouté!");
			}
			
			return new ModelAndView ("redirect:liste");

		} catch (Exception e) {
			destinationPage = "/Erreur";
			request.setAttribute("MesErreurs", e.getMessage());
		}
			
		return new ModelAndView(destinationPage);
	}
	
	/**
	 * supprimer un apprenant
	 */
	@RequestMapping(value = "/apprenant/supprimer")
	public ModelAndView effacerApprenant(HttpServletRequest request,
		HttpServletResponse response, 
		RedirectAttributes redirectAttrs) 
				throws Exception {
		String destinationPage = "";	

		ApprenantHClient unGestClient = new ApprenantHClient();
		
		try {
			
			String[] idsstr = request.getParameterValues("id");
			if (idsstr != null || (idsstr != null && idsstr.length > 0))
			{
				List<Integer> ids = new ArrayList<Integer>();
				for (String id : idsstr)
				{
					ids.add(Integer.valueOf(id));
				}
				
				List<Apprenant> apps = unGestClient.getLignes(ids);					
				for (Apprenant a : apps)
				{
					unGestClient.effacer(a);
				}
					
				redirectAttrs.addFlashAttribute("messSuccess", "Les apprenants ont bien été supprimés.");		
			}
			else 
			{
				redirectAttrs.addFlashAttribute("messWarning", "Aucun apprenant n'a été sélectionné.");
			}
			
			return new ModelAndView ("redirect:liste");
			
		} catch (Exception e) {
			destinationPage = "/Erreur";
			request.setAttribute("MesErreurs", e);
		}
		return new ModelAndView(destinationPage);
	}
	
}

	