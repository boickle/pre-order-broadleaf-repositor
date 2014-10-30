package com.mycompany.pops.domain;

import java.sql.Timestamp;

public interface PopsTransaction {
	public long getId();
	public void setId(long id);
	
	public String getToken();
	public void setToken(String token);
	
	public long getCustomerFlightId();
	public void setCustomerFlightId(long customerFlightId);
	
	public long getCustomerId();		//This would be the ID of the user that perfromed a transaction, not necessarily a passenger.
	public void setCustomerId(long customerId);
	
	public Timestamp getTimestamp();
	public void setTimestamp(Timestamp timestamp);
	
}
