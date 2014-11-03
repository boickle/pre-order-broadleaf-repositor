package com.mycompany.pops.exceptions;

@SuppressWarnings("serial")
public class FlightDoesNotExistException extends Exception{
	 public FlightDoesNotExistException(String message) {
        super(message);
    }
}
