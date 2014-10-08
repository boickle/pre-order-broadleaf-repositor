package com.mycompany.pops.domain;

import java.util.Date;

public interface FlightInfo{

	public Long getId();
	public void setId(Long id);
	
	public String getFlightNumber();
	public void setFlightNumber(String flightNumber);
	
	public String getDestinationLocation();
	public void setDestinationLocation(String destinationLocation);
	
	public String getDepartureLocation();
	public void setDepartureLocation(String departureLocation);
	
	public Date getDepartureTime();
	public void setDepartureTime(Date departureTime);
	
	public Date getArrivalTime();
	public void setArrivalTime(Date arrivalTime);
	
	public String getAircraftType();
	public void setAircraftType(String aircraftType);

	public String getCarrier();
	public void setCarrier(String carrier);
	
	public String getOriginLocation();
	public void setOriginLocation(String originLocation);

}
