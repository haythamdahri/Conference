package com.conference.business;

import java.util.Collection;

import com.conference.entities.Conference;
import com.conference.entities.Tutoriel;

public interface ITutoriel {

	public Tutoriel find(int id);
	public Collection<Tutoriel> findByConferenceId(int conference_id);
	public Tutoriel add(Tutoriel tutoriel);
	public boolean update(Tutoriel tutoriel);
	public boolean delete(int id);
	public Collection<Tutoriel> findAll();
	
}
