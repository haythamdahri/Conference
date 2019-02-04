package com.conference.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;

import com.conference.business.IConference;
import com.conference.business.IInscription;
import com.conference.business.ISession;
import com.conference.business.IUser;
import com.conference.entities.Conference;
import com.conference.entities.Inscription;
import com.conference.entities.Session;
import com.conference.entities.User;

public class InscriptionDAO implements IInscription{

	private Connection connection;

	public InscriptionDAO(Connection connection) {
		this.connection = connection;
	}

	@Override
	public Inscription find(int id) {

		IUser userBusiness = new UserDAO(connection);
		ISession sessionBusiness = new SessionDAO(connection);
		
		if( connection != null ) {
			PreparedStatement st;
			try {
				st = connection.prepareStatement("select * from Inscription where id=?");
				st.setInt(1, id);
				ResultSet rs = st.executeQuery();
				if( rs.next() ) {
					User user = userBusiness.find(rs.getInt(2));
					Session session = sessionBusiness.find(rs.getInt(3));
					Inscription inscription = new Inscription(rs.getInt(1), user, session);
					return inscription;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	

	public Inscription findByUserId(int user_id) {

		IUser userBusiness = new UserDAO(connection);
		ISession sessionBusiness = new SessionDAO(connection);
		
		if( connection != null ) {
			PreparedStatement st;
			try {
				st = connection.prepareStatement("select * from Inscription where user_id=?");
				st.setInt(1, user_id);
				ResultSet rs = st.executeQuery();
				if( rs.next() ) {
					User user = userBusiness.find(rs.getInt(2));
					Session session = sessionBusiness.find(rs.getInt(3));
					Inscription inscription = new Inscription(rs.getInt(1), user, session);
					return inscription;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
		
	}
	
	public Inscription findBySessionId(int session_id) {

		IUser userBusiness = new UserDAO(connection);
		ISession sessionBusiness = new SessionDAO(connection);
		
		if( connection != null ) {
			PreparedStatement st;
			try {
				st = connection.prepareStatement("select * from Inscription where session_id=?");
				st.setInt(1, session_id);
				ResultSet rs = st.executeQuery();
				if( rs.next() ) {
					User user = userBusiness.find(rs.getInt(2));
					Session session = sessionBusiness.find(rs.getInt(3));
					Inscription inscription = new Inscription(rs.getInt(1), user, session);
					return inscription;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
		
	}

	@Override
	public Inscription add(Inscription inscription) {
		Inscription returned_inscription = null;
		if( connection != null ) {
			PreparedStatement st;
			try {
				st = connection.prepareStatement("insert into Inscription values(NULL,?,?)", Statement.RETURN_GENERATED_KEYS);
				st.setInt(1, inscription.getUser().getUser_id());
				st.setInt(2, inscription.getSession().getId());
				if( st.executeUpdate() != -1 ) {
					System.out.println("Inscription ajoutée avec succé");
					ResultSet rs = st.getGeneratedKeys();
					if( rs.next() ) 
						return this.find(rs.getInt(1));
				}else
					System.err.println("Une erreure est survenue, votre conference n'est pas ajoutée!");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return returned_inscription;
	}
	

	@Override
	public boolean update(Inscription inscription) {
		PreparedStatement st;
		try {
			st = connection.prepareStatement("update Inscription set user_id=?, conference_id=? where id=?");
			st.setInt(1, inscription.getUser().getUser_id());
			st.setInt(2, inscription.getSession().getId());
			st.setInt(3, inscription.getInscription_id());
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
			st = connection.prepareStatement("delete from Inscription where id=?");
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
	public Collection<Inscription> findAll() {
		IUser userBusiness = new UserDAO(connection);
		ISession sessionBusiness = new SessionDAO(connection);
		Statement st;
		Collection<Inscription> inscriptions = new ArrayList<>();
		
		try {
			st = connection.createStatement();
			ResultSet rs = st.executeQuery("select *from Inscription order by id desc");
			while( rs.next() ) {
				User user = userBusiness.find(rs.getInt(2));
				Session session = sessionBusiness.find(rs.getInt(3));
				Inscription inscription = new Inscription(rs.getInt(1), user, session);
				inscriptions.add(inscription);
			}
			return inscriptions;
		} 
		catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
