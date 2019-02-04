package com.conference.business;

import java.util.Collection;
import com.conference.entities.Administrateur;

public interface IAdministrateur {

	public Administrateur find(int id);
	public Administrateur findByProfesseurId(int professeur_id);
	public Administrateur add(Administrateur administrateur);
	public boolean update(Administrateur administrateur);
	public boolean delete(int id);
	public Collection<Administrateur> findAll();

}
