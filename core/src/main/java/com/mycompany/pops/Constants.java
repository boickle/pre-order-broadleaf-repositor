package com.mycompany.pops;

import java.util.HashMap;
import java.util.Map;

public class Constants {
	
	public static String JNDI_DATASOURCE = "jdbc/web";
	
	// These are meal types in the table FLIGHT_MEAL
	public static String BREAKFAST = "B";
	public static String LUNCH = "L";
	public static String DINNER = "D";

	public static String BREAKFAST_DESC = "Breakfast";
	public static String LUNCH_DESC = "Lunch";
	public static String DINNER_DESC = "Dinner";

	public static long BREAKFAST_CATEGORY = 2008;
	public static long LUNCH_CATEGORY = 2009;
	public static long DINNER_CATEGORY = 2010;

	public static String FLIGHT_DATE_FORMAT_FROM_EMAIL_LINK = "MM/dd/yyyy";
	public static String ORDER_DATE_FORMAT_IN_EMAIL = "EEEE, MMMM dd'th' yyyy 'at' HH:mm";
	
	public static String ACCEPTED_DATE_FORMAT = "MM/dd/yyyy";

	//TODO: make this in a database is better way to do this
	public static final Map<String , String> AIRPORTS = new HashMap<String , String>() {{
		    put("ORD", "O'Hare International Airport");
		    put("MDW", "Chicago Midway");
		    put("YUL", "Montreal, Trudeau, QC");
		    put("YVR", "Vancouver, Vancouver Int'l, BC");
		    
	}};
	

}
