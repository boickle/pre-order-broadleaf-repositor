package com.mycompany.pops;

public class Constants {
	public static int PRIMARY_NAV = 2; // the category ID for main nav
	
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

}
