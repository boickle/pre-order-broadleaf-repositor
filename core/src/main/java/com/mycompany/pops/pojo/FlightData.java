package com.mycompany.pops.pojo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mycompany.pops.Constants;

/**
 * This class to be used by view, additional methods can be added to help provide info for view
 * @author JMak
 *
 */
public class FlightData {
	
	protected static final Log LOG = LogFactory.getLog(FlightData.class);


	private String flightID;
	private String flightNumber;
	private Date departureDate;
	private String fDepartureDate;
	private String originStation;
	private String destinationStation;
	private Date arrivalDate;
	private String fArrivalDate;
	private String aircraftType;
	private String carrier;

	public String getFlightID() {
		return flightID;
	}

	public void setFlightID(String flightID) {
		this.flightID = flightID;
	}

	public String getFlightNumber() {
		return flightNumber;
	}

	public void setFlightNumber(String flightNumber) {
		this.flightNumber = flightNumber;
	}

	public String getOriginStation() {
		return originStation;
	}

	public void setOriginStation(String originStation) {
		this.originStation = originStation;
	}

	public String getDestinationStation() {
		return destinationStation;
	}

	public void setDestinationStation(String destinationStation) {
		this.destinationStation = destinationStation;
	}

	public Date getDepartureDate() {
		return departureDate;
	}
	
	public String getFDepartureDate() {
		return fDepartureDate;
	}

	public void setDepartureDate(Date departureDate) {
		try {
			this.departureDate = departureDate;
			Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.s").parse(departureDate.toString());
			SimpleDateFormat format = new SimpleDateFormat("dd/MM/YYYY HH:mm");
	        this.fDepartureDate = format.format(date);
		} catch (ParseException e) {
				LOG.error("Parse error at setting departure date, which is "+departureDate,e);
		}
	}

	public String getAircraftType() {
		return aircraftType;
	}

	public void setAircraftType(String aircraftType) {
		this.aircraftType = aircraftType;
	}

	public String getCarrier() {
		return carrier;
	}

	public void setCarrier(String carrier) {
		this.carrier = carrier;
	}

	public Date getArrivalDate() {
		return arrivalDate;
	}
	
	public String getFArrivalDate() {
		return fArrivalDate;
	}

	public void setArrivalDate(Date arrivalDate) {
		try {
			this.arrivalDate = arrivalDate;
			Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.s").parse(arrivalDate.toString());
			SimpleDateFormat format = new SimpleDateFormat("dd/MM/YYYY HH:mm");
	        this.fArrivalDate = format.format(date);
		} catch (ParseException e) {
			LOG.error("Parse error at setting arrival date, which is "+arrivalDate,e);
		}
	}

	// For the dashboard
	
	// TODO: make locale friendly
	private String getElaborateDepartureArrivalText(String type, Date date, String stationAbbreviation) {
		SimpleDateFormat sdf1 = new SimpleDateFormat("hh:mm a");
		SimpleDateFormat sdf2 = new SimpleDateFormat("MMM d");
		
		String result = "<strong>"+type+" at "+sdf1.format(date)+" </strong> on "+sdf2.format(date)
		+ "<br/>"+ Constants.AIRPORTS.get(stationAbbreviation)+" ("+stationAbbreviation+")";
		
		return result;
	}

	public String getElaborateDepartureText() {
		return getElaborateDepartureArrivalText("Departs",getDepartureDate(),getOriginStation());
	}

	public String getElaborateArrivalText() {
		return getElaborateDepartureArrivalText("Arrives",getArrivalDate(),getDestinationStation());
	}
	
	// For the confirmation email
	public String getDepartureDateOnly() {
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
		return sdf.format(departureDate);
	}

	public String getDepartureTimeOnly() {
		SimpleDateFormat sdf = new SimpleDateFormat("hh:mm a, z");
		return sdf.format(departureDate);
	}
	
	public String getDestinationStationSpelled() {
		return Constants.AIRPORTS.get(destinationStation);
	}

	public String getOriginStationSpelled() {
		return Constants.AIRPORTS.get(originStation);
	}

	public String getDestinationStationSpelledWithAbbrev() {
		return Constants.AIRPORTS.get(destinationStation)+" ("+destinationStation+")";
	}

	public String getOriginStationSpelledWithAbbrev() {
		return Constants.AIRPORTS.get(originStation)+" ("+originStation+")";
	}

}
