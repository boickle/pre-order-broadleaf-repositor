package com.mycompany.pops.domain;


public interface PassengerFlight {

	public Long getId();

	public void setId(Long id);

	public Long getPassengerID();

	public void setPassengerID(Long passengerID);

	public String getMealOrderNumber();
	
	public void setMealOrderNumber(String mealOrderNumber);
	
    public long getFlightID();

    public void setFlightID(long flightID);

}
