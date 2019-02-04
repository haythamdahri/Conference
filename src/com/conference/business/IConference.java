package com.conference.business;

import java.util.Collection;

import com.conference.entities.Conference;;

public interface IConference {
	
	public Conference find(int id);
	public Collection<Conference> findByAdministrateur(int administrateur_id);
	public Collection<Conference> findByProfesseur(int professeur_id);
	public Conference add(Conference conference);
	public boolean update(Conference conference);
	public boolean delete(int id);
	public Collection<Conference> findAll();
	
}
