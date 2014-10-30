package com.mycompany.pops.pojo;

import java.util.List;

public class Transaction {
	private PopsCustomer customer;
	private List<FlightData> flights;
	
	public PopsCustomer getCustomer(){
		return this.customer;
	}
	
	public void setCustomer(PopsCustomer customer){
		this.customer = customer;
	}
	
	public List<FlightData> getFlights(){
		return this.flights;
	}
	
	public void setPassengers(List<FlightData> flights){
		this.flights = flights;
	}
}
