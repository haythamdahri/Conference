package com.conference.entities;

import java.util.*;

public class Papier {
	
	private int id;
	private String titre;
	private String description;
	private float note;
	private String etat;
	private User user;
	private Session session;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitre() {
		return titre;
	}
	public void setTitre(String titre) {
		this.titre = titre;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public float getNote() {
		return this.note;
	}
	public void setNote(float note) {
		this.note = note;
	}
	public String getEtat() {
		return etat;
	}
	public void setEtat(String etat) {
		this.etat = etat;
	}
	public User getUser() {
		return user;
	}
	public void setUser_id(User user) {
		this.user = user;
	}
	public Session getSession() {
		return this.session;
	}
	public void setSession(Session session) {
		this.session = session;
	}
	
	public Papier() {}
	
	public Papier(int id, String titre, String description,User user, Session session,String etat, float note) {
		this.id = id;
		this.titre = titre;
		this.description = description;
		this.note = note;
		this.etat = etat;
		this.user = user;
		this.session = session;
		this.session.ajouterPapier(this);
	}
	
	public Papier(String titre, String description, User user, Session session, String etat, float note) {
		this.titre = titre;
		this.description = description;
		this.note = note;
		this.etat = etat;
		this.user = user;
		this.session = session;
		this.session.ajouterPapier(this);
	}
	
	public Papier(int id, String titre, String description, String etat, User user) {
		this.id = id;
		this.titre = titre;
		this.description = description;
		this.etat = etat;
		this.user = user;
	}
	
	
}
