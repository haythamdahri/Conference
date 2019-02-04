package com.conference.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.conference.business.IComite;
import com.conference.business.IConference;
import com.conference.business.IPapier;
import com.conference.business.IPresident;
import com.conference.business.IProfesseur;
import com.conference.business.ISession;
import com.conference.entities.Comite;
import com.conference.entities.Conference;
import com.conference.entities.Papier;
import com.conference.entities.President;
import com.conference.entities.Professeur;
import com.conference.entities.Session;

public class PresidentDAO implements IPresident{

private Connection connection;
	
		public PresidentDAO(Connection connection) {
			this.connection = connection;
		}

		@Override
		public President find(int id) {	
		    IConference conferenceBusiness = new ConferenceDAO(connection);
		    IPresident presidentBusiness = new PresidentDAO(connection);
		    IComite comiteBusiness = new ComiteDAO(connection);
		    ISession sessionBusiness = new SessionDAO(connection);
		    IProfesseur professeurBusiness = new ProfesseurDAO(connection);
			if( connection != null ) {
				PreparedStatement st;
				try {
					st = connection.prepareStatement("select * from President where id=?");
					st.setInt(1, id);
					ResultSet rs = st.executeQuery();
					if( rs.next() ) {
						Professeur professeur = professeurBusiness.find(rs.getInt(2));
						return new President(rs.getInt(1), professeur.getProfesseur_id(), professeur.getMetier(), professeur.getUser_id(), professeur.getUsername(), professeur.getNom(), professeur.getPrenom(), professeur.getEmail(), professeur.getPassword(), professeur.getTelephone(), professeur.getImage());
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			return null;
		}
		
		@Override
		public President findByProfesseurId(int professeur_id) {	
		    IConference conferenceBusiness = new ConferenceDAO(connection);
		    IPresident presidentBusiness = new PresidentDAO(connection);
		    IComite comiteBusiness = new ComiteDAO(connection);
		    ISession sessionBusiness = new SessionDAO(connection);
		    IProfesseur professeurBusiness = new ProfesseurDAO(connection);
			if( connection != null ) {
				PreparedStatement st;
				try {
					st = connection.prepareStatement("select * from President where professeur_id=?");
					st.setInt(1, professeur_id);
					ResultSet rs = st.executeQuery();
					if( rs.next() ) {
						Professeur professeur = professeurBusiness.find(rs.getInt(2));
						return new President(rs.getInt(1), professeur.getProfesseur_id(), professeur.getMetier(), professeur.getUser_id(), professeur.getUsername(), professeur.getNom(), professeur.getPrenom(), professeur.getEmail(), professeur.getPassword(), professeur.getTelephone(), professeur.getImage());
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			return null;
		}
		

		@Override
		public President add(President president) {
			President returned_president = null;
			if( connection != null ) {
				PreparedStatement st;
				try {
					st = connection.prepareStatement("insert into President values(NULL,?)", Statement.RETURN_GENERATED_KEYS);
					st.setInt(1, president.getProfesseur_id());
					
					if( st.executeUpdate() != -1 ) {
						System.out.println("President ajouté avec succé");
						ResultSet rs = st.getGeneratedKeys();
						if( rs.next() )
							returned_president = this.find(rs.getInt(1));
					}else
						System.err.println("Une erreure est survenue, votre president n'est pas ajouté!");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			return returned_president;
		}
		

		@Override
		public boolean update(President president) {
			PreparedStatement st;
			try {
				st = connection.prepareStatement("update President set professeur_id=? where id=?");
				st.setInt(1, president.getProfesseur_id());
				st.setInt(8, president.getPresident_id());
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
				st = connection.prepareStatement("delete from President where id=?");
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
		public Collection<President> findAll() {
		    IProfesseur professeurBusiness = new ProfesseurDAO(connection);
		    List<President> presidents = new ArrayList<President>();
			if( connection != null ) {
				Statement st;
				try {
					st = connection.createStatement();
					ResultSet rs = st.executeQuery("select *from President order by id desc");
					while( rs.next() ) {
						Professeur professeur = professeurBusiness.find(rs.getInt(2));
						presidents.add(new President(rs.getInt(1), professeur.getProfesseur_id(), professeur.getMetier(), professeur.getUser_id(), professeur.getUsername(), professeur.getNom(), professeur.getPrenom(), professeur.getEmail(), professeur.getPassword(), professeur.getTelephone(), professeur.getImage()));
					}
					return presidents;
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			return null;
		}

}
