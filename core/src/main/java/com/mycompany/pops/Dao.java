package com.mycompany.pops;

import java.util.List;

import com.mycompany.pops.domain.FlightInfo;
import com.mycompany.pops.pojo.Category;
import com.mycompany.pops.pojo.FlightData;
import com.mycompany.pops.pojo.Meal;
import com.mycompany.pops.pojo.Product;

public interface Dao {

	public void insertFlight(FlightInfo info);
	
	public List<Category> getCategories(long parentID,String locale);

	public List<Product> getProductsForCategory(long categoryID,String locale);
	
	public List<Category> getBreadCrumbForCategory(long categoryID, String locale);

	public List<Category> getBreadCrumbForProduct(long productID, String locale);

	public String getCategoryName(long categoryID, String locale);
	
	public List<Product> getMealsForFlight(String flightNumber, String mealType, String locale);
	
	public void saveMealSelection(long customerID, String flightNumber, long mealID); 
	
	public List<Meal> getMealsForCustomer(long customerID,String flightNumber);
	
	public List<Long> getAllMealIDForFlight(String flightNumber);
	
	public FlightData getFlightDataForFlight(String flightNumber);
	
	public void insertNewCustomer(String lastName, String firstName, String email, String flightNumber, String flightDate);
	
	public void insertBlankAddressToOrder(long orderID);
}
