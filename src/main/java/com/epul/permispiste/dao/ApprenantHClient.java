package com.epul.permispiste.dao;

import java.util.List;

import metier.Apprenant;
import metier.Inscrit;
import metier.Obtient;

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
	
	/**
	 * Selectionner tous les apprenants avec un filtre nom
	 * @param nom filtre nom
	 */
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
	
	/**
	 * Selectionner tous les apprenants
	 */
	public List<Apprenant> getTouteslesLignes() throws HibernateException,
			ServiceHibernateException {
		return this.getTouteslesLignes(null);
	}
	
	/**
	 * Selectionner les apprenants selon leur id
	 * @param nums ids
	 */
	public List<Apprenant> getLignes(List<Integer> nums) throws HibernateException,
			ServiceHibernateException {
		try {
			Query query = session.createQuery("SELECT a  FROM Apprenant AS a WHERE a.numapprenant in (:nums)");
			query.setParameterList("nums", nums);
			mesApprenants = (List<Apprenant>) query.list();
		} catch (Exception ex) {
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
		return mesApprenants;
	}
	
	/**
	 * Selectionner l'apprenant selon le couple (nom, prenom)
	 */
	public Apprenant getUneLigne(String nom, String prenom) throws HibernateException,
			ServiceHibernateException {
		Apprenant unApprenant = null;
		try {
			Query query = session.createQuery("SELECT a  FROM Apprenant AS a "
					+ "WHERE a.nomapprenant = :nom and a.prenomapprenant = :prenom ORDER BY a.numapprenant");
			query.setMaxResults(1);
			query.setParameter("nom", nom);
			query.setParameter("prenom", prenom);

			unApprenant = (Apprenant) query.uniqueResult();
		} catch (Exception ex) {
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
		return unApprenant;
	}
	
	/**
	 * Selectionner un apprenant selon son id
	 * @param num id 
	 */
	public Apprenant getUneLigne(int num) throws ServiceHibernateException ,Exception{
		Apprenant unApprenant = null;
		try {
			Query query = session.createQuery("SELECT a FROM Apprenant AS a WHERE a.numapprenant = :num");
			query.setParameter("num", num);
			
			unApprenant = (Apprenant) query.uniqueResult();
		} catch (ServiceHibernateException ex) {
			System.out.println(ex);
			throw new ServiceHibernateException("Erreur de service Hibernate: "
					+ ex.getMessage(), ex);
		} catch (Exception ex) {
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
		return unApprenant;
	}
	
	/**
	 * Ajouter un apprenant
	 */
	public void ajouter(Apprenant app) throws ServiceHibernateException ,Exception{
		try {			
			session = ServiceHibernate.currentSession();
			session.beginTransaction();
			session.save(app);
			session.getTransaction().commit();
		} catch (ServiceHibernateException ex) {
			System.out.println(ex);
			throw new ServiceHibernateException("Erreur de service Hibernate: "
					+ ex.getMessage(), ex);
		} catch (Exception ex) {
			System.out.println(ex);
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
	}
	
	/**
	 * Modifier un apprenant
	 */
	public void modifier(Apprenant app) throws ServiceHibernateException ,Exception{
		try {			
			session = ServiceHibernate.currentSession();
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
	
	/**
	 * Effacer un apprenant
	 */
	public void effacer(Apprenant app) throws ServiceHibernateException ,Exception{
		try {	
			session.beginTransaction();
			
			//suppression obtient
			for(Obtient o : app.getObtients())
				session.delete(o);
			
			//suppression inscrit
			for(Inscrit i : app.getInscrits())
				session.delete(i);
			
			session.delete(app);
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
