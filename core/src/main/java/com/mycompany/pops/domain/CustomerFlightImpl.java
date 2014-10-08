package com.mycompany.pops.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

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

}
