package com.epul.permispiste.dao;

import org.hibernate.*;

import com.epul.permispiste.service.ServiceHibernate;
import com.epul.permispiste.gestiondeserreurs.MonException;
import com.epul.permispiste.gestiondeserreurs.ServiceHibernateException;

import metier.*;

import java.util.*;

public class InscriptionHClient {
	private Session session;

	public InscriptionHClient() {
		session = ServiceHibernate.currentSession();
	}

	/**
	 * Insertion
	 */
	public void insert(Inscrit inscr) throws HibernateException,
			ServiceHibernateException {
		try {
			session.beginTransaction();
			session.saveOrUpdate(inscr.getCalendrier()); // calendrier must be
															// not null
			session.save(inscr);
			session.getTransaction().commit();
		} catch (ServiceHibernateException ex) {
			throw new ServiceHibernateException("Erreur de service Hibernate: "
					+ ex.getMessage(), ex);
		} catch (Exception ex) {
			System.out.println(ex);
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
	}

	/**
	 * Trouver une inscription selon un apprenant, une date et un jeu
	 */
	public boolean checkFind(Apprenant a, Calendrier c, Jeu j)
			throws HibernateException, ServiceHibernateException {
		try {
			Query query = session
					.createQuery("SELECT inscr FROM Inscrit inscr WHERE inscr.apprenant = :a and inscr.calendrier = :c and inscr.jeu = :j");
			query.setParameter("a", a);
			query.setParameter("c", c);
			query.setParameter("j", j);

			return (null != query.uniqueResult());
		} catch (Exception ex) {
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
	}

	public List<Inscrit> findByApprennant(Apprenant a)
			throws HibernateException, ServiceHibernateException {
		List<Inscrit> inscrits = new ArrayList<Inscrit>();

		try {
			Query query = session
					.createQuery("SELECT inscr FROM Inscrit inscr "
							+ "JOIN FETCH inscr.jeu j "	//avoid lazy loading
						//	+ "JOIN FETCH j.missions miss "
							+ "WHERE inscr.apprenant = :a "
							+ "GROUP BY inscr.jeu");

			query.setParameter("a", a);

			inscrits = (List<Inscrit>) query.list();
		} catch (Exception ex) {
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}

		return inscrits;
	}
}
