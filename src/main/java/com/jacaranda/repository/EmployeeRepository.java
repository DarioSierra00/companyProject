package com.jacaranda.repository;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.SelectionQuery;

import com.jacaranda.model.Employee;
import com.jacaranda.model.EmployeeProject;
import com.jacaranda.utility.DbUtility;

public class EmployeeRepository {
	
	public static ArrayList<EmployeeProject> getEmployeeProjects(int idEmployee) throws Exception{
		ArrayList<EmployeeProject> listEmployeeProject = null;
		Session session = null;
			
		try {
			session = DbUtility.getSessionFactory().openSession();
			
			SelectionQuery<EmployeeProject> queryEmployeeProject = (SelectionQuery<EmployeeProject>)
					session.createNativeQuery("Select * from employeeProject where idEmployee = ?1", EmployeeProject.class);
			queryEmployeeProject.setParameter(1, idEmployee);
			listEmployeeProject = (ArrayList<EmployeeProject>) queryEmployeeProject.getResultList();
		} catch (Exception e) {
			throw new Exception(e.getMessage());
		}
		session.close();
		return listEmployeeProject;
	}
	
	public static void delete(Employee employee) throws Exception {
		Transaction transaction = null;
		Session session;
		try {
			session = DbUtility.getSessionFactory().openSession();
			transaction = session.beginTransaction();
		} catch (Exception e) {
			throw new Exception("Error al conectar con la base de datos");
		}
		
		try {
			ArrayList<EmployeeProject> listEmployeeProyect = (ArrayList<EmployeeProject>) employee.getEmployeeProject();
			for(EmployeeProject employeeProject : listEmployeeProyect) {
				session.remove(employeeProject);
			}
		} catch (Exception e) {
			transaction.rollback();
			session.close();
			throw new Exception("Error al borrar el objeto");
		}
		session.close();
	}
}
