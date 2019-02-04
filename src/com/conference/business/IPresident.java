package com.conference.business;

import java.util.Collection;

import com.conference.entities.President;
import com.conference.entities.Session;

public interface IPresident {

	public President find(int id);
	public President findByProfesseurId(int professeur_id);
	public President add(President president);
	public boolean update(President president);
	public boolean delete(int id);
	public Collection<President> findAll();
	
}
