package com.mycompany.pops.dao;

import com.mycompany.pops.pojo.Transaction;
import com.mycompany.pops.tools.UserToken;

public interface TransactionDao {
	public void insertNewTransaction(UserToken token, Transaction trans);
	public Transaction getTransaction(String token);
	
}
