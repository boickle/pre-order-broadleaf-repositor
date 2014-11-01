package com.mycompany.pops.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

/**
 * This table contains what the initial email link contains... about what flight the customer is on.
 * @author Boickle
 *
 */
@Entity
@Table(name = "PASSENGER_FLIGHT")
public class PassengerFlightImpl implements PassengerFlight {
	
    @Id
    @GeneratedValue(generator= "PassengerFlightId")
    @GenericGenerator(
        name="PassengerFlightId",
        strategy="org.broadleafcommerce.common.persistence.IdOverrideTableGenerator",
        parameters = {
            @Parameter(name="segment_value", value="PassengerFlightImpl"),
            @Parameter(name="entity_name", value="com.mycompany.pops.domain.PassengerFlightImpl")
        }
    )
	@Column(name = "ID")
	protected Long id;
    
    @Column(name = "PASSENGER_ID")
    protected Long passengerID;

    @Column(name = "FLIGHT_ID")
    protected long flightID;

    @Column(name = "MEAL_ORDER_NUMBER")
	protected String mealOrderNumber;
    
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	public Long getPassengerID() {
		return passengerID;
	}
	
	public void setPassengerID(Long passengerID) {
		this.passengerID = passengerID;
	}

	public String getMealOrderNumber() {
		return mealOrderNumber;
	}

	public void setMealOrderNumber(String mealOrderNumber) {
		this.mealOrderNumber = mealOrderNumber;
	}

    public long getFlightID() {
		return flightID;
	}

	public void setFlightID(long flightID) {
		this.flightID = flightID;
	}

}
