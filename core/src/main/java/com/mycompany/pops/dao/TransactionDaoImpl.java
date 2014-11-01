package com.mycompany.pops.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mycompany.pops.pojo.FlightData;
import com.mycompany.pops.pojo.Passenger;
import com.mycompany.pops.pojo.PopsCustomer;
import com.mycompany.pops.pojo.Transaction;
import com.mycompany.pops.tools.UserToken;

public class TransactionDaoImpl implements TransactionDao{
	
	protected static final Log LOG = LogFactory.getLog(Dao.class);
	
	private Dao dao = null;
	
	public TransactionDaoImpl(Dao dao){
		this.dao = dao;
	}
	
	@Override
	public void insertNewTransaction(UserToken token, Transaction transaction) {
		long customerId = insertNewCustomer(transaction.getCustomer());
		for(int i=0;i<transaction.getFlights().size();i++){
			FlightData flight = transaction.getFlights().get(i);
			List<Passenger> passengers = flight.getPassengers();
			
			for(int z=0;z<passengers.size();z++){
				Passenger p = passengers.get(z);
				long passengerId = this.insertNewPassenger(p);
				long flightId = this.insertPassengerFlight(passengerId, flight);
				long id = DaoUtil.newSequenceForTable("POPS_TRANSACTION", "ID");
				String dateFormatForDB = "yyyy-MM-dd HH:mm:ssZ";
				SimpleDateFormat sdfForDB = new SimpleDateFormat(dateFormatForDB);
				String flightDateForDB = sdfForDB.format(token.gettimestamp());
				String sql = "insert into POPS_TRANSACTION (ID, TOKEN, PASSENGERFLIGHTID, CUSTOMERID, TIMESTAMP) values ("
						+ id + ",'" + token.getToken() + "','" + flightId + "','" + customerId + "','" + flightDateForDB + "')";
				LOG.info("sql=" + sql);
				DaoUtil.jdbcInsertUpdateWrapper(sql);
			}	
		}
	}
	
	@Override
	public Transaction getTransaction(String token) {
		LOG.info("Grabing transaction with token: " + token);
		Transaction t = new Transaction();
		t.setFlights(this.getFlights(token));
		t.setCustomer(this.getCustomer(token));
		return t;
	}
	
	private PopsCustomer getCustomer(String token){
		PopsCustomer customer = null;
		String sql = "select email_address, first_name, last_name from blc_customer where customer_id IN (select customerid from pops_transaction where token = '"+ token +"' limit 1)";
		
		ResultSet rs = DaoUtil.jdbcSelectWrapper(sql);
		try {
			if (rs.next()) {
				customer = new PopsCustomer();
				customer.setEmail(rs.getString("email_address"));
				customer.setFirstName(rs.getString("first_name"));
				customer.setLastName(rs.getString("last_name"));
			}
			rs.close();
		} catch (SQLException e) {
			LOG.error("sql exception", e);
		}
		if(customer==null){
			LOG.info("No customer found for sql=" + sql);
		}
		return customer;
	}
	
	private List<FlightData> getFlights(String token){
		String sql = "select id, aircraft_type, arrival_time, carrier, departure_time, destination_location, flight_number, origin_location from flightinfo where id "
				+ "IN (select flight_id from passenger_flight where id "
				+ "IN (select passengerflightid from pops_transaction where token='"+ token +"'))";
		ResultSet rs = DaoUtil.jdbcSelectWrapper(sql);
		List<FlightData> flights = new ArrayList<FlightData>();
		if (rs != null) {
			try {
				while (rs.next()) {
					FlightData f = new FlightData();
					f.setAircraftType(rs.getString("aircraft_type"));
					f.setArrivalDate(rs.getDate("arrival_time"));
					f.setCarrier(rs.getString("carrier"));
					f.setDepartureDate(rs.getDate("departure_time"));
					f.setDestinationStation(rs.getString("destination_location"));
					f.setFlightNumber(rs.getString("flight_number"));
					f.setOriginStation(rs.getString("origin_location"));
					f.setFlightID(rs.getLong("id"));
					f.setPassengers(this.getPassengers(token, f.getFlightID()));
					flights.add(f);
				}
				rs.close();
			} catch (SQLException e) {
				LOG.error("sql exception", e);
			}
		}
		if (flights.isEmpty()) {
			LOG.info("No fllights found for sql=" + sql);
		}
		return flights;
	}
	
	private List<Passenger> getPassengers(String token, long flightId){
		String sql = "select id, first_name, last_name, seat_number from pops_passenger where id "
				+ "IN (select passenger_id from passenger_flight where id "
				+ "IN (select passengerflightid from pops_transaction where token='"+ token +"') and flight_id='"+ flightId +"')";
		ResultSet rs = DaoUtil.jdbcSelectWrapper(sql);
		List<Passenger> passengers = new ArrayList<Passenger>();
		if (rs != null) {
			try {
				while (rs.next()) {
					Passenger p = new Passenger();
					p.setFirstName(rs.getString("first_name"));
					p.setLastName(rs.getString("last_name"));
					p.setSeatNumber(rs.getString("seat_number"));
					passengers.add(p);
				}
				rs.close();
			} catch (SQLException e) {
				LOG.error("sql exception", e);
			}
		}
		if (passengers.isEmpty()) {
			LOG.info("No passengers found for sql=" + sql);
		}
		return passengers;
	}
	
	private long insertNewCustomer(PopsCustomer customer){
		long customerID = findCustomerIDByUserName(customer.getEmail());

		if (customerID==0) {
			
			customerID = DaoUtil.newSequenceForTable("blc_customer","customer_id");
	
			String newCustomerSQL = "insert into blc_customer (customer_id,deactivated,email_address,first_name,last_name,password,password_change_required,is_registered,user_name) values ("
					+ customerID
					+ ','
					+ "'f','"
					+ customer.getEmail()
					+ "','"
					+ customer.getFirstName()
					+ "','"
					+ customer.getLastName()
					+ "','Welcome1{"+customerID+"}',"
					+ "'f','t','"
					+ customer.getEmail()+"')";
			LOG.info("sql=" + newCustomerSQL);
			DaoUtil.jdbcInsertUpdateWrapper(newCustomerSQL);
		}
		return customerID;
	}
	
	private long insertNewPassenger(Passenger passenger){
		long passengerID = findPassengerIDByUserName(passenger);

		if (passengerID==0) {
			
			passengerID = DaoUtil.newSequenceForTable("pops_passenger","id");
	
			String newCustomerSQL = "insert into pops_passenger (id,first_name,last_name,seat_number) values (" + passengerID +",'" + passenger.getFirstName() + "','" + passenger.getLastName() + "','" + passenger.getSeatNumber() + "')"; 
			LOG.info("sql=" + newCustomerSQL);
			DaoUtil.jdbcInsertUpdateWrapper(newCustomerSQL);
		}
		return passengerID;
	}
	
	private long insertPassengerFlight(long passengerId, FlightData flight){
		
		String dateFormatForDB = "MM/dd/yyyy";
		SimpleDateFormat sdfForDB = new SimpleDateFormat(dateFormatForDB);
		Date flightDate = null;
		String flightDateForDB = flight.getDepartureDate().toString();
		try {
			flightDate = flight.getDepartureDate();
			LOG.info("flightDate:"+flightDate);
			flightDateForDB = sdfForDB.format(flightDate);
			LOG.info("flightDateForDB:"+flightDateForDB);
		}
		catch (Exception e) {
			flightDate = new Date(); // just so life goes on
			LOG.error("Error parsing flight date",e);
		}

		long flightID  = this.doesFlightExist(flight.getFlightNumber());
		long pk = -1;
		if (flightID<0) {
			LOG.error("Cannot find flight data: flightNumber:"+flight.getFlightNumber()+" flightDate:"+flight.getDepartureDate().toString()+" origin:"+flight.getOriginStation()+" destination:"+flight.getDestinationStation());
		}
		else {
			pk = DaoUtil.newSequenceForTable("passenger_flight");
			String sql = "insert into passenger_flight (id, passenger_id, flight_id) values ("+ pk + "," + passengerId + "," + flightID + ")";
			LOG.info(sql);
			DaoUtil.jdbcInsertUpdateWrapper(sql);
		}
		return pk;

	}
	
	private long findPassengerIDByUserName(Passenger passenger) {
		String sql = "select id from pops_passenger where first_name='"+passenger.getFirstName()+"' and last_name='"+passenger.getLastName() + "' and seat_number='" + passenger.getSeatNumber() +"'";
		long result = 0;
		ResultSet rs = DaoUtil.jdbcSelectWrapper(sql);
		try {
			if (rs.next()) {
				result = rs.getLong(1);
			}
			rs.close();
		} catch (SQLException e) {
			LOG.error("sql exception", e);
		}
		return result;
	}
	
	private long findCustomerIDByUserName(String userName) {
		String sql = "select customer_id from blc_customer where user_name='"+userName+"'";
		long result = 0;
		ResultSet rs = DaoUtil.jdbcSelectWrapper(sql);
		try {
			if (rs.next()) {
				result = rs.getLong(1);
			}
			rs.close();
		} catch (SQLException e) {
			LOG.error("sql exception", e);
		}
		return result;
	}
	
	public long doesFlightExist(String flightNumber) {
		
		LOG.info("Getting flight info for flight ID:" + flightNumber);
		long result = -1;
		String sql = "select id from flightinfo where flight_number='"+flightNumber+"'";
		
		ResultSet rs = DaoUtil.jdbcSelectWrapper(sql);
		try {
			if (rs.next()) {
				result = rs.getLong(1);
			}
			rs.close();
		} catch (SQLException e) {
			LOG.error("sql exception", e);
		}
		return result;
	}

	
	
}
