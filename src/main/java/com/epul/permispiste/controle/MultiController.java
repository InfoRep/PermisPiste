package com.epul.permispiste.controle;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import metier.Apprenant;
import metier.Calendrier;
import metier.Jeu;
import metier.Mission;
import metier.Objectif;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.epul.permispiste.dao.ApprenantHClient;
import com.epul.permispiste.dao.CalendrierHClient;
import com.epul.permispiste.dao.InscriptionHClient;
import com.epul.permispiste.dao.JeuHClient;
import com.epul.permispiste.dao.MissionHClient;
import com.epul.permispiste.dao.ObjectifHClient;

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
	public ModelAndView missions(HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttrs)
			throws Exception {

		String destinationPage;
		try {
			String idA = request.getParameter("idA");
			if (idA != null && !idA.isEmpty()) {
				Apprenant a = new ApprenantHClient().getUneLigne(Integer
						.valueOf(idA));

				if (a != null) {
					String idC = request.getParameter("idC");
					Calendrier c = null;
					if (idC != null && !idC.isEmpty())
					{
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						c = new CalendrierHClient().find(sdf.parse(idC));
					}
					
					String idJ = request.getParameter("idJ");
					Jeu j = null;
					if (idJ != null && !idJ.isEmpty())
						j = new JeuHClient().find(Integer.valueOf(idJ));
					
					String idM = request.getParameter("idM");
					Mission m = null;
					if (idM != null && !idM.isEmpty())
						m = new MissionHClient().find(Integer.valueOf(idM));
					
					String idO = request.getParameter("idO");
					Objectif o = null;
					if (idO != null && !idO.isEmpty())
						o = new ObjectifHClient().find(Integer.valueOf(idO));
					
					//selectionner la liste des actions de l'apprenant
					List<Object[]> objs = new InscriptionHClient().getActions(a, j, c, m, o);
					
					request.setAttribute("apprenant", a);
					request.setAttribute("objs", objs);
					request.setAttribute("idJ", idJ);
					request.setAttribute("idM", idM);
					request.setAttribute("idO", idO);
					request.setAttribute("idC", idC);
					
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
