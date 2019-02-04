package com.conference.entities;

public class Professeur extends User{
	
	private int professeur_id;
	private String metier;
	

	public String getMetier() {
		return metier;
	}
	public void setMetier(String metier) {
		this.metier = metier;
	}
	public int getProfesseur_id() {
		return professeur_id;
	}
	public void setProfesseur_id(int professeur_id) {
		this.professeur_id = professeur_id;
	}


	public Professeur(int professeur_id, String metier, int user_id, String username, String nom, String prenom, String email, String password,String telephone, String image) {
		super(user_id, username, nom, prenom, email, password, telephone, image);
		this.professeur_id = professeur_id;	
		this.metier = metier;
	}
	
}
