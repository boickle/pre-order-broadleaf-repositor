package com.mycompany.pops.pojo;

public class PopsCustomer{
	private String firstName = "";
	private String lastName = "";
	private String email = "";
	public void setFirstName(String firstName){
		this.firstName = firstName;
	}
	
	public String getFirstName(){
		return this.firstName;
	}
	
	public void setLastName(String lastName){
		this.lastName=lastName;
	}
	
	public String getLastName(){
		return this.lastName;
	}
	
	public void setEmail(String email){
		this.email=email;
	}
	
	public String getEmail(){
		return this.email;
	}
}
