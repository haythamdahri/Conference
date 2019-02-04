package com.conference.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;

import com.conference.business.IComite;
import com.conference.business.IConference;
import com.conference.business.IPapier;
import com.conference.business.IPresident;
import com.conference.business.ISession;
import com.conference.business.IUser;
import com.conference.entities.Comite;
import com.conference.entities.Conference;
import com.conference.entities.Papier;
import com.conference.entities.President;
import com.conference.entities.Session;
import com.conference.entities.Tutoriel;
import com.conference.entities.User;

public class PapierDAO implements IPapier{

private Connection connection;	
	
		public PapierDAO(Connection connection) {
			this.connection = connection;
		}
	
	@Override
	public Papier find(int id) {
		IUser userBusiness = new UserDAO(connection);
		ISession sessionBusiness = new SessionDAO(connection);
		if( connection != null ) {
			PreparedStatement st;
			try {
				st = connection.prepareStatement("select * from Papier where id=?");
				st.setInt(1, id);
				ResultSet rs = st.executeQuery();
				if( rs.next() ) {
					User user = userBusiness.find(rs.getInt(4));
					Session session = sessionBusiness.find(rs.getInt(5));
					return new Papier(rs.getInt(1), rs.getString(2), rs.getString(3), user, session, rs.getString(6), rs.getFloat(7));
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	
	public Collection<Papier> findBySessionId(int sessionid){
		IUser userBusiness = new UserDAO(connection);
		ISession sessionBusiness = new SessionDAO(connection);
		PreparedStatement st;
		Collection<Papier> papiers = new ArrayList<>();
		try {
			st = connection.prepareStatement("select *from Papier where session_id=? order by id desc");
			st.setInt(1, sessionid);
			ResultSet rs = st.executeQuery();
			while( rs.next() ) {
				User user = userBusiness.find(rs.getInt(4));
				Session session = sessionBusiness.find(rs.getInt(5));
				Papier papier = new Papier(rs.getInt(1), rs.getString(2), rs.getString(3), user, session, rs.getString(6), rs.getFloat(7));
				papiers.add(papier);
			}
			return papiers;
		}catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
		return null;
	}
	
	public Collection<Papier> findByUserId(int userid){
		IUser userBusiness = new UserDAO(connection);
		ISession sessionBusiness = new SessionDAO(connection);
		PreparedStatement st;
		Collection<Papier> papiers = new ArrayList<>();
		try {
			st = connection.prepareStatement("select *from Papier where user_id=?");
			st.setInt(1, userid);
			ResultSet rs = st.executeQuery();
			while( rs.next() ) {
				User user = userBusiness.find(rs.getInt(4));
				Session session = sessionBusiness.find(rs.getInt(5));
				Papier papier = new Papier(rs.getInt(1), rs.getString(2), rs.getString(3), user, session, rs.getString(6), rs.getFloat(7));
				papiers.add(papier);
			}
			return papiers;
		}catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
		return null;
	}

	@Override
	public Papier add(Papier papier) {
		Papier returned_papier = null;
		if( connection != null ) {
			PreparedStatement st;
			try {
				st = connection.prepareStatement("insert into Papier values(NULL,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
				st.setString(1, papier.getTitre());
				st.setString(2, papier.getDescription());
				st.setInt(3, papier.getUser().getUser_id());
				st.setInt(4, papier.getSession().getId());
				st.setString(5, papier.getEtat());
				st.setFloat(6, papier.getNote());
				if( st.executeUpdate() != -1 ) {
					System.out.println("Papier ajouté avec succé");
					ResultSet rs = st.getGeneratedKeys();
					if( rs.next() )
						returned_papier = this.find(rs.getInt(1));
				}else
					System.err.println("Une erreure est survenue, votre tutoriel n'est pas ajouté!");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return returned_papier;
	}

	@Override
	public boolean update(Papier papier) {
		PreparedStatement st;
		try {
			st = connection.prepareStatement("update Papier set titre=?, description=?, user_id=?, session_id=?, state=?, note=? where id=?");
			st.setString(1, papier.getTitre());
			st.setString(2, papier.getDescription());
			st.setInt(3, papier.getUser().getUser_id());
			st.setInt(4, papier.getSession().getId());
			st.setString(5, papier.getEtat());
			st.setFloat(6, papier.getNote());
			st.setInt(7, papier.getId());
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
			st = connection.prepareStatement("delete from Papier where id=?");
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
	public Collection<Papier> findAll() {
		IUser userBusiness = new UserDAO(connection);
		ISession sessionBusiness = new SessionDAO(connection);
		Statement st;
		Collection<Papier> papiers = new ArrayList<>();
		try {
			st = connection.createStatement();
			ResultSet rs = st.executeQuery("select *from Papier order by id desc");
			while( rs.next() ) {
				User user = userBusiness.find(rs.getInt(4));
				Session session = sessionBusiness.find(rs.getInt(5));
				Papier papier = new Papier(rs.getInt(1), rs.getString(2), rs.getString(3), user, session, rs.getString(6), rs.getFloat(7));
				papiers.add(papier);
			}
			return papiers;
		}catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
		return null;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
