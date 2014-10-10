package com.mycompany.pops.pojo;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.mycompany.pops.Constants;

/**
 * This class to be used by view, additional methods can be added to help provide info for view
 * @author JMak
 *
 */
public class FlightData {

	private String flightNumber;
	private Date departureDate;
	private String originStation;
	private String destinationStation;
	private Date arrivalDate;
	private String aircraftType;
	private String carrier;

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

	public void setDepartureDate(Date departureDate) {
		this.departureDate = departureDate;
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

	public void setArrivalDate(Date arrivalDate) {
		this.arrivalDate = arrivalDate;
	}

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
	

}
