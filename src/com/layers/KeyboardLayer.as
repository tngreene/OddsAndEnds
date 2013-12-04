package com.layers
{
	import com.screens.GameScreen;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.MovieClip;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	// layer used to watch key presses
	// uses mediator to be requested
	// provides old style iskeydown functionality
	public class KeyboardLayer extends Layer
	{
		// objects map string keys to values
		private var _keys:Object = new Object();
		
		//Event name for dispatcher
		public const QUICK_PRESS = "QUICK_PRESS";
		public const LAST_KEY = "LAST_KEY";
		
		//The time between keydown and keyup
		private var _timeBetween:Number;
		public function get timeBetween():Number
		{
			return _timeBetween;
		}
		
		//The time since the last keyUp event
		private var _sinceLastPress:Number;
		public function get sinceLastPress():Number
		{
			return _sinceLastPress;
		}
		
		//The last key(code) that was pressed
		private var _lastKeyPressed:uint;
		public function get LastKeyPressed():uint
		{
			return _lastKeyPressed;
		}
		
		//--consider removing
		public function get keys():Object
		{
			return _keys;
		}
		//--------------------
		
		
		// initializes key map
		public function KeyboardLayer(_parent:GameScreen) 
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
			stage.addEventListener(QUICK_PRESS, isQuickPress);
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
			//Start the timer over
			_timeBetween = getTimer();
			trace("Keydown time: " + _timeBetween);
			this._keys[evt.keyCode] = true;
		}
		
		// flags false the key released
		public function handleKeyUp(evt:KeyboardEvent):void
		{
			//now get the final time again
			var finalTime = getTimer();
			//trace("finalTime = " + finalTime);
			//time inbetween handleKeyDown/Up is
			//The final - initial
			_timeBetween = finalTime - _timeBetween;
			//trace("keyup time between: " + _timeBetween);
			_sinceLastPress = getTimer();
			
			_lastKeyPressed = evt.keyCode;
			dispatchEvent(new Event(LAST_KEY,true));
			trace(_lastKeyPressed);
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
		
		//Tests to see if it is a quick press
		private function isQuickPress(e:Event)
		{
			//If the time was within a few milliseconds
			
			dispatchEvent(QUICK_PRESS);
		}
	}
	
}
