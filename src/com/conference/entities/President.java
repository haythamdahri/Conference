package com.conference.entities;

public class President extends Professeur{
	
	private int president_id;
	
	
	public int getPresident_id() {
		return president_id;
	}
	public void setPresident_id(int president_id) {
		this.president_id = president_id;
	}
	
	
	public President(int president_id, int professeur_id, String metier, int user_id, String username, String nom, String prenom, String email, String password,
			String telephone, String image) {
		super(professeur_id, metier, user_id, username, nom, prenom, email, password, telephone, image);
		this.president_id = president_id;
	}
	
}
