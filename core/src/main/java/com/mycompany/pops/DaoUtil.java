package com.mycompany.pops;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.sql.rowset.JdbcRowSet;
import javax.sql.rowset.RowSetFactory;
import javax.sql.rowset.RowSetProvider;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

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

	public static JdbcRowSet jdbcSelectWrapper(String sql) {
		try {
			LOG.info("sql=" + sql);

			RowSetFactory rowSetFactory = RowSetProvider.newFactory();
			JdbcRowSet rowSet = rowSetFactory.createJdbcRowSet();

			// Set connection properties
			// rowSet.setUrl(Constants.JDBC_CONNECTION);
			// rowSet.setUsername(Constants.JDBC_LOGIN);
			// rowSet.setPassword(Constants.JDBC_PASSWORD);
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

	/**
	 * TODO: turn this to prepared statement for better security
	 * TODO: try not to use constants (instead use values in configuration file)
	 * @param sql
	 */
	public static void jdbcInsertUpdateWrapper(String sql) {
		Connection conn = null;
		Statement stmt = null;
		try {


			Class.forName(Constants.JDBC_DRIVER);
			conn = DriverManager.getConnection(Constants.JDBC_CONNECTION,
					Constants.JDBC_LOGIN, Constants.JDBC_PASSWORD);

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
