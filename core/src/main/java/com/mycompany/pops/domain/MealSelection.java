package com.mycompany.pops.domain;

public interface MealSelection {

	public Long getId();
	public void setId(Long id);
	
	public Long getCustomer_id();
	public void setCustomer_id(Long customer_id);
	
	public Long getFlightID();
	public void setFlightID(long flightID);

	public Long getMeal_id();
	public void setMeal_id(Long meal_id);
}
