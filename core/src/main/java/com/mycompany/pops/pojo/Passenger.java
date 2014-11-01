package com.mycompany.pops.pojo;

public class Passenger {
	private String firstName = "";
	private String lastName = "";
	private String seatNumber = "";
	public void setFirstName(String firstName){
		this.firstName = firstName;
	}
	
	public String getFirstName(){
		return this.firstName;
	}
	
	public void setLastName(String lastName){
		this.lastName=lastName;
	}
	
	public String getLastName(){
		return this.lastName;
	}

	public String getDisplayName(){
		return firstName + " " + lastName;
	}
	
	public String getSeatNumber(){
		return this.seatNumber;
	}
	
	public void setSeatNumber(String seatNumber){
		this.seatNumber=seatNumber;
	}


}
