package com.mycompany.pops.tools;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;

import com.mycompany.pops.pojo.PopsCustomer;

public class UserToken {
	private PopsCustomer customer;
	private Timestamp timestamp;
	private String token;
	private String SALT = "snow";
	
	public UserToken(PopsCustomer customer){
		this.customer = customer;
		Calendar calendar = Calendar.getInstance();
		Date now = calendar.getTime();
		long time = now.getTime();
		this.timestamp = new Timestamp(time);
		this.generate();
	}
	
	public PopsCustomer getCustomer(){
		return this.customer;
	}
	
	public void setCustomer(PopsCustomer customer){
		this.customer = customer;
	}
	
	public Timestamp gettimestamp(){
		return this.timestamp;
	}
	
	private void generate(){
		String token = this.customer.getEmail() + this.timestamp.toString()+SALT;
		
		byte[] bytesOfMessage = null;
		try {
			bytesOfMessage = token.getBytes("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		MessageDigest md = null;
		try {
			md = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		if(bytesOfMessage!=null && md !=null){
			byte[] tokenbytes = md.digest(bytesOfMessage);
			BigInteger bigInt = new BigInteger(1,tokenbytes);
			String hashtext = bigInt.toString(16);
			// Now we need to zero pad it if you actually want the full 32 chars.
			while(hashtext.length() < 32 ){
			  hashtext = "0"+hashtext;
			}
			this.token=hashtext;
		}
	}
	
	public String getToken(){
		return this.token;
	}
	
	
}
