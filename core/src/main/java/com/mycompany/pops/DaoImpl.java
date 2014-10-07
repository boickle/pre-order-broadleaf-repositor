package com.mycompany.pops;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.sql.rowset.JdbcRowSet;
import javax.sql.rowset.RowSetFactory;
import javax.sql.rowset.RowSetProvider;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.pops.domain.FlightInfo;
import com.mycompany.pops.pojo.Category;
import com.mycompany.pops.pojo.Meal;
import com.mycompany.pops.pojo.Product;

@Repository("blDao")
public class DaoImpl implements Dao {
	protected static final Log LOG = LogFactory.getLog(Dao.class);

	// TODO get handle to EntityManager so we can use hibernate instead of good
	// old JDBC
	@PersistenceContext(unitName = "blPU")
	protected EntityManager em;

	// ---------------------------------

	@Transactional(value = "blTransactionManager")
	@Override
	public void insertFlight(FlightInfo info) {

		LOG.info("Inside Insert New Flight");
		LOG.info("Here you go: " + info.getFlightNumber() + " "
				+ info.getDepartureLocation() + "->"
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

	// Poor man's way to try to find next sequence
	private int newSequenceForTable(String tablename) {

		int maxID = 0;

		String sql = "SELECT MAX(id) FROM " + tablename;
		ResultSet rs = jdbcSelectWrapper(sql);
		try {
			if (rs.next()) {
				maxID = rs.getInt(1);			
			}
			rs.close();
		} catch (SQLException e) {
			LOG.error("sql exception", e);
		}

		return maxID + 1;
	}

	private JdbcRowSet jdbcSelectWrapper(String sql) {
		try {
			LOG.info("sql=" + sql);

			RowSetFactory rowSetFactory = RowSetProvider.newFactory();
			JdbcRowSet rowSet = rowSetFactory.createJdbcRowSet();

			// Set connection properties
			//rowSet.setUrl(Constants.JDBC_CONNECTION);
			//rowSet.setUsername(Constants.JDBC_LOGIN);
			//rowSet.setPassword(Constants.JDBC_PASSWORD);
			rowSet.setDataSourceName(Constants.JNDI_DATASOURCE);
			// Set SQL Query to execute
			rowSet.setCommand(sql);
			rowSet.execute();
			return rowSet;
		} catch (Exception e) {
			// Handle errors for Class.forName
			LOG.error("rowset problem", e);
		}

		return null;
	}

	private void insertFlightUsingGoodOldJDBC(FlightInfo info) {
		LOG.info("good old JDBC");
		Connection conn = null;
		Statement stmt = null;
		try {
			Class.forName(Constants.JDBC_DRIVER);

			conn = DriverManager.getConnection(Constants.JDBC_CONNECTION,
					Constants.JDBC_LOGIN, Constants.JDBC_PASSWORD);

			LOG.info("Connected database successfully...");

			LOG.info("Inserting record into the table...");
			stmt = conn.createStatement();

			int num = newSequenceForTable("FLIGHTINFO");

			String sql = "INSERT INTO FLIGHTINFO (ID,FLIGHT_NUMBER, departure_location, DESTINATION_LOCATION) VALUES ("
					+ num
					+ ','
					+ "'"
					+ info.getFlightNumber()
					+ "',"
					+ "'"
					+ info.getDepartureLocation()
					+ "',"
					+ "'"
					+ info.getDestinationLocation() + "')";

			LOG.info("sql=" + sql);
			stmt.executeUpdate(sql);
			LOG.info("Inserted record into the table...");

		} catch (Exception e) {
			// Handle errors for Class.forName
			LOG.error("jdbc problem", e);
		} finally {
			// finally block used to close resources
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException se) {
			}// do nothing
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException se) {
				LOG.error("jdbc problem", se);
			}// end finally try
		}// end try

	}

	// Temporary... cause there are no pictures tied to categories 
	private String categoryNameToImage(String name) {
		return name.toLowerCase().replaceAll(" ", "-").replaceAll("\\?", "");
	}

	/**
	 * See the table blc_translation
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
		ResultSet rs = jdbcSelectWrapper(sql);
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

	public List<Category> getCategories(long parentID, String locale) {
		LOG.info("trying to get categories with parent = " + parentID);
		List<Category> result = null;

		String sql = "SELECT category_id,name,url from blc_category where "
				+ " not (archived IS NOT NULL and archived='Y') "
				// + check for active date range here
				+ " and default_parent_category_id = " + parentID
				+ " order by category_id";

		ResultSet rs = jdbcSelectWrapper(sql);
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

		ResultSet rs = jdbcSelectWrapper(sql);
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
		ResultSet rs = jdbcSelectWrapper(sql);
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
		ResultSet rs = jdbcSelectWrapper(sql);
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
		ResultSet rs = jdbcSelectWrapper(sql);
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

		ResultSet rs = jdbcSelectWrapper(sql);
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

	public List<Product> getMealsForFlight(String flightNumber,
			String mealType, String locale) {
		LOG.info("trying to find meals for flight: " + flightNumber + " type:"
				+ mealType);
		List<Product> result = null;

		String sql = "select product_id,manufacture,blc_product.url,retail_price,name,long_description,blc_media.url"
				+ " from blc_product, blc_sku, blc_sku_media_map, blc_media, flight_meal"
				+ " where blc_product.product_id=meal_id"
				+ " and sku_id = default_sku_id and sku_id = blc_sku_sku_id and blc_sku_media_map.media_id = blc_media.media_id"
				+ " and map_key='primary'"
				+ " and flight_number='"
				+ flightNumber + "'" + " and meal_type='" + mealType + "'";

		ResultSet rs = jdbcSelectWrapper(sql);
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

	public void saveMealSelection(long customerID, String flightNumber,
			long mealID) {
		LOG.info("Saving meal for " + customerID + ", flight:" + flightNumber
				+ " mealID:" + mealID);

		Connection conn = null;
		Statement stmt = null;
		try {
			Class.forName(Constants.JDBC_DRIVER);

			conn = DriverManager.getConnection(Constants.JDBC_CONNECTION,
					Constants.JDBC_LOGIN, Constants.JDBC_PASSWORD);

			LOG.info("Connected database successfully...");

			// First, find out the type of meal that the user already selected
			// (based on the current meal user tries to add)
			// then delete those selection (to remove previously selected meal
			// for the flight)
			// I wish I can send the meal type of the product selected, but this
			// is called by the cart and it only knows product ID

			Statement delstmt = conn.createStatement();

			String delSQL = "delete from meal_selection where meal_id in "
					+ "(select meal_id from flight_meal "
					+ " where flight_number='"
					+ flightNumber
					+ "' "
					+ " and meal_type = (select distinct meal_type from flight_meal where meal_id="
					+ mealID + "))";
			LOG.info("delSQL=" + delSQL);
			delstmt.executeUpdate(delSQL);

			// insert the new selection
			stmt = conn.createStatement();
			int num = newSequenceForTable("MEAL_SELECTION");

			String sql = "INSERT INTO MEAL_SELECTION (ID,CUSTOMER_ID,FLIGHT_NUMBER, MEAL_ID) VALUES ("
					+ num
					+ ','
					+ customerID
					+ ','
					+ "'"
					+ flightNumber
					+ "',"
					+ mealID + ")";

			LOG.info("sql=" + sql);
			stmt.executeUpdate(sql);

			LOG.info("Inserted record into the table...");

		} catch (Exception e) {
			// Handle errors for Class.forName
			LOG.error("jdbc problem", e);
		} finally {
			// finally block used to close resources
			try {
				if (stmt != null)
					conn.close();
			} catch (SQLException se) {
			}// do nothing
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException se) {
				LOG.error("jdbc problem", se);
			}// end finally try
		}// end try

	}

	public List<Meal> getMealsForCustomer(long customerID, String flightNumber) {
		LOG.info("trying to find meals for customer: " + customerID);
		if (customerID == 0)
			return null;

		List<Meal> result = null;
		// Data is stored in MEAL_SELECTION table, need to gather the name and
		// image
		// TODO: should not need to specify flight and avoid wrong rows

		String sql = "select product_id,flight_meal.flight_number,flight_meal.meal_type,blc_sku.name,blc_media.url"
				+ " from blc_product, blc_sku, blc_sku_media_map, blc_media, meal_selection,flight_meal"
				+ " where blc_product.product_id=meal_selection.meal_id"
				+ " and sku_id = default_sku_id and sku_id = blc_sku_sku_id and blc_sku_media_map.media_id = blc_media.media_id and map_key='primary'"
				+ " and flight_meal.meal_id= product_id and meal_selection.customer_id="
				+ customerID
				+ " and flight_meal.flight_number='"
				+ flightNumber + "'";

		ResultSet rs = jdbcSelectWrapper(sql);
		if (rs != null) {

			try {
				while (rs.next()) {
					if (result == null)
						result = new ArrayList<Meal>();

					String the_flightNumber = rs.getString(2);
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
					m.setFlightNumber(the_flightNumber);
					m.setMealType(mealType);

					m.setName(rs.getString(4));
					m.setImageUrl(rs.getString(5));
					m.setDescription(mealTypeSpelled + " on Flight "
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
	
	public List<Long> getAllMealIDForFlight(String flightNumber) {
		LOG.info("Trying to find all meals available for customer for this flight"); 
		// to be used by cart controller so that we don't allow editing

		List<Long> result = null;
		String sql = "select meal_id from flight_meal where flight_number='"+flightNumber+"'";
		ResultSet rs = jdbcSelectWrapper(sql);
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

}
