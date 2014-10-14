package com.mycompany.pops.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

/**
 * This table contains what the initial email link contains... about what flight the customer is on.
 * @author JMak
 *
 */
@Entity
@Table(name = "CUSTOMER_FLIGHT")
public class CustomerFlightImpl implements CustomerFlight {
	
    @Id
    @GeneratedValue(generator= "CustomerFlightId")
    @GenericGenerator(
        name="CustomerFlightId",
        strategy="org.broadleafcommerce.common.persistence.IdOverrideTableGenerator",
        parameters = {
            @Parameter(name="segment_value", value="CustomerFlightImpl"),
            @Parameter(name="entity_name", value="com.mycompany.pops.domain.CustomerFlightImpl")
        }
    )
	@Column(name = "ID")
	protected Long id;
    
    @Column(name = "CUSTOMER_ID")
    protected Long customerID;
    
    @Column(name = "FLIGHT_NUMBER")
    protected String flightNumber;
	
    @Column(name = "FLIGHT_DATE")
	protected Date flightDate;

    @Column(name = "ORIGIN_STATION")
	protected String originStation;

    @Column(name = "DESTINATION_STATION")
	protected String destinationStation;

    @Column(name = "MEAL_ORDER_NUMBER")
	protected String mealOrderNumber;
    
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	public Long getCustomerID() {
		return customerID;
	}
	
	public void setCustomerID(Long customerID) {
		this.customerID = customerID;
	}
	
	public String getFlightNumber() {
		return flightNumber;
	}
	
	public void setFlightNumber(String flightNumber) {
		this.flightNumber = flightNumber;
	}

	public Date getFlightDate() {
		return flightDate;
	}

	public void setFlightDate(Date flightDate) {
		this.flightDate = flightDate;
	}
	
	public String getOriginStation() {
		return originStation;
	}

	public void setOriginStation(String originStation) {
		this.originStation = originStation;
	}

	public String getDestinationStation() {
		return destinationStation;
	}

	public void setDestinationStation(String destinationStation) {
		this.destinationStation = destinationStation;
	}

	public String getMealOrderNumber() {
		return mealOrderNumber;
	}

	public void setMealOrderNumber(String mealOrderNumber) {
		this.mealOrderNumber = mealOrderNumber;
	}

}
