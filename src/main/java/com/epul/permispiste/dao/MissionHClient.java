package com.epul.permispiste.dao;

import org.hibernate.*;

import com.epul.permispiste.service.ServiceHibernate;
import com.epul.permispiste.gestiondeserreurs.MonException;
import com.epul.permispiste.gestiondeserreurs.ServiceHibernateException;

import metier.*;

import java.util.*;

public class MissionHClient {
	private Session session;
	
	public MissionHClient() {
		session = ServiceHibernate.currentSession();
	}


	/**
	 * Find one by id
	 */
	public Mission find(int nummission) throws ServiceHibernateException, Exception {
		Mission miss = null;
		try {
			Query query = session.createQuery("SELECT m FROM Mission AS m WHERE m.nummission = :num");
			query.setParameter("num", nummission);
			
			miss = (Mission)query.uniqueResult();
		} catch (Exception ex) {
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
		
		return miss;
	}	
}
