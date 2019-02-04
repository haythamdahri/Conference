package com.conference.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;

import com.conference.business.IAdministrateur;
import com.conference.business.IProfesseur;
import com.conference.business.IUser;
import com.conference.entities.Administrateur;
import com.conference.entities.Professeur;
import com.conference.entities.User;

public class AdministrateurDAO implements IAdministrateur{

	private Connection connection;

	public AdministrateurDAO(Connection connection) {
		this.connection = connection;
	}

	@Override
	public Administrateur find(int id) {
		IUser userBusiness = new UserDAO(this.connection);
		IProfesseur professeurBusiness = new ProfesseurDAO(this.connection);
		if( connection != null ) {
			PreparedStatement st;
			try {
				st = connection.prepareStatement("select * from Administrateur where id=?");
				st.setInt(1, id);
				ResultSet rs = st.executeQuery();
				if( rs.next() ) {
					Professeur professeur = professeurBusiness.find(rs.getInt(2));
					return new Administrateur(rs.getInt(1), professeur.getProfesseur_id(), professeur.getMetier(), professeur.getUser_id(), professeur.getUsername(), professeur.getNom(), professeur.getPrenom(), professeur.getEmail(), professeur.getPassword(), professeur.getTelephone(), professeur.getImage());
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	@Override
	public Administrateur findByProfesseurId(int professeur_id) {
		IUser userBusiness = new UserDAO(this.connection);
		IProfesseur professeurBusiness = new ProfesseurDAO(this.connection);
		if( connection != null ) {
			PreparedStatement st;
			try {
				st = connection.prepareStatement("select * from Administrateur where professeur_id=?");
				st.setInt(1, professeur_id);
				ResultSet rs = st.executeQuery();
				if( rs.next() ) {
					Professeur professeur = professeurBusiness.find(rs.getInt(2));
					return new Administrateur(rs.getInt(1), professeur.getProfesseur_id(), professeur.getMetier(), professeur.getUser_id(), professeur.getUsername(), professeur.getNom(), professeur.getPrenom(), professeur.getEmail(), professeur.getPassword(), professeur.getTelephone(), professeur.getImage());
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	@Override
	public Administrateur add(Administrateur administrateur) {
		IUser userBusiness = new UserDAO(connection);
		Administrateur returned_administrateur = null;
		if( connection != null ) {
			PreparedStatement st;
			try {
				st = connection.prepareStatement("insert into Administrateur values(NULL,?)", Statement.RETURN_GENERATED_KEYS);
				st.setInt(1, administrateur.getProfesseur_id());
				if( st.executeUpdate() != -1 ) {
					ResultSet rs = st.getGeneratedKeys();
					if( rs.next() )
						returned_administrateur = this.find(rs.getInt(1));
				}else
					System.err.println("Une erreure est survenue, votre administrateur n'est pas ajoutée!");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return returned_administrateur;
	}
	

	@Override
	public boolean update(Administrateur administrateur) {
		PreparedStatement st;
		try {
			st = connection.prepareStatement("update User set username=?, nom=?, prenom=?, email=?, password=?, telephone=?, image=? where id=?", com.mysql.jdbc.Statement.RETURN_GENERATED_KEYS);;
			st.setString(1, administrateur.getUsername());
			st.setString(2, administrateur.getNom());
			st.setString(3, administrateur.getPrenom());
			st.setString(4, administrateur.getEmail() );
			st.setString(5, administrateur.getPassword());
			st.setString(6, administrateur.getTelephone());
			st.setString(7, administrateur.getImage());
			st.setInt(8, administrateur.getUser_id());
			if( !st.execute() ) {
				ResultSet rs = st.getGeneratedKeys();
				if( rs.next() )
					st = connection.prepareStatement("update Professeur set metier=? where id=?");
					st.setString(1, administrateur.getMetier());
					st.setInt(2, administrateur.getProfesseur_id());
					if( !st.execute() )
						return true;
			}
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
			st = connection.prepareStatement("delete from Administrateur where id=?");
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
	public Collection<Administrateur> findAll() {
		IUser userBusiness = new UserDAO(this.connection);
		IProfesseur professeurBusiness = new ProfesseurDAO(this.connection);
		Statement st;
		Collection<Administrateur> administrateurs = new ArrayList<Administrateur>();
		try {
			st = connection.createStatement();
			ResultSet rs = st.executeQuery("select *from Administrateur order by id desc");
			while( rs.next() ) {
				Professeur professeur = professeurBusiness.find(rs.getInt(2));
				administrateurs.add(new Administrateur(rs.getInt(1), professeur.getProfesseur_id(), professeur.getMetier(), professeur.getUser_id(), professeur.getUsername(), professeur.getNom(), professeur.getPrenom(), professeur.getEmail(), professeur.getPassword(), professeur.getTelephone(), professeur.getImage()));
			}
			return administrateurs;
		} 
		catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
