package com.mycompany.pops.pojo;

import java.util.List;

public class Passenger {
	private String firstName = "";
	private String lastName = "";
	private String seatNumber = "";
	private String displayName = "";
	private List<Meal> mealSelection;
	
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
		return displayName;
		//return firstName + " " + lastName;
	}
	
	public String getSeatNumber(){
		return this.seatNumber;
	}
	
	public void setSeatNumber(String seatNumber){
		this.seatNumber=seatNumber;
	}
	
	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	public List<Meal> getMealSelection() {
		return mealSelection;
	}

	public void setMealSelection(List<Meal> mealSelection) {
		this.mealSelection = mealSelection;
	}


}
