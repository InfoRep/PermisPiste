package com.epul.permispiste.service;

import com.epul.permispiste.gestiondeserreurs.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import metier.*;

public class ServiceHibernate {

	private static final SessionFactory sessionFactory;
	private static ServiceRegistry serviceRegistry;
	static {

		try {

			// on lit la configuration du fichier hibernate.cfg.xml
			System.out.println("Je vais lire le fichier de conf ");
			Configuration configuration = new Configuration();
			configuration.configure();
			serviceRegistry = new StandardServiceRegistryBuilder()
					.applySettings(configuration.getProperties()).build();
			sessionFactory = configuration.buildSessionFactory(serviceRegistry);
			System.out.println("J'ai lu le fichier de conf ");
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
			throw new ServiceHibernateException(
					"Impossible de construire la SessionFactory: "
							+ ex.getMessage(), ex);
		}
	}

	public static Session session;

	public static Session currentSession() throws ServiceHibernateException {
		try {
			if (session != null && session.isOpen()) 
				session.close();
			
			session = sessionFactory.openSession();
			System.out.println("Open session");
		} catch (Exception ex) {
			System.out.println("session " + ex.getMessage());
			throw new ServiceHibernateException(
					"Impossible d'accéder à la SessionFactory: "
							+ ex.getMessage(), ex);

		}
		return session;
	}
}
