package com.epul.permispiste.dao;

import java.util.List;

import metier.Apprenant;
import metier.Jeu;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import com.epul.permispiste.gestiondeserreurs.MonException;
import com.epul.permispiste.gestiondeserreurs.ServiceHibernateException;
import com.epul.permispiste.service.ServiceHibernate;

public class ApprenantHClient {

	private List<Apprenant> mesApprenants = null;
	private Session session;
	
	public List<Apprenant> getTouteslesLignes() throws HibernateException,
			ServiceHibernateException {
		try {
			System.out.println("Get toutes les lignes :Je vais lire le fichier de conf ");
			session = ServiceHibernate.currentSession();

			Query query = session.createQuery("SELECT j  FROM Apprenant AS j");
			mesApprenants = (List<Apprenant>) query.list();
		} catch (Exception ex) {

			System.out.println("Erreur ServiceHiber : " + ex.getMessage());

			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
		return mesApprenants;
	}
	
	public Apprenant getUneLigne(int num) throws ServiceHibernateException ,Exception{
		boolean trouve = false;
		Apprenant unApprenant = null;
		try {
			
			Query query = session.createQuery("SELECT j  FROM Apprenant AS j WHERE j.numapprenant = :num");
			query.setParameter("num", num);
			
		} catch (ServiceHibernateException ex) {
			throw new ServiceHibernateException("Erreur de service Hibernate: "
					+ ex.getMessage(), ex);
		} catch (Exception ex) {
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
		return unApprenant;
	}
}
