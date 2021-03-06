package com.epul.permispiste.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import metier.Apprenant;
import metier.Calendrier;
import metier.Inscrit;
import metier.Jeu;
import metier.Mission;
import metier.Objectif;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import com.epul.permispiste.gestiondeserreurs.MonException;
import com.epul.permispiste.gestiondeserreurs.ServiceHibernateException;
import com.epul.permispiste.service.ServiceHibernate;

public class InscriptionHClient {
	private Session session;

	/**
	 * Insertion
	 */
	public void insert(Inscrit inscr) throws HibernateException,
			ServiceHibernateException {
		session = ServiceHibernate.currentSession();
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
		session = ServiceHibernate.currentSession();
		try {
			Query query = session
					.createQuery("SELECT inscr FROM Inscrit inscr WHERE inscr.apprenant = :a and inscr.calendrier = :c and inscr.jeu = :j");
			query.setParameter("a", a);
			query.setParameter("c", c);
			query.setParameter("j", j);

			return null != query.uniqueResult();
		} catch (Exception ex) {
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
	}
	
	/**
	 * Actions sur la page missions
	 */
	public List<Object[]> getActions(Apprenant a, 
									 Jeu j,
									 Calendrier c,
									 Mission m,
									 Objectif obj) 
			throws HibernateException, ServiceHibernateException {
		session = ServiceHibernate.currentSession();
		
		List<Object[]> objs = new ArrayList<>();
		
		try {
			Map<String, Object> parameters = new HashMap<>();
			
			String str = "SELECT act, obj, m, i "
						+ "FROM Action act "
						+ "JOIN act.objectifs obj "
						+ "JOIN obj.missions m "
						+ "JOIN FETCH m.jeu j "
						+ "JOIN j.inscrits i ";
					
			//apprenant
			str += "WHERE i.apprenant = :a ";
			parameters.put("a", a);
			
			//objectif
			if (obj != null)
			{
				str += "and obj = :objec ";
				parameters.put("objec", obj);
			}
			
			//missions
			if (m != null)
			{
				str += "and m = :miss ";
				parameters.put("miss", m);
			}
			
			//jeu
			if (j != null)
			{
				str += "and j = :je ";
				parameters.put("je", j);
			}
			
			//calendrier
			if (c != null)
			{
				str += "and i.calendrier = :c ";
				parameters.put("c", c);
			}
			
			str += "GROUP BY i, j, m, obj, act ";
			str += "ORDER BY i.calendrier DESC, i, j, m, obj, act";
			
			Query query = session.createQuery(str);
			for (Entry<String, Object> e : parameters.entrySet())
				query.setParameter(e.getKey(), e.getValue());
			
			objs = (List<Object[]>)query.list();
		} catch (Exception ex) {
			System.out.println(ex);
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
			
		return objs;
	}
}
