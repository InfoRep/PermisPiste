package com.epul.permispiste.dao;

import org.hibernate.*;

import com.epul.permispiste.service.ServiceHibernate;
import com.epul.permispiste.gestiondeserreurs.MonException;
import com.epul.permispiste.gestiondeserreurs.ServiceHibernateException;

import metier.*;

import java.util.*;

public class ObjectifHClient {
	private Session session;
	
	public ObjectifHClient() {
		session = ServiceHibernate.currentSession();
	}


	/**
	 * Find one by id
	 */
	public Objectif find(int numobjectif) throws ServiceHibernateException, Exception {
		Objectif unObj = null;
		try {
			Query query = session.createQuery("SELECT o FROM Objectif AS o WHERE o.numobjectif = :num");
			query.setParameter("num", numobjectif);
			
			unObj = (Objectif)query.uniqueResult();
		} catch (Exception ex) {
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
		
		return unObj;
	}	
}
