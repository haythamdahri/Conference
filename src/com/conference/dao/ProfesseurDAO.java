package com.conference.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;

import com.conference.business.IAdministrateur;
import com.conference.business.IComite;
import com.conference.business.IConference;
import com.conference.business.IPapier;
import com.conference.business.IPresident;
import com.conference.business.IProfesseur;
import com.conference.business.IUser;
import com.conference.entities.Comite;
import com.conference.entities.Conference;
import com.conference.entities.Papier;
import com.conference.entities.President;
import com.conference.entities.Professeur;
import com.conference.entities.Session;
import com.conference.entities.User;

public class ProfesseurDAO implements IProfesseur{

private Connection connection;

		public ProfesseurDAO(Connection connection) {
			this.connection = connection;
		}

		@Override
		public Professeur find(int id) {
			IUser userBusiness = new UserDAO(connection);
			
			if( connection != null ) {
				PreparedStatement st;
				try {
					st = connection.prepareStatement("select * from Professeur where id=?");
					st.setInt(1, id);
					ResultSet rs = st.executeQuery();
					if( rs.next() ) {
						User user = userBusiness.find(rs.getInt(2));
						return new Professeur(rs.getInt(1),rs.getString(3), user.getUser_id(), user.getUsername(), user.getNom(), user.getPrenom(), user.getEmail(), user.getPassword(), user.getTelephone(), user.getImage());
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			return null;
		}
		
		@Override
		public Professeur findByUserId(int user_id) {
			IUser userBusiness = new UserDAO(connection);
			
			if( connection != null ) {
				PreparedStatement st;
				try {
					st = connection.prepareStatement("select * from Professeur where user_id=?");
					st.setInt(1, user_id);
					ResultSet rs = st.executeQuery();
					if( rs.next() ) {
						User user = userBusiness.find(rs.getInt(2));
						return new Professeur(rs.getInt(1),rs.getString(3), user.getUser_id(), user.getUsername(), user.getNom(), user.getPrenom(), user.getEmail(), user.getPassword(), user.getTelephone(), user.getImage());
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			return null;
		}


		@Override
		public Professeur add(Professeur professeur) {
			IUser userBusiness = new UserDAO(connection);
			Professeur returned_professeur = null;
			if( connection != null ) {
				PreparedStatement st;
				try {
					st = connection.prepareStatement("insert into Professeur values(NULL,?, ?)", Statement.RETURN_GENERATED_KEYS);
					st.setInt(1, professeur.getUser_id());
					st.setString(2, professeur.getMetier());
					if( st.executeUpdate() != -1 ) {
						System.out.println("Professeur ajouté avec succé");
						ResultSet rs = st.getGeneratedKeys();
						if( rs.next() )
							returned_professeur = this.find(rs.getInt(1));
					}else
						System.err.println("Une erreure est survenue, votre tutoriel n'est pas ajouté!");
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return returned_professeur;
		}
		

		@Override
		public boolean update(Professeur professeur) {
			PreparedStatement st;
			try {
				st = connection.prepareStatement("update Professeur set user_id=? where id=?");
				st.setInt(1, professeur.getUser_id());
				
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
				st = connection.prepareStatement("delete from Professeur where id=?");
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
		public Collection<Professeur> findAll() {
			IUser userBusiness = new UserDAO(connection);
			Statement st;
			Collection<Professeur> professeurs = new ArrayList<>();
			try {
				st = connection.createStatement();
				ResultSet rs = st.executeQuery("select *from Professeur order by id desc");
				while( rs.next() ) {
					User user = userBusiness.find(rs.getInt(2));
					Professeur professeur = new Professeur(rs.getInt(1),rs.getString(3), user.getUser_id(), user.getUsername(), user.getNom(), user.getPrenom(), user.getEmail(), user.getPassword(), user.getTelephone(), user.getImage());
					professeurs.add(professeur);
				}
				return professeurs;
			} 
			catch(SQLException e) {
				e.printStackTrace();
			}
			return null;
		}

}
