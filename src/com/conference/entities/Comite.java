package com.conference.entities;

public class Comite extends Professeur{

	private int comite_id;
	private Session session;
	
	public int getComite_id() {
		return comite_id;
	}
	public void setComite_id(int comite_id) {
		this.comite_id = comite_id;
	}

	public Session getSession() {
		return session;
	}
	public void setSession(Session session) {
		this.session = session;
	}
	
	public Comite(int comite_id,int professeur_id, String metier, int user_id, String username, String nom, String prenom, String email, String password, String telephone, String image, Session session) {
		super(professeur_id, metier, user_id, username, nom, prenom, email, password, telephone, image);
		this.comite_id = comite_id;
		this.session = session;
	}

}
