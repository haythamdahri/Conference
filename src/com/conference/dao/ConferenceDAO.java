package com.conference.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.conference.business.IAdministrateur;
import com.conference.business.IConference;
import com.conference.business.ISession;
import com.conference.business.ITutoriel;
import com.conference.dao.ConfigDB;
import com.conference.entities.Conference;
import com.conference.entities.Session;
import com.conference.entities.Tutoriel;

public class ConferenceDAO implements IConference {

private Connection connection;

	public ConferenceDAO(Connection connection) {
		this.connection = connection;
	}

	@Override
	public Conference find(int id) {
		IAdministrateur administrateurBusiness = new AdministrateurDAO(this.connection);
		
		if( connection != null ) {
			PreparedStatement st;
			try {
				st = connection.prepareStatement("select * from Conference where id=?");
				st.setInt(1, id);
				ResultSet rs = st.executeQuery();
				if( rs.next() ) {
					Conference conference = new Conference(rs.getInt(1), administrateurBusiness.find(rs.getInt(2)), rs.getString(3), rs.getString(4), rs.getTimestamp(5), rs.getTimestamp(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getTimestamp(10), rs.getString(11));
					return conference;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	@Override
	public Collection<Conference> findByAdministrateur(int administrateur_id) {
		AdministrateurDAO administrateurBusiness = new AdministrateurDAO(this.connection);
		PreparedStatement st;
		Collection<Conference> conferences = new ArrayList<>();
		
		try {
			st = connection.prepareStatement("select *from Conference where administrateur_id=?");
			st.setInt(1, administrateur_id);
			ResultSet rs = st.executeQuery();
			while( rs.next() ) {
				Conference conference = new Conference(rs.getInt(1), administrateurBusiness.find(rs.getInt(2)), rs.getString(3), rs.getString(4), rs.getTimestamp(5), rs.getTimestamp(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getTimestamp(10), rs.getString(11));
				conferences.add(conference);
			}
			return conferences;
		} 
		catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@Override
	public Collection<Conference> findByProfesseur(int professeur_id) {
		AdministrateurDAO administrateurBusiness = new AdministrateurDAO(this.connection);
		PreparedStatement st;
		Collection<Conference> conferences = new ArrayList<>();
		
		try {
			st = connection.prepareStatement("select *from Conference as conf inner join session as ses on ses.conference_id=conf.id where ses.president=?");
			st.setInt(1, professeur_id);
			ResultSet rs = st.executeQuery();
			while( rs.next() ) {
				Conference conference = new Conference(rs.getInt(1), administrateurBusiness.find(rs.getInt(2)), rs.getString(3), rs.getString(4), rs.getTimestamp(5), rs.getTimestamp(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getTimestamp(10), rs.getString(11));
				conferences.add(conference);
			}
			return conferences;
		} 
		catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Conference add(Conference conference) {
		Conference returned_conference = null;
		if( connection != null ) {
			PreparedStatement st;
			try {
				st = connection.prepareStatement("insert into Conference values(NULL,?,?,?,?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
				st.setInt(1, conference.getAdministrateur().getAdmin_id());
				st.setString(2, conference.getTitre());
				st.setString(3, conference.getDescription());
				Timestamp dt1 = new Timestamp(conference.getDate_start_soumis().getTime());
				Timestamp dt2 = new Timestamp(conference.getDate_end_soumis().getTime());
				st.setTimestamp(4, dt1);
				st.setTimestamp(5, dt2);
				st.setString(6, conference.getConverture());
				st.setString(7, conference.getAdresse());
				st.setString(8, conference.getTelephone());
				Timestamp dt3 = new Timestamp(conference.getDate().getTime());
				st.setTimestamp(9, dt3); 
				st.setString(10, conference.getEmail());
				
				if( st.executeUpdate() != -1 ) {
					System.out.println("Conference ajoutée avec succé");
					ResultSet rs = st.getGeneratedKeys();
					if( rs.next() ) {
						returned_conference = this.find(rs.getInt(1));
						return returned_conference;
					}
				}else
					System.err.println("Une erreure est survenue, votre conference n'est pas ajoutée!");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return returned_conference;
	}
	

	@Override
	public boolean update(Conference conference) {
		PreparedStatement st;
		try {
			st = connection.prepareStatement("update Conference set titre=?, description=?, date_start_soumis=?, date_end_soumis=?, couverture=?, adresse=?, telephone=?, date=?, email=? where id=?");
			st.setString(1, conference.getTitre());
			st.setString(2, conference.getDescription());
			Timestamp dt1 = new Timestamp(conference.getDate_start_soumis().getTime());
			Timestamp dt2 = new Timestamp(conference.getDate_end_soumis().getTime());
			st.setTimestamp(3, dt1);
			st.setTimestamp(4, dt2);
			st.setString(5, conference.getConverture());
			st.setString(6, conference.getAdresse());
			st.setString(7, conference.getTelephone());
			Timestamp dt3 = new Timestamp(conference.getDate().getTime());
			st.setTimestamp(8, dt3); 
			st.setString(9, conference.getEmail());
			st.setInt(10, conference.getId());
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
			st = connection.prepareStatement("delete from Conference where id=?");
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
	public Collection<Conference> findAll() {
		AdministrateurDAO administrateurBusiness = new AdministrateurDAO(this.connection);
		Statement st;
		Collection<Conference> conferences = new ArrayList<>();
		
		try {
			st = connection.createStatement();
			ResultSet rs = st.executeQuery("select *from Conference order by date desc");
			while( rs.next() ) {
				Conference conference = new Conference(rs.getInt(1), administrateurBusiness.find(rs.getInt(2)), rs.getString(3), rs.getString(4), rs.getTimestamp(5), rs.getTimestamp(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getTimestamp(10), rs.getString(11));
				conferences.add(conference);
			}
			return conferences;
		} 
		catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
