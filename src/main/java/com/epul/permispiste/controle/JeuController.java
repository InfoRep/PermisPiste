package com.epul.permispiste.controle;

import java.util.Date;
import java.util.List;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import metier.Apprenant;
import metier.Calendrier;
import metier.Inscrit;
import metier.InscritId;
import metier.Jeu;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.epul.permispiste.dao.ApprenantHClient;
import com.epul.permispiste.dao.InscriptionHClient;
import com.epul.permispiste.dao.JeuHClient;

/**
 * Handles requests for the application home page.
 */
@Controller
public class JeuController extends MultiActionController {

	private static final Logger logger = LoggerFactory
			.getLogger(JeuController.class);

	/**
	 * Affichage de tous les jouets
	 */
	@RequestMapping(value = "jeux/liste")
	public ModelAndView afficherLesJeux(HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttrs)
			throws Exception {
		String destinationPage;

		try {
			// Attribute from redirection
			for (Entry<String, Object> e : redirectAttrs.asMap().entrySet())
				request.setAttribute(e.getKey(), e.getValue()); // add
																// attributes to
																// the page

			// find all game
			List<Jeu> mesJeux = new JeuHClient().findAll(request
					.getParameter("sJeu"));
			request.setAttribute("mesJeux", mesJeux);
			request.setAttribute("sJeu", request.getParameter("sJeu"));

			destinationPage = "/jeux/listeJeux";

		} catch (Exception e) {
			destinationPage = "/Erreur";
			request.setAttribute("MesErreurs", e.getMessage());
		}

		return new ModelAndView(destinationPage);
	}

	@RequestMapping(value = "jeux/inscription")
	public ModelAndView inscription(HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttrs)
			throws Exception {
		String destinationPage = "/jeux/inscription";

		try {
			int idJeu = Integer.valueOf(request.getParameter("j"));

			if (request.getParameter("valid") != null) {
				// get apprenant
				Apprenant a = new ApprenantHClient().getUneLigne(
						request.getParameter("nom"),
						request.getParameter("prenom"));

				// get jeu
				Jeu j = new JeuHClient().find(idJeu);

				if (a == null) {
					redirectAttrs.addFlashAttribute("messError",
							"L'apprenant est introuvable");
				} else if (j == null) {
					redirectAttrs.addFlashAttribute("messError",
							"Le jeu est introuvable");
				} else {
					// calendrier
					Calendrier c = new Calendrier(new Date(System.currentTimeMillis()));

					// creation inscription
					Inscrit inscr = new InscriptionHClient().find(a, c, j);
					if (inscr != null) {
						redirectAttrs
								.addFlashAttribute(
										"messWarning",
										"L'apprenant "
												+ a.getPrenomapprenant()
												+ " "
												+ a.getNomapprenant()
												+ " est dejà inscrit aujourd'hui pour le jeu "
												+ j.getLibellejeu());
					} else {
						inscr = new Inscrit(new InscritId(
								j.getNumjeu(), a.getNumapprenant(),
								c.getDatejour()), a, c, j);

						// insertion
						new InscriptionHClient().insert(inscr);

						// mess sucess
						redirectAttrs.addFlashAttribute(
								"messSucess",
								"L'apprenant " + a.getPrenomapprenant() + " "
										+ a.getNomapprenant()
										+ " est bien inscrit pour le jeu "
										+ j.getLibellejeu());
					}
				}
				return new ModelAndView("redirect:liste");
			} else {
				request.setAttribute("idJeu", idJeu);
			}

		} catch (Exception e) {
			request.setAttribute("MesErreurs", e.getMessage());
			destinationPage = "/Erreur";
		}

		return new ModelAndView(destinationPage);
	}
	
	@RequestMapping(value = "jeux/mesMissions")
	public ModelAndView e(HttpServletRequest request,
			HttpServletResponse response)
			throws Exception {
		
		String destinationPage;
		try {
			// find all game
			List<Jeu> mesJeux = new JeuHClient().findAll(request
					.getParameter("sJeu"));
			request.setAttribute("mesJeux", mesJeux);

			destinationPage = "/jeux/listeJeux";
		} catch (Exception e) {
			destinationPage = "/Erreur";
			request.setAttribute("MesErreurs", e.getMessage());
		}

		return new ModelAndView(destinationPage);
	}
}
