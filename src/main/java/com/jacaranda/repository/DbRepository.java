package com.jacaranda.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.SelectionQuery;

import com.jacaranda.model.Company;
import com.jacaranda.utility.DbUtility;

public class DbRepository {
	
	
	public static <T> T find(Class<T> c, int id) throws Exception{
		Session session;
		T result = null;
		try {
			session = DbUtility.getSessionFactory().openSession();
		} catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		try {
			result = session.find(c, id);
		} catch (Exception e) {
			throw new Exception("Error al obtener la entidad");
		}
		return result;
	}
	
	public static <T> List<T> findAll(Class<T> c) throws Exception{
		Session session;
		List<T> result = null;
		try {
			session = DbUtility.getSessionFactory().openSession();
		} catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		try {
			result = (List<T>) session.createSelectionQuery("From " + c.getName()).getResultList();
		} catch (Exception e) {
			throw new Exception("Error al obtener la entidad");
		}
		return result;
	}
	
	public static <T> void addEntity(T T) { 
		Transaction transaction = null; 
		Session session = DbUtility.getSessionFactory().openSession(); 
		transaction = (Transaction) session.beginTransaction(); 
		
		try {
			session.persist(T); 
			transaction.commit(); 
		} catch (Exception e) {
			System.out.println("Error al añadir");
			transaction.rollback(); 
		}
		session.close(); 
	
}
	public static <T> void editEntity(T T) { 
		Transaction transaction = null; 
		Session session = DbUtility.getSessionFactory().openSession(); 
		transaction = (Transaction) session.beginTransaction(); 
		
		try {
			session.merge(T); 
			transaction.commit(); 
		} catch (Exception e) {
			System.out.println("Error al añadir");
			transaction.rollback(); 
		}
		session.close(); 
	
}
	
	public static <T> void deleteEntity(Class<T> t,int id) { 
		T result = null;
		Transaction transaction = null; 
		Session session = DbUtility.getSessionFactory().openSession(); 
		
		SelectionQuery<T> q =
				session.createSelectionQuery("From " + t.getName() + " where id = :id",t);
				q.setParameter("id", id); 
				List<T> entity = q.getResultList(); 
				if(entity.size() != 0) { 
					transaction = (Transaction) session.beginTransaction(); 
					result = entity.get(0);
					session.remove(result); 
					transaction.commit(); 
					session.close();
				}
				
	}
	
	
}
