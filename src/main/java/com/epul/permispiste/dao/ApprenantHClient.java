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
	
	public ApprenantHClient() {
		session = ServiceHibernate.currentSession();
	}
	
	public List<Apprenant> getTouteslesLignes() throws HibernateException,
			ServiceHibernateException {
		try {			
			Query query = session.createQuery("SELECT j  FROM Apprenant AS j");
			mesApprenants = (List<Apprenant>) query.list();
		} catch (Exception ex) {
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
		return mesApprenants;
	}
	
	public Apprenant getUneLigne(int num) throws ServiceHibernateException ,Exception{
		Apprenant unApprenant = null;
		try {
			Query query = session.createQuery("SELECT j FROM Apprenant AS j WHERE j.numapprenant = :num");
			query.setParameter("num", num);
			
			unApprenant = (Apprenant) query.uniqueResult();
		} catch (ServiceHibernateException ex) {
			throw new ServiceHibernateException("Erreur de service Hibernate: "
					+ ex.getMessage(), ex);
		} catch (Exception ex) {
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
		return unApprenant;
	}
	
	public void ajouter(Apprenant app) throws ServiceHibernateException ,Exception{
		try {			
			session.beginTransaction();
			session.save(app);
			session.getTransaction().commit();
		} catch (ServiceHibernateException ex) {
			throw new ServiceHibernateException("Erreur de service Hibernate: "
					+ ex.getMessage(), ex);
		} catch (Exception ex) {
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
	}
	
	public void modifier(Apprenant app) throws ServiceHibernateException ,Exception{
		try {			
			session.beginTransaction();
			session.update(app);
			session.getTransaction().commit();
		} catch (ServiceHibernateException ex) {
			throw new ServiceHibernateException("Erreur de service Hibernate: "
					+ ex.getMessage(), ex);
		} catch (Exception ex) {
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
	}
}
