package com.mycompany.pops.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

@Entity
@Table(name = "FLIGHTINFO")

public class FlightInfoImpl implements FlightInfo {
    
    @Id
    @GeneratedValue(generator= "FlightInfoId")
    @GenericGenerator(
        name="FlightInfoId",
        strategy="org.broadleafcommerce.common.persistence.IdOverrideTableGenerator",
        parameters = {
            @Parameter(name="segment_value", value="FlightInfoImpl"),
            @Parameter(name="entity_name", value="com.mycompany.domain.FlightInfoImpl")
        }
    )
	@Column(name = "ID")
	protected Long id;
	
	@Column(name = "FLIGHT_NUMBER")
	protected String flightNumber;
	
	@Column(name = "DESTINATION_LOCATION")
	protected String destinationLocation;
	
	@Column(name = "DEPARTURE_LOCATION")
	protected String departureLocation;
	
	@Column(name = "DEPARTURE_TIME")
	protected Date departureTime;
	
	@Column(name = "ARRIVAL_TIME")
	protected Date arrivalTime;
	
	@Override
	public Long getId() {
		return id;
	}
	
	@Override
	public void setId(Long id) {
		this.id = id;
	}
	
	@Override
	public String getFlightNumber() {
		return flightNumber;
	}
	
	@Override
	public void setFlightNumber(String flightNumber) {
		this.flightNumber = flightNumber;
	}
	
	@Override
	public String getDestinationLocation() {
		return destinationLocation;
	}
	
	@Override
	public void setDestinationLocation(String destinationLocation) {
		this.destinationLocation = destinationLocation;
	}
	
	@Override
	public String getDepartureLocation() {
		return departureLocation;
	}
	
	@Override
	public void setDepartureLocation(String departureLocation) {
		this.departureLocation = departureLocation;
	}
	
	@Override
	public Date getDepartureTime() {
		return departureTime;
	}
	
	@Override
	public void setDepartureTime(Date departureTime) {
		this.departureTime = departureTime;
	}
	
	@Override
	public Date getArrivalTime() {
		return arrivalTime;
	}
	
	@Override
	public void setArrivalTime(Date arrivalTime) {
		this.arrivalTime = arrivalTime;
	}
	

		 
}
