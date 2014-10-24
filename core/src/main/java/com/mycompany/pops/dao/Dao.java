package com.mycompany.pops.dao;

import java.util.List;

import com.mycompany.pops.domain.FlightInfo;
import com.mycompany.pops.pojo.Category;
import com.mycompany.pops.pojo.FlightData;
import com.mycompany.pops.pojo.Meal;
import com.mycompany.pops.pojo.MealSelectionData;
import com.mycompany.pops.pojo.Product;

public interface Dao {

	public void insertFlight(FlightInfo info);
	
	public List<Category> getCategories(long parentID,String locale);

	public List<Product> getProductsForCategory(long categoryID,String locale);
	
	public List<Category> getBreadCrumbForCategory(long categoryID, String locale);

	public List<Category> getBreadCrumbForProduct(long productID, String locale);

	public String getCategoryName(long categoryID, String locale);
	
	public List<Product> getMealsForFlightID(String flightID, String mealType, String locale);
	
	public void saveMealSelection(long customerID, String flightNumber, long mealID); 
	
	public List<Meal> getMealsForCustomer(long customerID,String flightID, String flightNumber);
	
	public List<Long> getAllMealIDForFlight(String flightID);
	
	public FlightData getFlightDataForFlight(String flightNumber, String flightDate, String originStation, String destinationStation);
	
	public FlightData getFlightDataForFlightID(long flightID);
	
	public void insertNewCustomer(String lastName, String firstName, String email, String flightNumber, String flightDate, String originStation, String destinationStation);
	
	public void insertBlankAddressToOrder(long orderID);
	
	public FlightData getFlightInfoFromMealOrder(String orderNumber);
	
	public void saveFlightInfoForOrder(long customerID, String flightNumber, String orderNumber);
	
	public List<MealSelectionData> getAllMealSelections();
}
