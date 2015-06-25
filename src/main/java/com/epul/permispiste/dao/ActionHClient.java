package com.epul.permispiste.dao;

import java.util.ArrayList;
import java.util.List;

import metier.Action;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import com.epul.permispiste.gestiondeserreurs.MonException;
import com.epul.permispiste.gestiondeserreurs.ServiceHibernateException;
import com.epul.permispiste.service.ServiceHibernate;

public class ActionHClient {
	private Session session;
	
	public ActionHClient() {
		session = ServiceHibernate.currentSession();
	}
	
	/**
	 * Selectionner toutes les actions
	 */
	public List<Action> findAll() throws HibernateException,
			ServiceHibernateException {
		List<Action> actions = new ArrayList<>();
		try {			
			Query query = session.createQuery("SELECT a FROM Action AS a");
			
			actions = (List<Action>) query.list();
			
		} catch (Exception ex) {
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
		return actions;
	}
	
	/**
	 * Trouver une action
	 * @param num numero action
	 */
	public Action find(int num) throws HibernateException,
			ServiceHibernateException {
		Action action = null;
		try {			
			Query query = session.createQuery("SELECT a FROM Action AS a WHERE a.numaction = :num");
			query.setParameter("num", num);
			
			action = (Action) query.uniqueResult();
			
		} catch (Exception ex) {
			throw new MonException("Erreur  Hibernate: ", ex.getMessage());
		}
		return action;
	}
}
