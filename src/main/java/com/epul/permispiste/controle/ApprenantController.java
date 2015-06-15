package com.epul.permispiste.controle;


import metier.*;

import com.epul.permispiste.dao.JeuHClient;

import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.epul.permispiste.dao.*;
import com.epul.permispiste.gestiondeserreurs.MonException;


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
	@RequestMapping(value = "apprenant/liste")
	public ModelAndView afficherLesApprenants(HttpServletRequest request,
		HttpServletResponse response) throws Exception {
		String destinationPage;	
		ApprenantHClient unGestClient = new ApprenantHClient();
		try {
			List<Apprenant> mesApprenants = unGestClient.getTouteslesLignes();
			request.setAttribute("mesApprenants",mesApprenants);

		} catch (Exception e) {
			request.setAttribute("MesErreurs", e.getMessage());
		}
		
		destinationPage = "/apprenant/liste";
			
		return new ModelAndView(destinationPage);
	}
	
	/**
	 * Saisie d'un apprenant
	 */
	@RequestMapping(value = "apprenant/saisie")
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
			request.setAttribute("MesErreurs", e.getMessage());
		}
			
		return new ModelAndView(destinationPage);
	}
	
	/**
	 * Modifier un apprenant
	 */
	@RequestMapping(value = "apprenant/modif")
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
			System.out.println(e.getMessage());
			request.setAttribute("MesErreurs", e.getMessage());
		}
				
		return new ModelAndView(destinationPage);
	}
	
	/**
	 * Sauvegarder un apprenant
	 */
	@RequestMapping(value = "apprenant/sauvegarder")
	public ModelAndView saveApprenant(HttpServletRequest request,
		HttpServletResponse response) throws Exception {
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
				request.setAttribute("messSuccess",
						"L'apprenant " + app.getNumapprenant()
								+ " a bien été modifié!");
			} else {
				unGestClient.ajouter(app);
				request.setAttribute("messSuccess",
						"L'apprenant " + app.getNumapprenant()
								+ " a bien été ajouté!");
			}
			
			destinationPage = "/apprenant/liste";

		} catch (Exception e) {
			request.setAttribute("MesErreurs", e.getMessage());
			System.out.println(e.getMessage());
		}
			
		return new ModelAndView(destinationPage);
	}
	
}

	