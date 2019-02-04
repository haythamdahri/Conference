package com.conference.business;

import java.util.Collection;

import com.conference.entities.Professeur;

public interface IProfesseur {

	public Professeur find(int id);
	public Professeur findByUserId(int user_id);
	public Professeur add(Professeur professeur);
	public boolean update(Professeur professeur);
	public boolean delete(int id);
	public Collection<Professeur> findAll();
	
}
