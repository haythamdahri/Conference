package com.conference.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;

import com.conference.business.IAffectation;
import com.conference.business.IComite;
import com.conference.business.IPapier;
import com.conference.business.IPresident;
import com.conference.entities.Affectation;
import com.conference.entities.Comite;
import com.conference.entities.Conference;
import com.conference.entities.Papier;
import com.conference.entities.President;

public class AffectationDAO implements  IAffectation{

private Connection connection;

	public AffectationDAO(Connection connection) {
		this.connection = connection;
	}
		
	@Override
	public Affectation find(int id) {
		IComite comiteBusiness = new ComiteDAO(connection);
		IPapier papierBusiness = new PapierDAO(connection);
		
		if( connection != null ) {
			PreparedStatement st;
			try {
				st = connection.prepareStatement("select * from AffectationPapier where id=?");
				st.setInt(1, id);
				ResultSet rs = st.executeQuery();
				if( rs.next() ) {
					Comite comite = comiteBusiness.find(rs.getInt(2));
					Papier papier = papierBusiness.find(rs.getInt(3));
					return new Affectation(rs.getInt(1), comite, papier);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	@Override
	public Affectation add(Affectation affectation) {
		Affectation returned_affectation = null;
		if( connection != null ) {
			PreparedStatement st;
			try {
				st = connection.prepareStatement("insert into AffectationPapier values(NULL,?,?)", Statement.RETURN_GENERATED_KEYS);
				st.setInt(1, affectation.getComite().getComite_id());
				st.setInt(2, affectation.getPapier().getId());
				if( st.executeUpdate() != -1 ) {
					System.out.println("Affectation ajoutée avec succé");
					ResultSet rs = st.getGeneratedKeys();
					if( rs.next() )
						returned_affectation = this.find(rs.getInt(1));
				}else
					System.err.println("Une erreure est survenue, votre affectation n'est pas ajoutée!");
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return returned_affectation;
	}
	

	@Override
	public boolean update(Affectation affectation) {
		PreparedStatement st;
		try {
			st = connection.prepareStatement("update AffectationPapier set comite_id=?, papier_id=? where id=?");
			st.setInt(1, affectation.getComite().getComite_id());
			st.setInt(2, affectation.getPapier().getId());
			st.setInt(3, affectation.getId());
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
			st = connection.prepareStatement("delete from AffectationPapier where id=?");
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
	public Collection<Affectation> findAll() {
		IComite comiteBusiness = new ComiteDAO(connection);
		IPapier papierBusiness = new PapierDAO(connection);
		Statement st;
		Collection<Affectation> affectations = new ArrayList<>();
		
		try {
			st = connection.createStatement();
			ResultSet rs = st.executeQuery("select *from AffectationPapier order by id desc");
			while( rs.next() ) {
				Comite comite = comiteBusiness.find(rs.getInt(2));
				Papier papier = papierBusiness.find(rs.getInt(3));
				Affectation affectation = new Affectation(rs.getInt(1), comite, papier);
				affectations.add(affectation);
			}
			return affectations;
		} 
		catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

}
