package com.epul.permispiste.dao;

import metier.Obtient;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import com.epul.permispiste.gestiondeserreurs.MonException;
import com.epul.permispiste.gestiondeserreurs.ServiceHibernateException;
import com.epul.permispiste.service.ServiceHibernate;

public class ObtientHClient {
	private Session session;

	public ObtientHClient() {
		session = ServiceHibernate.currentSession();
	}

	/**
	 * Insertion
	 */
	public void insert(Obtient o) throws HibernateException,
			ServiceHibernateException {
		try {
			session.beginTransaction();
			session.saveOrUpdate(o.getCalendrier()); // calendrier must be not null
			session.saveOrUpdate(o.getAction()); //Action must be not null
			session.saveOrUpdate(o.getApprenant()); //Apprenant must be not null
			session.save(o);
			session.getTransaction().commit();
		} catch (ServiceHibernateException ex) {
			throw new ServiceHibernateException("Erreur de service Hibernate: "
					+ ex.getMessage(), ex);
		} catch (Exception ex) {
			System.out.println(ex);
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
	}
}
