package com.mycompany.pops.domain;

public class BillingInfo {

	private String billingFirstName;
	private String billingLastName;
	private String billingAddress1;
	private String billingAddress2;
	private String billingEmail;
	private String billingPhone;
	private String ccNumber;
	private String ccMonth;
	private String ccYear;

	public String getBillingFirstName() {
		return billingFirstName;
	}

	public void setBillingFirstName(String billingFirstName) {
		this.billingFirstName = billingFirstName;
	}

	public String getBillingLastName() {
		return billingLastName;
	}

	public void setBillingLastName(String billingLastName) {
		this.billingLastName = billingLastName;
	}

	public String getBillingAddress1() {
		return billingAddress1;
	}

	public void setBillingAddress1(String billingAddress1) {
		this.billingAddress1 = billingAddress1;
	}

	public String getBillingAddress2() {
		return billingAddress2;
	}

	public void setBillingAddress2(String billingAddress2) {
		this.billingAddress2 = billingAddress2;
	}

	public String getBillingEmail() {
		return billingEmail;
	}

	public void setBillingEmail(String billingEmail) {
		this.billingEmail = billingEmail;
	}

	public String getBillingPhone() {
		return billingPhone;
	}

	public void setBillingPhone(String billingPhone) {
		this.billingPhone = billingPhone;
	}

	public String getCcNumber() {
		return ccNumber;
	}

	public void setCcNumber(String ccNumber) {
		this.ccNumber = ccNumber;
	}

	public String getCcMonth() {
		return ccMonth;
	}

	public void setCcMonth(String ccMonth) {
		this.ccMonth = ccMonth;
	}

	public String getCcYear() {
		return ccYear;
	}

	public void setCcYear(String ccYear) {
		this.ccYear = ccYear;
	}
	
	public String getLast4CC() {
		if (ccNumber==null) return "";
		int len = ccNumber.length();
		if (len<4) return ccNumber;
		return ccNumber.substring(len-4);
	}
	
	public String getExpdate() {
		if (ccMonth==null || ccYear==null) return "";
		return ccMonth+"/"+ccYear;
	}
}
