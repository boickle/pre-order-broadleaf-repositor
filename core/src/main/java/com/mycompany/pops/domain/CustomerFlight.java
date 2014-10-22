package com.mycompany.pops.domain;

import java.util.Date;

public interface CustomerFlight {

	public Long getId();

	public void setId(Long id);

	public Long getCustomerID();

	public void setCustomerID(Long customerID);

	public String getFlightNumber();

	public void setFlightNumber(String flightNumber);
	
	public Date getFlightDate();

	public void setFlightDate(Date flightDate);
	
	public String getOriginStation();

	public void setOriginStation(String originStation);

	public String getDestinationStation();

	public void setDestinationStation(String destinationStation);

	public String getMealOrderNumber();
	
	public void setMealOrderNumber(String mealOrderNumber);
	
    public long getFlightID();

    public void setFlightID(long flightID);

}
