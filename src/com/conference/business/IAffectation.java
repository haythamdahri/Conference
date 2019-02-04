package com.conference.business;

import java.util.Collection;
import com.conference.entities.Affectation;

public interface IAffectation {

		public Affectation find(int id);
		public Affectation add(Affectation affectation);
		public boolean update(Affectation affectation);
		public boolean delete(int id);
		public Collection<Affectation> findAll();

}
