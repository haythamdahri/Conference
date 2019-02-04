package com.conference.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;

import com.conference.entities.Comite;
import com.conference.entities.Conference;
import com.conference.entities.Papier;
import com.conference.entities.President;
import com.conference.entities.Session;
import com.conference.entities.Tutoriel;
import com.conference.business.IComite;
import com.conference.business.IConference;
import com.conference.business.IPapier;
import com.conference.business.IPresident;
import com.conference.business.ISession;
import com.conference.dao.PresidentDAO;

public class SessionDAO implements ISession{

private Connection connection;
	
		public SessionDAO(Connection connection) {
			this.connection = connection;
		}
		
		@Override
		public Session find(int id) {
			IConference conferenceBusiness = new ConferenceDAO(connection);
			IPresident presidentBusiness = new PresidentDAO(connection);
			if( connection != null ) {
				PreparedStatement st;
				try {
					st = connection.prepareStatement("select * from Session where id=?");
					st.setInt(1, id);
					ResultSet rs = st.executeQuery();
					if( rs.next() ) {
						President president = presidentBusiness.find(rs.getInt(6));
						Conference conference = conferenceBusiness.find(rs.getInt(5));
						return new Session(rs.getInt(1), rs.getString(2), rs.getTimestamp(3), rs.getTimestamp(4), conference, president);
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			return null;
		}

		@Override
		public Collection<Session> findByConferenceId(int conference_id) {
			IConference conferenceBusiness = new ConferenceDAO(connection);
			IPresident presidentBusiness = new PresidentDAO(connection);
			PreparedStatement st;
			Collection<Session> sessions = new ArrayList<>();
			try {
				st = connection.prepareStatement("select *from Session where conference_id=? order by id asc");
				st.setInt(1, conference_id);
				ResultSet rs = st.executeQuery();
				while( rs.next() ) {
					President president = presidentBusiness.find(rs.getInt(6));
					Conference conference = conferenceBusiness.find(rs.getInt(5));
					Session session = new Session(rs.getInt(1), rs.getString(2), rs.getTimestamp(3), rs.getTimestamp(4), conference, president);
					sessions.add(session);
				}
				return sessions;
			} 
			catch(SQLException e) {
				e.printStackTrace();
			}
			return null;
		}
		
		@Override
		public Collection<Session> findByProfessorId(int professor_id) {
			IConference conferenceBusiness = new ConferenceDAO(connection);
			IPresident presidentBusiness = new PresidentDAO(connection);
			PreparedStatement st;
			Collection<Session> sessions = new ArrayList<>();
			try {
				st = connection.prepareStatement("select distinct s.id, s.titre, s.date_start_session, s.date_end_session, s.conference_id, s.president_id from Session as s inner join President as p on p.id=s.president_id inner join Comite as c on c.professeur_id=p.professeur_id where c.professeur_id=?");
				st.setInt(1, professor_id);
				ResultSet rs = st.executeQuery();
				while( rs.next() ) {
					President president = presidentBusiness.find(rs.getInt(6));
					Conference conference = conferenceBusiness.find(rs.getInt(5));
					Session session = new Session(rs.getInt(1), rs.getString(2), rs.getTimestamp(3), rs.getTimestamp(4), conference, president);
					sessions.add(session);
				}
				return sessions;
			} 
			catch(SQLException e) {
				e.printStackTrace();
			}
			return null;
		}
		
		@Override
		public Collection<Session> findByPresidentId(int president_id) {
			IConference conferenceBusiness = new ConferenceDAO(connection);
			IPresident presidentBusiness = new PresidentDAO(connection);
			PreparedStatement st;
			Collection<Session> sessions = new ArrayList<>();
			try {
				st = connection.prepareStatement("select distinct s.id, s.titre, s.date_start_session, s.date_end_session, s.conference_id, s.president_id from Session as s inner join President as p on p.id=s.president_id where p.professeur_id=?");
				st.setInt(1, president_id);
				ResultSet rs = st.executeQuery();
				while( rs.next() ) {
					President president = presidentBusiness.find(rs.getInt(6));
					Conference conference = conferenceBusiness.find(rs.getInt(5));
					Session session = new Session(rs.getInt(1), rs.getString(2), rs.getTimestamp(3), rs.getTimestamp(4), conference, president);
					sessions.add(session);
				}
				return sessions;
			} 
			catch(SQLException e) {
				e.printStackTrace();
			}
			return null;
		}
		
		@Override
		public Session add(Session session) {
			IConference conferenceBusiness = new ConferenceDAO(connection);
			IPresident presidentBusiness = new PresidentDAO(connection);
			IComite comiteBusiness = new ComiteDAO(connection);
			IPapier papierBusiness = new PapierDAO(connection);
			Session returned_session = null;
			if( connection != null ) {
				PreparedStatement st;
				try {
					st = connection.prepareStatement("insert into Session values(NULL,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
					st.setString(1, session.getTitre());
					Timestamp dt1 = new Timestamp(session.getDate_start_session().getTime());
					Timestamp dt2 = new Timestamp(session.getDate_end_session().getTime());
					st.setTimestamp(2, dt1);
					st.setTimestamp(3, dt2);
					st.setInt(4, session.getConference().getId());
					st.setInt(5, session.getPresident().getPresident_id());
					
					if( st.executeUpdate() != -1 ) {
						System.out.println("Session ajoutée avec succé");
						ResultSet rs = st.getGeneratedKeys();
						if( rs.next() )
							returned_session = this.find(rs.getInt(1));
					}else
						System.err.println("Une erreure est survenue, votre tutoriel n'est pas ajouté!");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			return returned_session;
		}
		

		@Override
		public boolean update(Session session) {
			IConference conferenceBusiness = new ConferenceDAO(connection);
			IPresident presidentBusiness = new PresidentDAO(connection);
			IComite comiteBusiness = new ComiteDAO(connection);
			IPapier papierBusiness = new PapierDAO(connection);
			PreparedStatement st;
			try {
				st = connection.prepareStatement("update Session set titre=?, date_start_session=?, date_end_session=?, conference_id=?, president_id=? where id=?");
				st.setString(1, session.getTitre());
				Timestamp dt1 = new Timestamp(session.getDate_start_session().getTime());
				Timestamp dt2 = new Timestamp(session.getDate_end_session().getTime());
				st.setTimestamp(2, dt1);
				st.setTimestamp(3, dt2);
				st.setInt(4, session.getConference().getId());
				st.setInt(5, session.getPresident().getPresident_id());
				st.setInt(6, session.getId());
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
			IConference conferenceBusiness = new ConferenceDAO(connection);
			IPresident presidentBusiness = new PresidentDAO(connection);
			IComite comiteBusiness = new ComiteDAO(connection);
			IPapier papierBusiness = new PapierDAO(connection);
			PreparedStatement st;
			try {
				st = connection.prepareStatement("delete from Session where id=?");
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
		public Collection<Session> findAll() {
			IConference conferenceBusiness = new ConferenceDAO(connection);
			IPresident presidentBusiness = new PresidentDAO(connection);
			IComite comiteBusiness = new ComiteDAO(connection);
			IPapier papierBusiness = new PapierDAO(connection);
			Statement st;
			Collection<Session> sessions = new ArrayList<>();
			try {
				st = connection.createStatement();
				ResultSet rs = st.executeQuery("select *from Session order by id desc");
				while( rs.next() ) {
					President president = presidentBusiness.find(rs.getInt(6));
					Conference conference = conferenceBusiness.find(rs.getInt(5));
					Session session = new Session(rs.getInt(1), rs.getString(2), rs.getTimestamp(3), rs.getTimestamp(4), conference, president);
					sessions.add(session);
				}
				return sessions;
			} 
			catch(SQLException e) {
				e.printStackTrace();
			}
			return null;
		}
		

}
