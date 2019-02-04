package com.conference.entities;

public class Inscription {

	private int inscription_id;
	private User user;
	private Session session;
	
	public int getInscription_id() {
		return inscription_id;
	}
	public void setInscription_id(int inscrition_id) {
		this.inscription_id = inscrition_id;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Session getSession() {
		return this.session;
	}
	public void setSession(Session session) {
		this.session = session;
	}
	
	public Inscription(int inscription_id, User user, Session session) {
		this.inscription_id = inscription_id;
		this.user = user;
		this.session = session;
	}
	
	public Inscription(User user, Session session) {
		this.user = user;
		this.session = session;
	}
	
}
