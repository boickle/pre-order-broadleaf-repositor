package com.mycompany.pops.pojo;

import java.util.List;

public class Passenger extends PopsCustomer{
	private String displayName;

	private List<Meal> mealSelection;

	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	public List<Meal> getMealSelection() {
		return mealSelection;
	}

	public void setMealSelection(List<Meal> mealSelection) {
		this.mealSelection = mealSelection;
	}
	
}
