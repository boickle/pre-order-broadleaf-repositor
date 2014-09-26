/* 
 * Category Navigation UI
 * 
 * Handles the category navigation
 * 
*/

$(function() {
	
	Navigation.init();
			
});

window.Navigation = {
	
	isOpen: false,
	
	navigationButton: null,
	globalNavigation: null,
	
	init: function(viewName) {

		var $this = this;
	
		this.globalNavigation = $("#globalNavigation");
		
		this.navigationButton = $("#navigationButton");
		
		//this.hideNavigation();
		
		this.navigationButton.click(function() {
			
			$this.toggleNavigation();
			
		});
		
	},
	
	toggleNavigation: function() {
			
		
		if( this.isOpen  ) {
			
			this.hideNavigation();
			
		} else {
			
			this.showNavigation();
			
		}
		
	},
	
	showNavigation: function() {
				
		this.globalNavigation.show();
		
		this.navigationButton.addClass('active');
		
		this.isOpen = true;
	
	},
	
	hideNavigation: function() {
		
		this.globalNavigation.hide();
		
		this.navigationButton.removeClass('active');

		this.isOpen = false;
		
	}
	
}