package com.jacaranda.model;

import java.util.Objects;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name="employeeProject")
public class EmployeeProject {
	
	@Id
	@ManyToOne
	@JoinColumn(name="idProject")
	private Project project;
	
	@Id
	@ManyToOne
	@JoinColumn(name="idEmployee")
	private Employee employee;
	private int minutes;
	public EmployeeProject() { 
		super();
		// TODO Auto-generated constructor stub
	}
	public EmployeeProject(Project project, Employee employee, int minutes) {
		super();
		this.project = project;
		this.employee = employee;
		this.minutes = minutes;
	}
	public Project getProject() {
		return project;
	}
	public void setProject(Project project) {
		this.project = project;
	}
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public int getMinutes() {
		return minutes;
	}
	public void setMinutes(int minutes) {
		this.minutes = minutes;
	}
	@Override
	public int hashCode() {
		return Objects.hash(employee, project);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		EmployeeProject other = (EmployeeProject) obj;
		return Objects.equals(employee, other.employee) && Objects.equals(project, other.project);
	}
	
	
}
