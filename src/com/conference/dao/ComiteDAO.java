package com.conference.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;

import com.conference.business.IComite;
import com.conference.business.IPapier;
import com.conference.business.IPresident;
import com.conference.business.IProfesseur;
import com.conference.business.ISession;
import com.conference.entities.Affectation;
import com.conference.entities.Comite;
import com.conference.entities.Papier;
import com.conference.entities.President;
import com.conference.entities.Professeur;
import com.conference.entities.Session;

public class ComiteDAO implements IComite{

private Connection connection;

	public ComiteDAO(Connection connection) {
		this.connection = connection;
	}
		
	@Override
	public Comite find(int id) {
		ISession sessionBusiness = new SessionDAO(connection);
		IProfesseur professeurBusiness = new ProfesseurDAO(connection);
		
		if( connection != null ) {
			PreparedStatement st;
			try {
				st = connection.prepareStatement("select * from Comite where id=?");
				st.setInt(1, id);
				ResultSet rs = st.executeQuery();
				if( rs.next() ) {
					Session session = sessionBusiness.find(rs.getInt(2));
					Professeur professeur = professeurBusiness.find(rs.getInt(3));
					return new Comite(rs.getInt(1), professeur.getProfesseur_id(), professeur.getMetier(), professeur.getUser_id(), professeur.getUsername(), professeur.getNom(), professeur.getPrenom(), professeur.getEmail(), professeur.getPassword(), professeur.getTelephone(), professeur.getImage(), session);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	@Override
	public Collection<Comite> findBySessionId(int session_id) {
		IProfesseur professeurBusiness = new ProfesseurDAO(connection);
		ISession sessionBusiness = new SessionDAO(connection);
		PreparedStatement st;
		Collection<Comite> comites = new ArrayList<>();
		
		try {
			st = connection.prepareStatement("select *from Comite where session_id=? order by id desc");
			st.setInt(1, session_id);
			ResultSet rs = st.executeQuery();
			while( rs.next() ) {
				Session session = sessionBusiness.find(rs.getInt(2));
				Professeur professeur = professeurBusiness.find(rs.getInt(3));
				Comite comite = new Comite(rs.getInt(1), professeur.getProfesseur_id(), professeur.getMetier(), professeur.getUser_id(), professeur.getUsername(), professeur.getNom(), professeur.getPrenom(), professeur.getEmail(), professeur.getPassword(), professeur.getTelephone(), professeur.getImage(), session);
				comites.add(comite);
			}
			return comites;
		} 
		catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Comite add(Comite comite) {
		Comite returned_comite = null;
		if( connection != null ) {
			PreparedStatement st;
			try {
				st = connection.prepareStatement("insert into Comite values(NULL,?, ?)", Statement.RETURN_GENERATED_KEYS);
				st.setInt(1, comite.getSession().getId());
				st.setInt(2, comite.getProfesseur_id());
				if( st.executeUpdate() != -1 ) {
					System.out.println("Comite ajoutée avec succé");
					ResultSet rs = st.getGeneratedKeys();
					if( rs.next() )
						returned_comite = this.find(rs.getInt(1));
				}else
					System.err.println("Une erreure est survenue, votre affectation n'est pas ajoutée!");
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return returned_comite;
	}
	

	@Override
	public boolean update(Comite comite) {
		PreparedStatement st;
		try {
			st = connection.prepareStatement("update Comite set session_id=?, professeur_id=? where id=?");
			st.setInt(1, comite.getSession().getId());
			st.setInt(2, comite.getProfesseur_id());
			st.setInt(3, comite.getComite_id());
			if( !st.execute() ) 
				return true;
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean delete(int id) {
		PreparedStatement st;
		try {
			st = connection.prepareStatement("delete from Comite where id=?");
			st.setInt(1, id);
			if( !st.execute() )
				return true;
				
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@Override
	public boolean deleteBySessionId(int sessionid) {
		PreparedStatement st;
		try {
			st = connection.prepareStatement("delete from Comite where session_id=?");
			st.setInt(1, sessionid);
			if( !st.execute() )
				return true;
				
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public Collection<Comite> findAll() {
		IProfesseur professeurBusiness = new ProfesseurDAO(connection);
		ISession sessionBusiness = new SessionDAO(connection);
		Statement st;
		Collection<Comite> comites = new ArrayList<>();
		Collection<Integer> professeurs_ids = new ArrayList<Integer>();
		try {
			st = connection.createStatement();
			ResultSet rs = st.executeQuery("select *from Comite order by id desc");
			while( rs.next() ) {
				Session session = sessionBusiness.find(rs.getInt(2));
				Professeur professeur = professeurBusiness.find(rs.getInt(3));
				Comite comite = new Comite(rs.getInt(1), professeur.getProfesseur_id(), professeur.getMetier(), professeur.getUser_id(), professeur.getUsername(), professeur.getNom(), professeur.getPrenom(), professeur.getEmail(), professeur.getPassword(), professeur.getTelephone(), professeur.getImage(), session);
				comites.add(comite);
			}
			return comites;
		} 
		catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	

}
