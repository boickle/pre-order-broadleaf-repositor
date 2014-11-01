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
@Table(name = "POPS_PASSENGER")
public class PopsPassengerImpl implements PopsPassenger {
	
    @Id
    @GeneratedValue(generator= "PopsPassengerId")
    @GenericGenerator(
        name="PopsPassengerId",
        strategy="org.broadleafcommerce.common.persistence.IdOverrideTableGenerator",
        parameters = {
            @Parameter(name="segment_value", value="PopsPassengerImpl"),
            @Parameter(name="entity_name", value="com.mycompany.pops.domain.PopsPassengerImpl")
        }
    )
	@Column(name = "ID")
	protected Long id;
    
    @Column(name = "FIRST_NAME")
    protected String firstName;
    
    @Column(name = "LAST_NAME")
    protected String lastName;
    
    @Column(name = "SEAT_NUMBER")
    protected String seatNumber;
    
	public long getId() {
		return id;
	}
	
	public void setId(long id) {
		this.id = id;
	}

	@Override
	public String getLastName() {
		return this.lastName;
	}

	@Override
	public void setLastName(String lastName) {
		this.lastName=lastName;
	}

	@Override
	public String getFirstName() {
		return this.firstName;
	}

	@Override
	public void setFirstName(String firstName) {
	this.firstName=firstName;
		
	}

	@Override
	public String getSeatNumber() {
		return this.seatNumber;
	}

	@Override
	public void setSeatNumber(String seatNumber) {
		this.seatNumber = seatNumber;
	}
}
