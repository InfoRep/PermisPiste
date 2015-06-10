package com.epul.permispiste.controle;


import metier.*;
import com.epul.permispiste.dao.HibernateClient;

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


/**
 * Handles requests for the application home page.
 */
@Controller
public class ApprenantController extends MultiActionController {

	private static final Logger logger = LoggerFactory
			.getLogger(ApprenantController.class);

	/**
	 * Affichage de tous les jouets
	 */
	@RequestMapping(value = "apprenant")
	public ModelAndView afficherLesJeux(HttpServletRequest request,
		HttpServletResponse response) throws Exception {
		String destinationPage;	

		destinationPage = "/apprenant/liste";
			
		return new ModelAndView(destinationPage);
	}
}

	