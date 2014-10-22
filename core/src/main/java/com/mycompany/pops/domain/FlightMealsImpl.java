package com.mycompany.pops.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

@Entity
@Table(name = "FLIGHT_MEAL")
public class FlightMealsImpl implements FlightMeals {

	@Id
	@GeneratedValue(generator = "FlightMealId")
	@GenericGenerator(name = "FlightMealId", strategy = "org.broadleafcommerce.common.persistence.IdOverrideTableGenerator", parameters = {
			@Parameter(name = "segment_value", value = "FlightMealImpl"),
			@Parameter(name = "entity_name", value = "com.mycompany.pops.domain.FlightMealImpl") })
	@Column(name = "ID")
	protected Long id;

	@Column(name = "FLIGHT_NUMBER")
	protected String flightNumber;

	@Column(name = "FLIGHT_ID")
	protected long flightID;

	@Column(name = "MEAL_TYPE")
	protected String mealType;

	@Column(name = "MEAL_ID")
	protected Long meal_id;

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
	public String getMealType() {
		return mealType;
	}

	@Override
	public void setMealType(String mealType) {
		this.mealType = mealType;
	}

	@Override
	public Long getMeal_id() {
		return meal_id;
	}

	@Override
	public void setMeal_id(Long meal_id) {
		this.meal_id = meal_id;
	}

	public long getFlightID() {
		return flightID;
	}

	public void setFlightID(long flightID) {
		this.flightID = flightID;
	}
}
