package com.conference.entities;

public class User {
	private int user_id;
	private String username;
	private String nom;
	private String prenom;
	private String email;
	private String password;
	private String telephone;
	private String image;
	
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getNom() {
		return nom;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}
	public String getPrenom() {
		return prenom;
	}
	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String fullname() {
		return this.nom+" "+this.prenom;
	}
	
	public User() {}
	
	public User(int user_id, String username, String nom, String prenom, String email, String password, String telephone, String image) {
		this.user_id = user_id;
		this.username = username;
		this.nom = nom;
		this.prenom = prenom;
		this.email = email;
		this.password = password;
		this.telephone = telephone;;
		this.image = image;
	}
	
	public String toString() {
		return this.user_id+" | "+this.username+" | "+this.nom+" | "+this.prenom+" | "+this.email+" | "+this.password+" | "+this.telephone+" | "+this.image;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
