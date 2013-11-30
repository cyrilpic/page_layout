/*
 * Author: Lucas Pelegrino
 */

(function(){

	var watchObj = new (function(){
		var self = this, history = [];
		
		this.fn = {};
		
		this.setup = function(selector, setupFn, useEach){
			var $this, $_this;
			
			if(useEach){
				$_this = $(selector).each(function(index){
					$this = $(this);
					$this.index = index;
					setupFn.call($this, self.fn);
				});
			}else{
				$_this = $this = $(selector);
				setupFn.call($this, self.fn);
			}
			
			$_this = initialize($_this.data('__app', true), {setupFn: setupFn, useEach: useEach});
			history.push($_this)
		}
		
		function initialize(els, opts){
			els.__app = opts;
			return els;
		}
		
		setInterval(function(){
			for(var i in history){
				var his = history[i], current = initialize($(his.selector), his.__app);

				if(current.length != his.length){
					current.each(function(index){
						var $this = $(this), thisArg;
						
						if(!$this.data('__app')){
							thisArg = (his.__app.useEach ? initialize($this, his.__app) : initialize(current.not(his), his.__app));
							his.__app.setupFn.call(thisArg, self.fn);
						}
					});
					history[i] = current.data('__app', true);
				}
			}
		}, 350);
		
	});

	$.fn.watch = function(setupFn, useEach){
		watchObj.setup(this.selector, setupFn, useEach);
		
		return this;
	};
})();