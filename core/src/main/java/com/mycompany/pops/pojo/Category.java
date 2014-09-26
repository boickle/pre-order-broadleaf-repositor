package com.mycompany.pops.pojo;

import java.util.List;

public class Category {

	private int category_id;
	private String name;
	private String url;
	private String imageURL;

	private List<Category> children;

	public int getCategory_id() {
		return category_id;
	}
	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}
	public String getName() {
		return name;
	}
	
	// I know this isn't so pretty but thymeleaf does not allow html within the th:utext
	public String getNameWithArrowStyle() {
		return "<i class=\"fa fa-caret-right\"></i> "+name; 
	}
	
	public void setName(String name) {
		this.name = name;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public List<Category> getChildren() {
		return children;
	}
	public void setChildren(List<Category> children) {
		this.children = children;
	}
	public String getImageURL() {
		return imageURL;
	}
	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}	
}
