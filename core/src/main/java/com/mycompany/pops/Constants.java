package com.mycompany.pops;

import java.util.HashMap;
import java.util.Map;

public class Constants {
	public static int PRIMARY_NAV = 2; // the category ID for main nav
	
	public static String JNDI_DATASOURCE = "jdbc/web";
	
	// Theoretically we should not need to do jdbc at all... if we can use hibernate...
	public static String JDBC_DRIVER = "org.postgresql.Driver";
	public static String JDBC_CONNECTION = "jdbc:postgresql://localhost:5432/POPS";
	public static String JDBC_LOGIN = "postgres";
	public static String JDBC_PASSWORD = "admin";

//	public static String JDBC_CONNECTION = "jdbc:postgresql://10.0.102.29:5432/TS5_Dev";
//	public static String JDBC_LOGIN = "TS5PGAdmin";
//	public static String JDBC_PASSWORD = "Winter2014!";

	// These are meal types in the table FLIGHT_MEAL
	public static String BREAKFAST = "B";
	public static String LUNCH = "L";
	public static String DINNER = "D";

	public static String BREAKFAST_DESC = "Breakfast";
	public static String LUNCH_DESC = "Lunch";
	public static String DINNER_DESC = "Dinner";
	
	public static String FLIGHT_DATE_FORMAT_FROM_EMAIL_LINK = "MM/dd/yyyy";

	//TODO: get this out of constants! (the order confirmation email has no clue what server it is on)
	public static String SERVERPATH_FOR_EMAIL = "ec2-54-87-4-62.compute-1.amazonaws.com";
	
	//TODO: make this in a database is better way to do this
	public static final Map<String , String> AIRPORTS = new HashMap<String , String>() {{
		    put("ORD", "O'Hare International Airport");
		    put("MDW", "Chicago Midway");
		    put("YUL", "Montréal-pierre Elliott Trudeau International Airport");
		    put("YVR", "Vancouver International Airport");
		    
	}};
	
	public static final String[] BCC_LIST = new String[] {"jElyea@gategourmet.com","EVanHorne@egate-solutions.com","SDivi@egate-solutions.com","kkiran@egate-solutions.com"};

}
