package com.manager
{
	import com.abstract.AGameManager;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.MovieClip;
	
	// layer used to watch key presses
	// uses mediator to be requested
	// provides old style iskeydown functionality
	public class KeyboardManager extends AGameManager
	{
		// objects map string keys to values
		private var _keys:Object = new Object();
		
		// initializes key map
		public function KeyboardManager(pMainGame:MainGame) 
		{
			super(pMainGame);
			this._keys = new Object();
		}
		
		// setups keyboard listeners
		public override function init():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
		}
		//removes keyboard listeners
		public override function deconstruct():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
		}
		
		public override function update()
		{
			
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
	
}
