package com.conference.business;

import java.util.Collection;

import com.conference.entities.User;

public interface IUser {

	public User find(int id);
	public User find(String email, String password);
	public User add(User user);
	public boolean update(User user);
	public boolean delete(int id);
	public Collection<User> findAll();
	
}
