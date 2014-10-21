package com.mycompany.pops;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sun.rowset.CachedRowSetImpl;

public class DaoUtil {

	protected static final Log LOG = LogFactory.getLog(DaoUtil.class);

	public static String getFlightNumberFromRequest(HttpServletRequest request) {
		String result = null;
		try {
			result = request.getSession().getAttribute("flight").toString();
		} catch (Exception e) {
			// do not have flight number, hmmm
			LOG.info("cannot find flight number from session");
		}
		return result;
	}

	// Poor man's way to try to find next sequence
	public static int newSequenceForTable(String tablename) {

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

	public static int newSequenceForTable(String tablename, String id_field) {

		int maxID = 0;

		String sql = "SELECT MAX(" + id_field + ") FROM " + tablename;

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

	public static ResultSet jdbcSelectWrapper(String sql) {
/*		try {
			LOG.info("sql=" + sql);

			RowSetFactory rowSetFactory = RowSetProvider.newFactory();
			JdbcRowSet rowSet = rowSetFactory.createJdbcRowSet();

			// Set connection properties
			 rowSet.setUrl(Constants.JDBC_CONNECTION);
			 rowSet.setUsername(Constants.JDBC_LOGIN);
			 rowSet.setPassword(Constants.JDBC_PASSWORD);
//			rowSet.setDataSourceName(Constants.JNDI_DATASOURCE);
			// Set SQL Query to execute
			rowSet.setCommand(sql);
			rowSet.execute();
			return rowSet;
		} catch (Exception e) {
			// Handle errors for Class.forName
			LOG.error("rowset problem", e);
		}
*/
		
		Connection conn = null;
		Statement stmt = null;
		try {
			LOG.info("Trying tomcat jndi cached rowset...");
			LOG.info("sql=" + sql);
			
//			Class.forName(Constants.JDBC_DRIVER);
			Context initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env");

			// Look up our data source
			DataSource ds = (DataSource) envCtx.lookup("jdbc/web");
			conn = ds.getConnection();
			
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			
			CachedRowSetImpl crs = new CachedRowSetImpl();
			crs.populate(rs);
			
			rs.close();
			return crs;
			 

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
		return null;
	}

	/**
	 * TODO: turn this to prepared statement for better security
	 * TODO: try not to use constants (instead use values in configuration file)
	 * @param sql
	 */
	public static void jdbcInsertUpdateWrapper(String sql) {
		Connection conn = null;
		Statement stmt = null;
		try {
			
			LOG.info("Trying insert/update with JNDI");

			Context initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env");

			// Look up our data source
			DataSource ds = (DataSource) envCtx.lookup("jdbc/web");
			conn = ds.getConnection();

			LOG.info("Connected database successfully...");

			stmt = conn.createStatement();

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

}
