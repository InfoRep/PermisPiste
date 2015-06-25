package com.epul.permispiste.dao;

import org.hibernate.*;

import com.epul.permispiste.service.ServiceHibernate;
import com.epul.permispiste.gestiondeserreurs.MonException;
import com.epul.permispiste.gestiondeserreurs.ServiceHibernateException;

import metier.*;

import java.util.*;

public class CalendrierHClient {
	private Session session;
	
	/**
	 * Find one by id
	 */
	public Calendrier find(Date datejour) throws ServiceHibernateException, Exception {
		session = ServiceHibernate.currentSession();
		
		Calendrier unCal = null;
		try {
			Query query = session.createQuery("SELECT c FROM Calendrier AS c WHERE c.datejour = :datejour");
			query.setParameter("datejour", datejour);
			
			unCal = (Calendrier)query.uniqueResult();
		} catch (Exception ex) {
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
		
		return unCal;
	}	
}
