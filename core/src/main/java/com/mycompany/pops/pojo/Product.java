package com.mycompany.pops.pojo;

public class Product {

	private long product_ID;
	private String manufacture;
	private String url;
	private String name;
	private String description;
	private double retail_price;


	private String imageUrl;

	public long getProduct_ID() {
		return product_ID;
	}

	public void setProduct_ID(long product_ID) {
		this.product_ID = product_ID;
	}

	public String getManufacture() {
		return manufacture;
	}

	public void setManufacture(String manufacture) {
		this.manufacture = manufacture;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getRetail_price() {
		return retail_price;
	}

	public void setRetail_price(double retail_price) {
		this.retail_price = retail_price;
	}
	
	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
}
