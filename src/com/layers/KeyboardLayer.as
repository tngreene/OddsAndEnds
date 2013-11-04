/*package com.layers
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.MovieClip;
	
	// layer used to watch key presses
	// uses mediator to be requested
	// provides old style iskeydown functionality
	public class KeyboardLayer extends Layer
	{
		// objects map string keys to values
		private var _keys:Object = new Object();
		
		// initializes key map
		public function KeyboardLayer(_parent:MovieClip) 
		{
			super(_parent);
			this._keys = new Object();
		}
		
		// setups keyboard listeners
		public override function setup(mediator:LayerMediator):Boolean
		{
			super.setupMediator(mediator, "keyboard");
			stage.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
			return true;
		}
		//removes keyboard listeners
		public override function kill():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
		}
		
		// flags true the key pressed
		public function handleKeyDown(evt:KeyboardEvent):void
		{
			this._keys[evt.keyCode] = true;
		}
		
		// flags false the key released
		public function handleKeyUp(evt:KeyboardEvent):void
		{
			this._keys[evt.keyCode] = false;
		}
		
		// shows whether the key is pressed
		public function isKeyDown(key:int):Boolean
		{
			return this._keys[key];
		}
		
		// shows whether the key is not pressed
		public function isKeyUp(key:int):Boolean
		{
			return !this._keys[key];
		}
	}
}*/
