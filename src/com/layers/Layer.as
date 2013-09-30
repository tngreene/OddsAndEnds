package com.layers
{
	//stuff
	import flash.display.MovieClip;
	
	// class representing all
	// on screen objects
	// and processing
	public class Layer extends MovieClip
	{
		// parent movieclip of this object
		// usually Document
		protected var _parent:MovieClip;
		// mediator to get in communication
		// with other layers
		protected var _mediator:LayerMediator;
		
		// basic constructor intializing
		// this object to the parent
		public function Layer(_parent:MovieClip) 
		{
			this._parent = _parent;
			this._parent.addChild(this);
		}
		// a dummy parent function to be overriden
		// called once on startup
		public function setup(mediator:LayerMediator):void
		{
			trace("ERROR: wrong setup called");
		}
		// abstracts out functionality thats the same for every layer
		// sets up the mediator, allowing requests to be made
		protected function setupMediator(mediator:LayerMediator, key:String):void
		{
			this._mediator = mediator;
			this._mediator.addLayer(this, key);
		}
		// a dummy parent function to be overriden
		// called every frame
		public function onFrame():void
		{
		}
		// a dummy parent function to be overriden
		// clean up
		// used when the layer is being destroyed
		public function kill():void
		{
			this._parent.removeChild(this);
			this._parent = null;
			this._mediator.removeLayer(this);
			this._mediator = null;
		}
		// a dummy parent function to be overriden
		// used when requests are made to the mediator
		public function fulfill(key:String, target:Layer):void
		{
		}
	}
}
