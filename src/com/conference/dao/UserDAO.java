package com.conference.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;

import com.conference.business.IConference;
import com.conference.business.IUser;
import com.conference.entities.Administrateur;
import com.conference.entities.User;

public class UserDAO implements IUser {
	

private Connection connection;

	
	public UserDAO(Connection connection) {
		this.connection = connection;
	}

	@Override
	public User find(int id) {
		if( connection != null ) {
			PreparedStatement st;
			try {
				st = connection.prepareStatement("select * from User where id=?");
				st.setInt(1, id);
				ResultSet rs = st.executeQuery();
				if( rs.next() ) {
					return new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8));
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}

	@Override
	public User find(String email, String password) {
		if( connection != null ) {
			PreparedStatement st;
			try {
				st = connection.prepareStatement("select * from User where email=? and password=?");
				st.setString(1, email);
				st.setString(2, password);
				ResultSet rs = st.executeQuery();
				if( rs.next() ) {
					return new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8));
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	
	@Override
	public User add(User user) {
		User returned_user = null;
		if( connection != null ) {
			PreparedStatement st;
			try {
				st = connection.prepareStatement("insert into User values(NULL,?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
				st.setString(1, user.getUsername());
				st.setString(2, user.getNom());
				st.setString(3, user.getPrenom());
				st.setString(4, user.getEmail());
				st.setString(5, user.getPassword());
				st.setString(6, user.getTelephone());
				st.setString(7, user.getImage());
				if( st.executeUpdate() != -1 ) {
					System.out.println("User ajouté avec succé");
					ResultSet rs = st.getGeneratedKeys();
					if( rs.next() )
						returned_user = this.find(rs.getInt(1));
				}else
					System.err.println("Une erreure est survenue, votre user n'est pas ajoutée!");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return returned_user;
	}
	

	@Override
	public boolean update(User user) {
		PreparedStatement st;
		try {
			st = connection.prepareStatement("update User set username=?, nom=?, prenom=?, email=?, password=?, telephone=?, image=? where id=?");
			st.setString(1, user.getUsername());
			st.setString(2, user.getNom());
			st.setString(3, user.getPrenom());
			st.setString(4, user.getEmail() );
			st.setString(5, user.getPassword());
			st.setString(6, user.getTelephone());
			st.setString(7, user.getImage());
			st.setInt(8, user.getUser_id());
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
			st = connection.prepareStatement("delete from User where id=?");
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
	public Collection<User> findAll() {
		Statement st;
		Collection<User> users = new ArrayList<>();
		try {
			st = connection.createStatement();
			ResultSet rs = st.executeQuery("select *from User order by id desc");
			while( rs.next() )
				users.add(new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8)));
			return users;
		} 
		catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
