package com.conference.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;

import com.conference.business.IConference;
import com.conference.business.ITutoriel;
import com.conference.business.IUser;
import com.conference.entities.Conference;
import com.conference.entities.Tutoriel;

public class TutorielDAO implements ITutoriel {
	
private Connection connection;
	
	public TutorielDAO(Connection connection) {
		this.connection = connection;
	}

	@Override
	public Tutoriel find(int id) {
		IConference conferenceBusiness = new ConferenceDAO(connection);
		if( connection != null ) {
			PreparedStatement st;
			try {
				st = connection.prepareStatement("select * from Tutoriel where id=?");
				st.setInt(1, id);
				ResultSet rs = st.executeQuery();
				if( rs.next() ) {
					Conference conference = conferenceBusiness.find(rs.getInt(4));
					return new Tutoriel(rs.getInt(1), rs.getString(2), rs.getString(3), conference);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	
	@Override
	public Collection<Tutoriel> findByConferenceId(int conference_id) {
		IConference conferenceBusiness = new ConferenceDAO(this.connection);
		PreparedStatement st;
		Collection<Tutoriel> tutos = new ArrayList<>();
		try {
			st = connection.prepareStatement("select *from Tutoriel where conference_id=? order by id desc");
			st.setInt(1, conference_id);
			ResultSet rs = st.executeQuery("select *from Tutoriel");
			while( rs.next() ) {
				tutos.add(new Tutoriel(rs.getInt(1), rs.getString(2), rs.getString(3), conferenceBusiness.find(rs.getInt(4))));
			}
			return tutos;
		} 
		catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Tutoriel add(Tutoriel tutoriel) {
		IConference conferenceBusiness = new ConferenceDAO(connection);
		Tutoriel returned_tutoriel = null;
		if( connection != null ) {
			PreparedStatement st;
			try {
				st = connection.prepareStatement("insert into Tutoriel values(NULL,?,?,?)", Statement.RETURN_GENERATED_KEYS);
				st.setString(1, tutoriel.getTitre());
				st.setString(2, tutoriel.getDescription());
				st.setInt(3, tutoriel.getConference().getId());
				
				if( st.executeUpdate() != -1 ) {
					System.out.println("Tutoriel ajouté avec succé");
					ResultSet rs = st.getGeneratedKeys();
					if( rs.next() )
						returned_tutoriel = this.find(rs.getInt(1));
				}else
					System.err.println("Une erreure est survenue, votre tutoriel n'est pas ajouté!");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return returned_tutoriel;
	}
	

	@Override
	public boolean update(Tutoriel tutoriel) {
		PreparedStatement st;
		try {
			st = connection.prepareStatement("update Tutoriel set titre=?, description=?, conference_id=? where id=?");
			st.setString(1, tutoriel.getTitre());
			st.setString(2, tutoriel.getDescription());
			st.setInt(3, tutoriel.getConference().getId());
			st.setInt(4, tutoriel.getId());
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
			st = connection.prepareStatement("delete from Tutoriel where id=?");
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
	public Collection<Tutoriel> findAll() {
		IConference conferenceBusiness = new ConferenceDAO(this.connection);
		Statement st;
		Collection<Tutoriel> tutos = new ArrayList<>();
		try {
			st = connection.createStatement();
			ResultSet rs = st.executeQuery("select *from Tutoriel order by id desc");
			while( rs.next() ) {
				tutos.add(new Tutoriel(rs.getInt(1), rs.getString(2), rs.getString(3), conferenceBusiness.find(rs.getInt(4))));
			}
			return tutos;
		} 
		catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	

}
