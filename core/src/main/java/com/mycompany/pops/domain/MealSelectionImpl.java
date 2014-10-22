package com.mycompany.pops.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

@Entity
@Table(name = "MEAL_SELECTION")
public class MealSelectionImpl implements MealSelection {

    @Id
    @GeneratedValue(generator= "MealSelectionId")
    @GenericGenerator(
        name="MealSelectionId",
        strategy="org.broadleafcommerce.common.persistence.IdOverrideTableGenerator",
        parameters = {
            @Parameter(name="segment_value", value="MealSelectionImpl"),
            @Parameter(name="entity_name", value="com.mycompany.pops.domain.MealSelectionImpl")
        }
    )
    @Column(name = "ID")
	protected Long id;
    
    @Column(name = "CUSTOMER_ID")
	protected Long customer_id;
    
    @Column(name = "FLIGHT_ID")
	protected Long flightID;
    
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
	public Long getCustomer_id() {
		return customer_id;
	}
	
	@Override
	public void setCustomer_id(Long customer_id) {
		this.customer_id = customer_id;
	}
	
	@Override
	public Long getFlightID() {
		return flightID;
	}
	
	@Override
	public void setFlightID(long flightID) {
		this.flightID = flightID;
	}
	
	@Override
	public Long getMeal_id() {
		return meal_id;
	}
	
	@Override
	public void setMeal_id(Long meal_id) {
		this.meal_id = meal_id;
	}
	

}
