package com.conference.entities;

public class Tutoriel {

	private int id;
	private String titre;
	private String description;
	private Conference conference;
	
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
	
	public Conference getConference() {
		return conference;
	}
	public void setConference(Conference conference) {
		this.conference = conference;
	}
	public Tutoriel() {}
	
	public Tutoriel(int id, String titre, String description, Conference conference) {
		this.id = id;
		this.titre = titre;
		this.description = description;
		this.conference = conference;
		conference.ajouterTutoriel(this);
	}
	
}
