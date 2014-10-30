package com.mycompany.pops.domain;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;
@Entity
@Table(name = "POPS_TRANSACTION")
public class PopsTransactionImpl implements PopsTransaction {

	@Id
    @GeneratedValue(generator= "PopsTransaction")
    @GenericGenerator(
        name="PopsTransaction",
        strategy="org.broadleafcommerce.common.persistence.IdOverrideTableGenerator",
        parameters = {
            @Parameter(name="segment_value", value="PopsTransactionImpl"),
            @Parameter(name="entity_name", value="com.mycompany.pops.domain.PopsTransactionImpl")
        }
    )
	
	@Column(name = "ID")
	protected Long id;
	
	@Column(name = "TOKEN")
	protected String token;
	
	@Column(name = "CUSTOERFLIGHTID")
	protected Long customerFlightId;
	
	@Column(name = "CUSTOMERID")
	protected Long customerId;
	
	@Column(name = "TIMESTAMP")
	protected Timestamp timestamp;
	 
	@Override
	public long getId() {
		return id;
	}

	@Override
	public String getToken() {
		return token;
	}

	@Override
	public long getCustomerFlightId() {
		return customerFlightId;
	}

	@Override
	public long getCustomerId() {
		return customerId;
	}

	@Override
	public void setId(long id) {
		this.id=id;
	}

	@Override
	public void setToken(String token) {
	this.token=token;
	}

	@Override
	public void setCustomerFlightId(long customerFlightId) {
		this.customerFlightId=customerFlightId;
	}

	@Override
	public void setCustomerId(long customerId) {
		this.customerId=customerId;
	}

	@Override
	public Timestamp getTimestamp() {
		return this.timestamp;
	}

	@Override
	public void setTimestamp(Timestamp timestamp) {
		this.timestamp = timestamp;
	}

}
