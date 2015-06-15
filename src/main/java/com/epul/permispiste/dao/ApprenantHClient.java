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
	
	public List<Apprenant> getTouteslesLignes(String nom) throws HibernateException,
			ServiceHibernateException {
		try {			
			Query query = null;
			if (nom == null || (nom != null && nom.isEmpty()))
			{
				query = session.createQuery("SELECT a  FROM Apprenant AS a");
			}
			else 
			{
				query = session.createQuery("SELECT a  FROM Apprenant AS a WHERE a.nomapprenant like :nom");
				query.setParameter("nom", '%'+nom+'%');
			}
			mesApprenants = (List<Apprenant>) query.list();
			
		} catch (Exception ex) {
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
		return mesApprenants;
	}
	
	public List<Apprenant> getLignes(List<Integer> nums) throws HibernateException,
			ServiceHibernateException {
		try {
			Query query = session.createQuery("SELECT a  FROM Apprenant AS a WHERE a.numapprenant in (:nums)");
			query.setParameter("nums", nums);
			mesApprenants = (List<Apprenant>) query.list();
		} catch (Exception ex) {
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
		return mesApprenants;
	}
	
	public Apprenant getUneLigne(int num) throws ServiceHibernateException ,Exception{
		Apprenant unApprenant = null;
		try {
			Query query = session.createQuery("SELECT a FROM Apprenant AS a WHERE a.numapprenant = :num");
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
	
	public void effacer(Apprenant app) throws ServiceHibernateException ,Exception{
		try {			
			session.beginTransaction();
			session.delete(app);
			session.getTransaction().commit();
		} catch (ServiceHibernateException ex) {
			throw new ServiceHibernateException("Erreur de service Hibernate: "
					+ ex.getMessage(), ex);
		} catch (Exception ex) {
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
	}
}
