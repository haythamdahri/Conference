package com.conference.business;

import java.util.Collection;

import com.conference.entities.Papier;
import com.conference.entities.Session;

public interface IPapier {

	public Papier find(int id);
	public Collection<Papier> findBySessionId(int sessionid);
	public Collection<Papier> findByUserId(int userid);
	public Papier add(Papier papier);
	public boolean update(Papier papier);
	public boolean delete(int id);
	public Collection<Papier> findAll();
	
}
