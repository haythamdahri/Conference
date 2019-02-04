package com.conference.business;

import java.util.Collection;

import com.conference.entities.Comite;

public interface IComite {
	
	public Comite find(int id);
	public Collection<Comite> findBySessionId(int sessionid);
	public Comite add(Comite comite);
	public boolean update(Comite comite);
	public boolean delete(int id);
	public boolean deleteBySessionId(int sessionid);
	public Collection<Comite> findAll();

}
