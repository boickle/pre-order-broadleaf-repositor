/* Cart
 *
 * Handles the UI and logic of the cart
 * 
*/


$(function() {
		
	Cart.init();

});

window.Cart = {
	
	container: null,
	cartItemList: null,
	cartCounter: null,
	
	button: null,
	
	isOpen: false,
	
	
	init: function() {
		
		var $this = this;
		
		this.container = $("#cartContainer");
		
		this.button = $("#cartButton");
		
		this.cartItemList = $("#cartItemList");
		
		this.cartCounter = $("#cartCounter");
		
		/*this.button.click(function() {
			
			$this.toggleCart();
			
		});*/
		
		this.hideCart();
		this.hideButton();

	},
	
	toggleCart: function() {
		
		if(this.isOpen) {
			
			this.hideCart();
				
		} else {
			
			this.showCart();
			
		}
		
	},
	
	showCart: function() {
	
		this.container.show();
		this.isOpen = true;
		this.button.addClass('active');
				
	},
	
	hideCart: function() {
		
		this.container.hide();
		this.isOpen = false;
		this.button.removeClass('active');
		
	},
	
	showButton: function() {
		
		this.button.show();
		this.button.animo( { animation: 'bounceIn' });
		
	},
	
	hideButton: function() {
		
		this.button.hide();
		
	},
	
	addItem: function(button) {
		
		var $this = this;
		
		var element = $(button);
		
		element.animo( { animation: 'fadeOutUp' }, function() {
			$this.button.animo( { animation: 'tada' });
			document.getElementById('cartAddSound').play();
		});
		
		var newItem = {
			title: element.data("title"),
			itemID: element.data("itemID"),
			price: element.data("price"),
			qty: 1
		}
							
		this.displayItem(newItem);
		
		$('#addedToCart').modal('show');
		
	},
	
	displayItem: function(newItem) {
		
		var cartItem = $('<div class="cartItem"/>').append(
			$('<img class="cartItem-image"/>').attr("src","/img/beauty.jpg"),
			$('<span class="cartItem-title"/>').text(newItem.title),
			$('<span class="cartItem-price"/>').text(newItem.price)
		);
		
		this.cartItemList.append(cartItem);
		
		this.cartCounter.text( this.cartItemList.children().length );
		
		
		
		
	}
	
}