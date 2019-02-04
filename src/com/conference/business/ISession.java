package com.conference.business;

import java.util.Collection;

import com.conference.entities.Conference;
import com.conference.entities.Session;

public interface ISession {

	public Session find(int id);
	public Collection<Session> findByPresidentId(int president_id);
	public Collection<Session> findByProfessorId(int professor_id);
	public Collection<Session> findByConferenceId(int session_id);
	public Session add(Session session);
	public boolean update(Session session);
	public boolean delete(int id);
	public Collection<Session> findAll();
	
}
