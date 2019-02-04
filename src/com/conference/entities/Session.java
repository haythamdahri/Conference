package com.conference.entities;

import java.util.*;

public class Session {
	
	private int id;
	private String titre;
	private Date date_start_session;
	private Date date_end_session;
	private Conference conference;
	private President president;
	
	private List<Comite> comites = new ArrayList<Comite>();
	private List<Papier> papiers = new ArrayList<Papier>();
	
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
	public Date getDate_start_session() {
		return date_start_session;
	}
	public void setDate_start_session(Date date_start_session) {
		this.date_start_session = date_start_session;
	}
	public Date getDate_end_session() {
		return date_end_session;
	}
	public void setDate_end_session(Date date_end_session) {
		this.date_end_session = date_end_session;
	}
	public President getPresident() {
		return president;
	}
	public void setPresident(President president) {
		this.president = president;
	}
	public List<Comite> getComites(){
		return this.comites;
	}
	public void setComites(List<Comite> comites) {
		this.comites = comites;
	}
	public List<Papier> getPapiers(){
		return this.papiers;
	}
	public void setPapiers(List<Papier> papiers) {
		this.papiers = papiers;
	}
	public Conference getConference() {
		return this.conference;
	}
	public void setConference(Conference conference) {
		this.conference = conference;
	}
	
	public void ajouterComite(Comite comite) {
		this.comites.add(comite);
	}
	
	public void ajouterPapier(Papier papier) {
		this.papiers.add(papier);
	}
	
	public Session() {}
	
	public Session(String titre, Date date_start_session, Date date_end_session, Conference conference, President president) {
		this.titre = titre;
		this.date_start_session = date_start_session;
		this.date_end_session = date_end_session;
		this.president = president;
		this.conference = conference;
		conference.ajouterSession(this);
	}
	
	public Session(int id, String titre, Date date_start_session, Date date_end_session, Conference conference, President president) {
		this.id = id;
		this.titre = titre;
		this.date_start_session = date_start_session;
		this.date_end_session = date_end_session;
		this.president = president;
		this.conference = conference;
		conference.ajouterSession(this);
	}
	

}
