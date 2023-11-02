package com.jacaranda.model;

import java.util.Objects;

import com.jacaranda.exception.UserException;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="user")
public class User {
	@Id
	private String user;
	
	private String password;
	private String role;
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
	public User(String user, String password, String role) {
		super();
		this.user = user;
		this.password = password;
		this.role = role;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) throws UserException {
		if(user.equals("")) {
			throw new UserException("El usuario no puede estar vacío");
		}
		this.user = user;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) throws UserException {
		if(password.equals("")) {
			throw new UserException("El usuario no puede estar vacío");
		}
		this.password = password;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	@Override
	public int hashCode() {
		return Objects.hash(user);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		return Objects.equals(user, other.user);
	}
	
	
}
