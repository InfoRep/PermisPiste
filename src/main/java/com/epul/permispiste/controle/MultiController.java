package com.epul.permispiste.controle;

import metier.*;

import com.epul.permispiste.dao.ApprenantHClient;
import com.epul.permispiste.dao.InscriptionHClient;
import com.epul.permispiste.dao.JeuHClient;

import java.beans.DesignMode;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.epul.permispiste.dao.*;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MultiController extends MultiActionController {

	private static final Logger logger = LoggerFactory
			.getLogger(MultiController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping({ "/index", "/" })
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG,
				DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate);
		return "/index";
	}

	@RequestMapping(value = "/missions")
	public ModelAndView e(HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttrs)
			throws Exception {

		String destinationPage;
		try {
			String idA = request.getParameter("idA");
			if (idA != null && !idA.isEmpty()) {
				Apprenant a = new ApprenantHClient().getUneLigne(Integer
						.valueOf(idA));

				if (a != null) {
					//selectionner la liste des jeux de l'apprenant
					List<Inscrit> objs = new InscriptionHClient().getInscrJeu(a);
					
					request.setAttribute("apprenant", a);
					request.setAttribute("objs", objs);
					
					destinationPage = "/jeux/missions";
				} else {
					request.setAttribute("messError",
							"Aucun apprenant avec cet id n'a été trouvé.");
					return new ModelAndView("redirect:/apprenant/liste");
				}
			} else {
				redirectAttrs
						.addFlashAttribute(
								"messWarning",
								"Selectionnez l'apprenant dont vous souhaitez savoir les missions en cliquant sur le bouton '<span style='color:green'>Missions</span>'");
				return new ModelAndView("redirect:/apprenant/liste");
			}
		} catch (Exception e) {
			destinationPage = "/Erreur";
			request.setAttribute("MesErreurs", e.getMessage());
		}

		return new ModelAndView(destinationPage);
	}
}
