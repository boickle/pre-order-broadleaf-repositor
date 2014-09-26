/* UI Controller
 *
 * Global UI controller
 * 
*/
window.UI = {
	
	viewName: '',
	
	header: null,
	footer: null,
	
	navigationButton: null,
	categoryNavigation: null,
	
	init: function(viewName) {
		
		var $this = this;
		
		this.header = $("#header");
		this.footer = $("#footer");
		
		this.viewName = viewName;
		
		$(document.body).addClass(this.viewName);		
		
	}
	
}