package com.conference.business;

import java.util.Collection;

import com.conference.entities.Inscription;

public interface IInscription {

	public Inscription find(int id);
	public Inscription findByUserId(int user_id);
	public Inscription findBySessionId(int session_id);
	public Inscription add(Inscription conference);
	public boolean update(Inscription conference);
	public boolean delete(int id);
	public Collection<Inscription> findAll();
	
}
