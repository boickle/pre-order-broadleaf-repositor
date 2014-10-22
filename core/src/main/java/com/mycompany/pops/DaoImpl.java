package com.mycompany.pops;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.pops.domain.FlightInfo;
import com.mycompany.pops.pojo.Category;
import com.mycompany.pops.pojo.FlightData;
import com.mycompany.pops.pojo.Meal;
import com.mycompany.pops.pojo.MealSelectionData;
import com.mycompany.pops.pojo.Product;

public class DaoImpl implements Dao {
	protected static final Log LOG = LogFactory.getLog(Dao.class);


	// TODO get handle to EntityManager so we can use hibernate instead of good
	// old JDBC
	@PersistenceContext(unitName = "blPU")
	protected EntityManager em;

	// ---------------------------------
	// an experimental method
	@Transactional(value = "blTransactionManager")
	@Override
	public void insertFlight(FlightInfo info) {

		LOG.info("Inside Insert New Flight");
		LOG.info("Here you go: " + info.getFlightNumber() + " "
				+ info.getOriginLocation() + "->"
				+ info.getDestinationLocation());
		try {
			insertFlightUsingGoodOldJDBC(info);

			// em.merge(info);
		} catch (Exception e) {
			LOG.error("can't insert", e); // getting null pointer here
		} finally {
			// em.close();
		}

	}

	
	// Temporary... cause there are no pictures tied to categories 
	private String categoryNameToImage(String name) {
		return name.toLowerCase().replaceAll(" ", "-").replaceAll("\\?", "");
	}

	/**
	 * See the table blc_translation for translations for each entity.
	 * If not there just return the English defaultValue
	 */
	private String getTranslation(long id, String locale, String entityType,
			String fieldName, String defaultValue) {
		if (locale == null) {
			return defaultValue;
		}
		if (locale.startsWith("en")) {
			return defaultValue;
		}
		// TODO: figure out wassup with fr, fr_FR, es_ES, etc. now just take
		// first 2 char
		if (locale.indexOf("_") > 0) {
			locale = locale.substring(0, 2);
		}
		LOG.info("Trying to get " + locale + " localization for "
				+ defaultValue + ", the id is " + id + " entityType is "
				+ entityType + " fieldName=" + fieldName);

		String sql = "SELECT translated_value from blc_translation where entity_id = '"
				+ id
				+ "'"
				+ " and entity_type='"
				+ entityType
				+ "'"
				+ " and field_name='"
				+ fieldName
				+ "'"
				+ " and locale_code='"
				+ locale + "'";

		String result = defaultValue;
		ResultSet rs = DaoUtil.jdbcSelectWrapper(sql);
		try {
			if (rs.next()) {
				result = rs.getString(1);
			}
			rs.close();
		} catch (SQLException e) {
			LOG.error("sql exception", e);
		}
		
		return result;
	}

	
	private void insertFlightUsingGoodOldJDBC(FlightInfo info) {
		LOG.info("good old JDBC");
		int num = DaoUtil.newSequenceForTable("FLIGHTINFO");
		String sql = "INSERT INTO FLIGHTINFO (ID,FLIGHT_NUMBER, origin_location, DESTINATION_LOCATION) VALUES ("
					+ num
					+ ','
					+ "'"
					+ info.getFlightNumber()
					+ "',"
					+ "'"
					+ info.getOriginLocation()
					+ "',"
					+ "'"
					+ info.getDestinationLocation() + "')";
		DaoUtil.jdbcInsertUpdateWrapper(sql);
	}
	
	//------------------------------------------------------------------------------------
	public List<Category> getCategories(long parentID, String locale) {
		LOG.info("trying to get categories with parent = " + parentID);
		List<Category> result = null;

		String sql = "SELECT category_id,name,url from blc_category where "
				+ " not (archived IS NOT NULL and archived='Y') "
				// + check for active date range here
				+ " and default_parent_category_id = " + parentID
				+ " order by category_id";

		ResultSet rs = DaoUtil.jdbcSelectWrapper(sql);
		if (rs != null) {

			try {
				while (rs.next()) {
					if (result == null)
						result = new ArrayList<Category>();
					Category c = new Category();
					int categoryID = rs.getInt(1);

					LOG.info("I saw category id: " + categoryID);
					c.setCategory_id(categoryID);
					c.setName(getTranslation(categoryID, locale, "Category",
							"name", rs.getString(2)));
					// c.setUrl(rs.getString(3)); //-- the url set up by admin
					c.setUrl("/products/" + categoryID);

					// broadleaf doesn't support image for category (hard coding
					// it for now)
					c.setImageURL("/img/categories/"
							+ categoryNameToImage(rs.getString(2)) + ".png");
					c.setChildren(getCategories(categoryID, locale)); // recursion!
					result.add(c);
				}
				rs.close();
			} catch (SQLException e) {
				LOG.error("sql exception", e);
			}

		}

		return result;
	}

	public List<Product> getProductsForCategory(long categoryID, String locale) {
		LOG.info("trying to get product for category = " + categoryID);
		List<Product> result = null;

		String sql = "select product_id,manufacture,blc_product.url,retail_price,name,long_description,blc_media.url"
				+ " from blc_product, blc_sku, blc_sku_media_map, blc_media"
				+ " where default_category_id="
				+ categoryID
				+ " and sku_id = default_sku_id and sku_id = blc_sku_sku_id and blc_sku_media_map.media_id = blc_media.media_id"
				+ " and map_key='primary'";

		ResultSet rs = DaoUtil.jdbcSelectWrapper(sql);
		if (rs != null) {

			try {
				while (rs.next()) {
					if (result == null)
						result = new ArrayList<Product>();
					Product p = new Product();
					p.setProduct_ID(rs.getInt(1));
					p.setManufacture(rs.getString(2));
					p.setUrl(rs.getString(3));
					p.setRetail_price(rs.getDouble(4));
					p.setName(getTranslation(rs.getInt(1), locale, "Sku",
							"name", rs.getString(5)));
					p.setDescription(getTranslation(rs.getInt(1), locale,
							"Sku", "longDescription", rs.getString(6)));
					p.setImageUrl(rs.getString(7));

					result.add(p);
				}
				rs.close();
			} catch (SQLException e) {
				LOG.error("sql exception", e);
			}

		}

		return result;
	}

	public String getCategoryName(long categoryID, String locale) {
		LOG.info("trying to get category name= " + categoryID);
		String result = "";

		String sql = "select name from blc_category where category_id = "
				+ categoryID;
		ResultSet rs = DaoUtil.jdbcSelectWrapper(sql);
		try {

			if (rs.next()) {
				result = rs.getString(1);
			}
			rs.close();
		} catch (SQLException e) {
			LOG.error("sql exception", e);
		}

		return result;
	}

	public Category getCategoryInfo(long categoryID, String locale) {
		LOG.info("trying to get category info= " + categoryID);
		Category c = new Category();

		String sql = "select name,url from blc_category where category_id = "
				+ categoryID;
		ResultSet rs = DaoUtil.jdbcSelectWrapper(sql);
		try {

			if (rs.next()) {
				c.setName(getTranslation(categoryID, locale, "Category",
						"name", rs.getString(1)));
				// c.setUrl(rs.getString(2)); //-- the url set up by admin

				// TODO: is it link going to be subcategory or product?
				c.setUrl("/products/" + categoryID);

			}
			rs.close();
		} catch (SQLException e) {
			LOG.error("sql exception", e);
		}

		return c;
	}

	private int getParentCategory(long categoryID) {

		String sql = "SELECT default_parent_category_id from blc_category where category_id = "
				+ categoryID;
		int result = 0;
		ResultSet rs = DaoUtil.jdbcSelectWrapper(sql);
		if (rs != null) {

			try {
				if (rs.next()) {
					result = rs.getInt(1);
				}
				rs.close();
			} catch (SQLException e) {
				LOG.error("sql exception", e);
			}

		}
		return result;

	}

	public List<Category> getBreadCrumbForCategory(long categoryID,
			String locale) {
		LOG.info("trying to get breadcrumb for categorry " + categoryID);

		List<Category> result = new ArrayList<Category>();
		if (categoryID != Constants.PRIMARY_NAV) {
			result.add(getCategoryInfo(categoryID, locale));
		}

		int p = getParentCategory(categoryID);
		if (p > Constants.PRIMARY_NAV) {
			// keep going
			int i = 0;

			// trying to prevent infinite loop just in case
			while (i < 5 && p < Constants.PRIMARY_NAV) {
				LOG.info("yo, p is " + p);
				result.add(getCategoryInfo(p, locale));
				p = getParentCategory(p);
				i++;
			}
		}

		Category firstPage = new Category();
		firstPage.setName("Shop");
		firstPage.setUrl("/categories");
		result.add(firstPage);

		Collections.reverse(result);
		return result;
	}

	public List<Category> getBreadCrumbForProduct(long productID, String locale) {
		LOG.info("trying to breadcrumb for product " + productID);

		// Get category and name for this product (to be used in breadcrumb)
		String sql = "select default_category_id, name from blc_product, blc_sku where blc_sku.default_product_id=product_id and product_id= "
				+ productID;
		int categoryID = 0;
		String name = "";

		ResultSet rs = DaoUtil.jdbcSelectWrapper(sql);
		if (rs != null) {

			try {
				if (rs.next()) {
					categoryID = rs.getInt(1);
					name = rs.getString(2);
				}
				rs.close();
			} catch (SQLException e) {
				LOG.error("sql exception", e);
			}
		}

		// start with breadcrumb up to parent category
		List<Category> result = getBreadCrumbForCategory(categoryID, locale);

		// append this page
		Category thisPage = new Category();
		thisPage.setName(getTranslation(productID, locale, "Sku", "name", name));
		thisPage.setUrl("");
		result.add(thisPage);

		return result;
	}

	public List<Product> getMealsForFlightID(String flightID,
			String mealType, String locale) {
		LOG.info("trying to find meals for flight: " + flightID + " type:"
				+ mealType);
		List<Product> result = null;

		String sql = "select product_id,manufacture,blc_product.url,retail_price,name,long_description,blc_media.url"
				+ " from blc_product, blc_sku, blc_sku_media_map, blc_media, flight_meal"
				+ " where blc_product.product_id=meal_id"
				+ " and sku_id = default_sku_id and sku_id = blc_sku_sku_id and blc_sku_media_map.media_id = blc_media.media_id"
				+ " and map_key='primary'"
				+ " and flight_meal.flight_ID="+ flightID + " and meal_type='" + mealType + "' order by meal_id";

		ResultSet rs = DaoUtil.jdbcSelectWrapper(sql);
		if (rs != null) {

			try {
				while (rs.next()) {
					if (result == null)
						result = new ArrayList<Product>();

					Product p = new Product();
					p.setProduct_ID(rs.getInt(1));
					p.setManufacture(rs.getString(2));
					p.setUrl(rs.getString(3));
					p.setRetail_price(rs.getDouble(4));

					String name = getTranslation(rs.getInt(1), locale, "Sku",
							"name", rs.getString(5));
					// Get rid of (lunch) or (dinner) in the name
					// which is not needed to be displayed on the meal select
					// because it will be on the "Select Your Lunch/Dinner Meal" box
					name = name.replace("(breakfast)","");
					name = name.replace("(lunch)","");
					name = name.replace("(dinner)","");
					
					p.setName(name);
					
					String description = getTranslation(rs.getInt(1), locale,
							"Sku", "longDescription", rs.getString(6));
					
					
					p.setDescription(description);
					p.setImageUrl(rs.getString(7));

					LOG.info("I am adding this to " + mealType + ":"
							+ p.getName());

					result.add(p);

				}
				rs.close();
			} catch (SQLException e) {
				LOG.error("sql exception", e);
			}
		}
		if (result != null) {
			LOG.info("I am returning this many items: " + result.size());
		}
		return result;
	}
	
	private String findMealTypeForMealID(long mealID) {
		String sql = "select distinct meal_type from flight_meal where meal_id="+mealID;

		String result = "";

		ResultSet rs = DaoUtil.jdbcSelectWrapper(sql);
		if (rs != null) {

			try {
				if (rs.next()) {
					result = rs.getString(1);
				}
				rs.close();
			} catch (SQLException e) {
				LOG.error("sql exception", e);
			}
		}
		return result;
	}

	public void saveMealSelection(long customerID, String flightID,
			long mealID) {

		LOG.info("Saving meal for " + customerID + ", flightID:" + flightID
				+ " mealID:" + mealID);

		String mealType = findMealTypeForMealID(mealID);

			// First, find out the type of meal that the user already selected
			// (based on the current meal user tries to add)
			// then delete those selection (to remove previously selected meal
			// for the flight)
			// I wish I can send the meal type of the product selected, but this
			// is called by the cart and it only knows product ID

			String delSQL = "delete from meal_selection where meal_id in "
					+ "(select meal_id from flight_meal "
					+ " where flight_id=" + flightID
					+ " and meal_type = '"+mealType+"') and customer_id="+customerID;
			
			DaoUtil.jdbcInsertUpdateWrapper(delSQL);
	
			// insert the new selection
			int num = DaoUtil.newSequenceForTable("MEAL_SELECTION");

			String sql = "INSERT INTO MEAL_SELECTION (ID,CUSTOMER_ID,FLIGHT_ID, MEAL_TYPE,MEAL_ID) VALUES ("
					+ num
					+ ','
					+ customerID
					+ ','
					+ "'"
					+ flightID
					+ "','"
					+ mealType+"',"
					+ mealID + ")";

			LOG.info("sql=" + sql);
			DaoUtil.jdbcInsertUpdateWrapper(sql);
			
	}

	public List<Meal> getMealsForCustomer(long customerID, String flightID, String flightNumber) {
		LOG.info("trying to find meals for customer: " + customerID+ ", flight ID: "+flightID);
		if (customerID == 0)
			return null;

		// check if order already took place, if not, bye
		String sqlOrderMadeAlready = "select meal_order_number from customer_flight where customer_id="+customerID+" and flight_id="+flightID;
		ResultSet rs1 = DaoUtil.jdbcSelectWrapper(sqlOrderMadeAlready);
		String orderNumber=null;
		try {
			if (rs1.next()) {
				orderNumber = rs1.getString(1);
			}
			rs1.close();
			
		} catch (Exception e) {
			LOG.error("Error trying to determine if you ordered meal already",e);
		}
		LOG.info("getMealsForCustomer: The order number was: "+orderNumber);
		if (!(orderNumber!=null && orderNumber.length()>0)) {
			return null;
		}
		
		List<Meal> result = null;
		
		// Data is stored in MEAL_SELECTION table, need to gather the name and image

		String sql = "select default_product_id,meal_selection.flight_id,meal_selection.meal_type,blc_sku.name, blc_media.url"
				+ " from  meal_selection, blc_customer, blc_sku, blc_product , blc_sku_media_map, blc_media"
				+ " where"
				+ " blc_product.product_id = default_product_id"
				+ " and meal_selection.meal_id = blc_sku.default_product_id"
				+ "	and meal_selection.customer_id = blc_customer.customer_id"
				+ " and sku_id = default_sku_id and sku_id = blc_sku_sku_id and blc_sku_media_map.media_id = blc_media.media_id and map_key='primary' "
				+ " and meal_selection.customer_id="+customerID 
				+ " and flight_id="+flightID;
		
		ResultSet rs = DaoUtil.jdbcSelectWrapper(sql);
		if (rs != null) {

			try {
				while (rs.next()) {
					if (result == null)
						result = new ArrayList<Meal>();

					//String the_flightNumber = rs.getString(2);
					String mealType = rs.getString(3);
					String mealTypeSpelled = mealType;

					if (Constants.BREAKFAST.equals(mealType)) {
						mealTypeSpelled = Constants.BREAKFAST_DESC;
					}
					if (Constants.LUNCH.equals(mealType)) {
						mealTypeSpelled = Constants.LUNCH_DESC;
					}
					if (Constants.DINNER.equals(mealType)) {
						mealTypeSpelled = Constants.DINNER_DESC;
					}

					Meal m = new Meal();
					m.setFlightNumber(flightNumber);
					m.setMealType(mealType);

					String name=rs.getString(4);
					// Get rid of (lunch) or (dinner) in the name
					// which is not needed to be displayed on the meal select
					// because it will be on the "Select Your Lunch/Dinner Meal" box
					name = name.replace("(breakfast)","");
					name = name.replace("(lunch)","");
					name = name.replace("(dinner)","");

					m.setName(name);
					m.setImageUrl(rs.getString(5));
					m.setDescription(mealTypeSpelled + " on Flight #"
							+ flightNumber);
					result.add(m);

				}
				rs.close();
			} catch (SQLException e) {
				LOG.error("sql exception", e);
			}
		}
		if (result != null) {
			LOG.info("I am returning this many items: " + result.size());
		}
		return result;

	}
	
	// this method is probably not needed...
	public List<Long> getAllMealIDForFlight(String flightNumber) {
		LOG.info("Trying to find all meals available for customer for this flight"); 
		// to be used by cart controller so that we don't allow editing

		List<Long> result = null;
		String sql = "select meal_id from flight_meal where flight_number='"+flightNumber+"'";
		ResultSet rs = DaoUtil.jdbcSelectWrapper(sql);
		if (rs != null) {

			try {
				while (rs.next()) {
					if (result == null)
						result = new ArrayList<Long>();

					Long i = new Long(rs.getInt(1));
					result.add(i);
				}
				rs.close();
			} catch (SQLException e) {
				LOG.error("sql exception", e);
			}
		}
		return result;

	}

	
	public FlightData getFlightDataForFlight(String flightNumber,
			String flightDate, String originStation, String destinationStation) {
		
		LOG.info("Getting flight info for "+flightNumber+" date="+flightDate+" origin="+originStation+" dest="+destinationStation);
		FlightData result = null;
		String sql = "select id, flight_number, origin_location, destination_location, departure_time,arrival_time from flightinfo "
				    + " where flight_number='"+flightNumber+"' and to_char(departure_time,'MM/DD/YYYY') = '"+flightDate+"'"
				    + " and origin_location='"+originStation+"'"
	    			+ " and destination_location='"+destinationStation+"'";
		
		ResultSet rs = DaoUtil.jdbcSelectWrapper(sql);
		if (rs != null) {

			try {
				if (rs.next()) {
					// TODO: beautify what you are passing so the view can display nicely easily (such as translate that YVR to Vancouver)
					result = new FlightData();
					result.setFlightID(rs.getLong(1));
					result.setFlightNumber(rs.getString(2));
					result.setOriginStation(rs.getString(3));
					result.setDestinationStation(rs.getString(4));
					
					Timestamp ts1 = rs.getTimestamp(5);
					Timestamp ts2 = rs.getTimestamp(6);
					LOG.info("departure time:"+ts1);
					LOG.info("arrival time:"+ts2);
					
					result.setDepartureDate(ts1);
					result.setArrivalDate(ts2);
				}
				rs.close();
			} catch (SQLException e) {
				LOG.error("sql exception", e);
			}
		}
		return result;
	}
	

	private long findCustomerIDByUserName(String userName) {
		String sql = "select customer_id from blc_customer where user_name='"+userName+"'";
		long result = 0;
		ResultSet rs = DaoUtil.jdbcSelectWrapper(sql);
		try {
			if (rs.next()) {
				result = rs.getLong(1);
			}
			rs.close();
		} catch (SQLException e) {
			LOG.error("sql exception", e);
		}
		return result;
	}
	
	/**
	 * This method is to be called by auto login, to create user on the fly
	 */
	public void insertNewCustomer(String lastName, String firstName, String email, String flightNumber, String flightDateParameter, String originStation, String destinationStation) {

		long customerID = findCustomerIDByUserName(email);

		if (customerID==0) {
			
			customerID = DaoUtil.newSequenceForTable("blc_customer","customer_id");
	
			String newCustomerSQL = "insert into blc_customer (customer_id,deactivated,email_address,first_name,last_name,password,password_change_required,is_registered,user_name) values ("
					+ customerID
					+ ','
					+ "'f','"
					+ email
					+ "','"
					+ firstName
					+ "','"
					+ lastName
					+ "','Welcome1{"+customerID+"}',"
					+ "'f','t','"
					+ email+"')";
			LOG.info("sql=" + newCustomerSQL);
			DaoUtil.jdbcInsertUpdateWrapper(newCustomerSQL);
		}
		//---------------------------------
		
		LOG.info("The flight date I am getting from parameter is:"+flightDateParameter);
		
		String dateFormatForDB = "MM/dd/yyyy";
		SimpleDateFormat sdf = new SimpleDateFormat(Constants.FLIGHT_DATE_FORMAT_FROM_EMAIL_LINK);
		
		SimpleDateFormat sdfForDB = new SimpleDateFormat(dateFormatForDB);
		Date flightDate = null;
		String flightDateForDB = flightDateParameter;
		try {
			flightDate = sdf.parse(flightDateParameter);
			LOG.info("flightDate:"+flightDate);
			flightDateForDB = sdfForDB.format(flightDate);
			LOG.info("flightDateForDB:"+flightDateForDB);
		}
		catch (Exception e) {
			flightDate = new Date(); // just so life goes on
			LOG.error("Error parsing flight date",e);
		}

		FlightData f = getFlightDataForFlight(flightNumber, flightDateParameter, originStation, destinationStation);
		long flightID = 0;
		if (f==null) {
			LOG.error("Cannot find flight data: flightNumber:"+flightNumber+" flightDate:"+flightDateParameter+" origin:"+originStation+" destination:"+destinationStation);
		}
		else {
			flightID=f.getFlightID();
		}
		
		int pk = DaoUtil.newSequenceForTable("customer_flight");
		String sql = "insert into customer_flight (id,customer_id, FLIGHT_NUMBER, FLIGHT_DATE, ORIGIN_STATION, DESTINATION_STATION, FLIGHT_ID) values ("
				+pk+","+ customerID + ",'" + flightNumber+"',to_date('"+flightDateForDB+"','"+dateFormatForDB+"'),'"+originStation+"','"+destinationStation+"',"+flightID+")";
		LOG.info(sql);
		DaoUtil.jdbcInsertUpdateWrapper(sql);

	}

	/**
	 * Meal Select has no billing address
	 * so we update the fulfillment group so a billing address is defined, also the shipping fee (4 means Free shipping) 
	 */
	public void insertBlankAddressToOrder(long orderID) {
		String sql = "update blc_fulfillment_group set fulfillment_option_id=4, address_id=0 where order_Id="+orderID;
		DaoUtil.jdbcInsertUpdateWrapper(sql);
	}

	/**
	 * Store the order number for meal selection (so the confirmation email can find the flight that is associated) 
	 */

	public void saveFlightInfoForOrder(long customerID, String flightID, String orderNumber) {
		String sql = "update CUSTOMER_FLIGHT set MEAL_ORDER_NUMBER='"+orderNumber+"' WHERE customer_id="+customerID+" and flight_id="+flightID;
		DaoUtil.jdbcInsertUpdateWrapper(sql);
	}

	public FlightData getFlightInfoFromMealOrder(String orderNumber) {
		
		LOG.info("getFlightInfoFromMealOrder, orderNumber:"+orderNumber);
		String sql = "select FLIGHT_ID from CUSTOMER_FLIGHT where MEAL_ORDER_NUMBER='"+orderNumber+"'";
		long flightNumber=0;
		ResultSet rs = DaoUtil.jdbcSelectWrapper(sql);
		try {
			if (rs.next()) {
				flightNumber = rs.getLong(1);
			}
			rs.close();
		} catch (SQLException e) {
			LOG.error("sql exception", e);
		}
		LOG.info("The flight was:"+flightNumber);
		
		return getFlightDataForFlightID(flightNumber);
	}
	
	public List<MealSelectionData> getAllMealSelections() {
		String sql = "select blc_customer.last_name, blc_customer.first_name,meal_selection.flight_id,meal_selection.meal_type, blc_sku.name"
				 + " from  meal_selection, blc_customer, blc_sku"
				 + " where  meal_selection.meal_id = blc_sku.default_product_id and meal_selection.customer_id = blc_customer.customer_id";
		
		List<MealSelectionData> result = new ArrayList<MealSelectionData>();

		ResultSet rs = DaoUtil.jdbcSelectWrapper(sql);
		try {
			while (rs.next()) {
				MealSelectionData data = new MealSelectionData();
				data.setLastName(rs.getString(1));
				data.setFirstName(rs.getString(2));
				data.setFlightNumber(rs.getString(3));
				data.setMealType(rs.getString(4));
				data.setMealName(rs.getString(5));
				result.add(data);
			}
			rs.close();
		} catch (SQLException e) {
			LOG.error("sql exception", e);
		}
		return result;
		
	}


	@Override
	public FlightData getFlightDataForFlightID(long flightID) {
		LOG.info("Getting flight info for ID:"+flightID);
		FlightData result = null;
		String sql = "select id, flight_number, origin_location, destination_location, departure_time,arrival_time from flightinfo "
				    + " where id="+flightID;
		
		ResultSet rs = DaoUtil.jdbcSelectWrapper(sql);
		if (rs != null) {

			try {
				if (rs.next()) {
					// TODO: beautify what you are passing so the view can display nicely easily (such as translate that YVR to Vancouver)
					result = new FlightData();
					result.setFlightID(rs.getLong(1));
					result.setFlightNumber(rs.getString(2));
					result.setOriginStation(rs.getString(3));
					result.setDestinationStation(rs.getString(4));
					
					Timestamp ts1 = rs.getTimestamp(5);
					Timestamp ts2 = rs.getTimestamp(6);

					result.setDepartureDate(ts1);
					result.setArrivalDate(ts2);
				}
				rs.close();
			} catch (SQLException e) {
				LOG.error("sql exception", e);
			}
		}
		return result;

	}
}
