package com.epul.permispiste.dao;

import org.hibernate.*;

import com.epul.permispiste.service.ServiceHibernate;
import com.epul.permispiste.gestiondeserreurs.MonException;
import com.epul.permispiste.gestiondeserreurs.ServiceHibernateException;

import metier.*;

import java.util.*;

public class JeuHClient {
	private Session session;
	
	public JeuHClient() {
		session = ServiceHibernate.currentSession();
	}

	/**
	 * Find all jeux selon le libelle 
	 */
	public List<Jeu> findAll(String libelle) throws HibernateException,
			ServiceHibernateException {
		List<Jeu> mesJeux = new ArrayList<Jeu>();
		try {
			Query query = session.createQuery("SELECT j  FROM Jeu AS j");
			
			if (libelle != null && !libelle.isEmpty())
			{
				query = session.createQuery("SELECT j FROM Jeu as j WHERE j.libellejeu like :libelle");
				query.setParameter("libelle", '%'+libelle+'%');
			}
			
			mesJeux = (List<Jeu>) query.list();
		} catch (Exception ex) {
			System.out.println(ex);
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
		
		return mesJeux;
	}
	
	/**
	 * Find all jeux
	 */
	public List<Jeu> findAll() throws HibernateException,
		ServiceHibernateException {
		return this.findAll(null);
	}

	/**
	 * Find one by id
	 */
	public Jeu find(int num) throws ServiceHibernateException, Exception {
		Jeu unJeu = null;
		try {
			Query query = session.createQuery("SELECT j FROM Jeu AS j WHERE j.numjeu = :num");
			query.setParameter("num", num);
			
			unJeu = (Jeu)query.uniqueResult();
		} catch (Exception ex) {
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
		
		return unJeu;
	}
	
	/**
	 * Find jeux by ids
	 */
	public List<Jeu> findByIds(List<Integer> nums) throws ServiceHibernateException, Exception 
	{
		List<Jeu> mesJeux = new ArrayList<Jeu>();
		
		try {
			Query query = session.createQuery("SELECT j FROM Jeu AS j WHERE j.numjeu in (:nums)");
			query.setParameterList("nums", nums);
			
			mesJeux = (List<Jeu>) query.list();
		} catch(Exception ex) {
			System.out.println(ex.getMessage());
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
		
		return mesJeux;
	}
}
