/* 
 * Category Navigation UI
 * 
 * Handles the category navigation
 * 
*/

$(function() {
	
	Countdown.init(600);
			
});

window.Countdown = {
	
	timeAmount: 0,
	
	miuntes: 0,
	seconds: 0,
	
	frequency:1,
	
	
	init: function(timeAmount) {
		
		this.timeAmount = timeAmount;
	
		this.calculateTimeRemaining();
		
		var $this = this;
		
   		setInterval(function() {
   			$this.calculateTimeRemaining();
   		}, 1000)
   		
   		setInterval(function() {
   			$("#timeLeft").text($this.minutes + ":" + $this.seconds);
   		}, 1000)
       		
      	
        
	},
	
	calculateTimeRemaining: function() {
		
		if(this.timeAmount<=0) {
			return false;
		}
		
		this.timeAmount--;

		this.minutes = Math.floor(this.timeAmount / 60);
		
		var mins = this.timeAmount / 60;

		var remainder = mins - this.minutes;
		
		this.seconds = Math.round(60 * remainder);
		
		if(this.seconds<10) {
			this.seconds = "0" + this.seconds;
		}

	}
	
}
	
	
