package com.conference.entities;

import java.util.*;

public class Administrateur extends Professeur{

	private int admin_id;
	
	private List<Conference> conferences = new ArrayList<Conference>();
	
	public int getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(int admin_id) {
		this.admin_id = admin_id;
	}
	public List<Conference> getConferences(){
		return this.conferences;
	}
	public void setConferences(List<Conference> conferences) {
		this.conferences = conferences;
	}
	public void ajouterConference(Conference conference) {
		this.conferences.add(conference);
	}

	public Administrateur(int admin_id, int professeur_id, String metier, int user_id, String username, String nom, String prenom, String email, String password, String telephone, String image) {
		super(professeur_id, metier, user_id, username, nom, prenom, email, password, telephone, image);
		this.admin_id = admin_id;
	}

}
