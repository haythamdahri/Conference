package com.conference.entities;

import java.util.*;

public class Conference {
	

	private int id;
	private Administrateur administrateur;
	private String titre;
	private String description;
	private Date date_start_soumis;
	private Date date_end_soumis;
	private String converture;
	private String adresse;
	private String telephone;
	private String email;
	private Date date;


	private List<Tutoriel> tutos = new ArrayList<Tutoriel>();
	private List<Session> sessions = new ArrayList<Session>();
	private List<Inscription> inscriptions = new ArrayList<Inscription>();
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Administrateur getAdministrateur() {
		return this.administrateur;
	}
	public void setAdministrateur(Administrateur administrateur) {
		this.administrateur = administrateur;
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
	public Date getDate_start_soumis() {
		return date_start_soumis;
	}
	public void setDate_start_soumis(Date date_start_soumis) {
		this.date_start_soumis = date_start_soumis;
	}
	public Date getDate_end_soumis() {
		return date_end_soumis;
	}
	public void setDate_end_soumis(Date date_end_soumis) {
		this.date_end_soumis = date_end_soumis;
	}
	public String getConverture() {
		return converture;
	}
	public void setConverture(String converture) {
		this.converture = converture;
	}
	public String getAdresse() {
		return adresse;
	}
	public void setAdresse(String adresse) {
		this.adresse = adresse;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public  List<Tutoriel> getTutos(){
		return this.tutos;
	}
	public void setTutos(List<Tutoriel> tutos) {
		this.tutos = tutos;
	}
	public List<Session> getSessions(){
		return this.sessions;
	}
	public void setSessions(List<Session> sessions) {
		this.sessions = sessions;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void ajouterSession(Session session) {
		this.sessions.add(session);
	}
	public void ajouterTutoriel(Tutoriel tutoriel) {
		this.tutos.add(tutoriel);
	}
	public void ajouterInscription(Inscription inscription) {
		this.inscriptions.add(inscription);
	}
	public List<Inscription> getInscriptions(){
		return this.inscriptions;
	}
	public int nbPapiersSoumis() {
		int counter = 0;
		for( Session session : this.getSessions() ) {
			counter += session.getPapiers().size();
		}
		return counter;
	}
	public int nbComites() {
		int counter = 0;
		for( Session session : this.getSessions() ) {
			counter += session.getComites().size();
		}
		return counter;
	}
	
	
	public Conference() {}
	
	public Conference(int id, Administrateur administrateur, String titre, String description, Date date_start_soumis, Date date_end_soumis, String couverture, String adresse, String telephone, Date date, String email) {
		this.id = id;
		this.administrateur = administrateur;
		this.titre = titre;
		this.description = description;
		this.date_start_soumis = date_start_soumis;
		this.date_end_soumis = date_end_soumis;
		this.converture = couverture;
		this.adresse = adresse;
		this.telephone = telephone;
		this.date  = date;
		this.email = email;
	}
	
	public Conference(int id, Administrateur administrateur, String titre, String description, Date date_start_soumis, Date date_end_soumis, String couverture, String adresse, String telephone, Date date, List<Tutoriel> tutos, List<Session> sessions) {
		this.id = id;
		this.administrateur = administrateur;
		this.titre = titre;
		this.description = description;
		this.date_start_soumis = date_start_soumis;
		this.date_end_soumis = date_end_soumis;
		this.converture = couverture;
		this.adresse = adresse;
		this.telephone = telephone;
		this.date  = date;
		this.tutos = tutos;
		this.sessions = sessions;
	}
	
	public String toString() {
		return this.id+" | "+this.administrateur+" | "+this.titre+" | "+this.description+" | "+this.date_start_soumis+" | "+this.date_end_soumis+" | "+this.converture+" | "+this.adresse+" | "+this.telephone+" | "+this.date;
	}
	
	
	
	
	
	
	
	
	
	
	
	

}
