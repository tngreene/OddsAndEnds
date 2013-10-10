/*
 * Keyboarder Class
 * by Joe Pietruch
 * 
 * Augments Flash's existing Keyboard input by adding
 * three important bits:
 *
 * 1 - FIRST_PRESS event - fired on first KEY_DOWN
 *     ( and does not fire again until that key has a KEY_UP )
 *
 * 2 - keyIsDown(aKey:int):Boolean
 *     returns true if aKey is down
 *     returns false if aKey is up or invalid
 *
 * 3 - holdDuration(aKey:int):Number
 *     returns the number of milliseconds aKey has been held down (at the time of calling)
 *     returns 0 if aKey is up or invalid
 * 
 * You may use this for FREE provided:
 *  - this header remains unmodified
 *  - the package remains unmodified
 *  - you consider telling Percipient24@gmail.com what awesome thing you build with this
 *
 * You may alter this code for your own use provided:
 *  - you give Joe Pietruch / Percipient24@gmail.com some acknowledgement
 *  - you consider telling Percipient24@gmail.com what was broken and how you fixed it
 *
 */

package com.as3toolkit.ui {
	
	// relies on KeyboarderEvent for custom event dispatch
	import com.as3toolkit.events.KeyboarderEvent;
	
	import flash.display.DisplayObject;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	
	public class Keyboarder extends EventDispatcher{
		
		// This class is meant to be a STATIC SINGLETON
		private static var _instance:Keyboarder;
		
		// keys is an Array indexed by keyCode
		// it stores Booleans that track the current state of every key
		private static var keys:Array;
		
		// elapsed is an Array indexed by keyCode
		// it stores a Date object for every key that represents when it was last pressed
		private static var elapsed:Array;
		
		// Call Keyboarder.Instance
		public static function get Instance():Keyboarder
		{
			if(!_instance)
			{
				trace("Keyboarder hasn't been created yet!!!");
			}
			return _instance;
		}
		
		// Create the Keyboarder in your document class
		// Pass in any display object that will eventually be on the stage
		// (preferably the document class itself)
		// 
		public function Keyboarder(aDO:DisplayObject):void
		{
			
			// set up all that static stuff
			keys = new Array();
			elapsed = new Array();
			_instance = this;
			
			// see if the supplied DisplayObject is on the stage
			if(aDO.stage != null)
			{
				// if so, we're good to go, set up the KeyboardEvent listeners!
				aDO.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKD);
				aDO.stage.addEventListener(KeyboardEvent.KEY_UP, onKU);
			} else {
				// if not, we need to wait until we can hit the stage
				aDO.addEventListener(Event.ADDED_TO_STAGE, onAdded);
			}
		}
		
		// Called when the constructor's supplied DisplayObject hits the stage
		private function onAdded(e:Event):void
		{
			// now that we can see the stage, set up those KeyboardEvent listeners
			(e.target as DisplayObject).stage.addEventListener(KeyboardEvent.KEY_DOWN, onKD);
			(e.target as DisplayObject).stage.addEventListener(KeyboardEvent.KEY_UP, onKU);
		}
		
		// Called whenever a key is pressed
		// Dispatches a KeyboarderEvent.FIRST_PRESS if this is the first press of the given key
		private function onKD(e:KeyboardEvent):void
		{
			
			// if the pressed key wasn't down
			if(keys[e.keyCode] != true)
			{
				// set that key to true
				// store the initial press time and
				// fire off a KeyboarderEvent.FIRST_PRESS
				keys[e.keyCode] = true;
				elapsed[e.keyCode] = new Date();
				dispatchEvent(new KeyboarderEvent(KeyboarderEvent.FIRST_PRESS, e.keyCode));
			}
		}
		
		// Called whenever a key is released
		// Dispatches a KeyboarderEvent.RELEASE
		private function onKU(e:KeyboardEvent):void
		{
			// reset the key to false
			// dispatch the KeyboarderEvent.RELEASE (with the hold duration!)
			// reset the hold duration
			keys[e.keyCode] = false;
			dispatchEvent(new KeyboarderEvent(KeyboarderEvent.RELEASE, e.keyCode, holdDuration(e.keyCode)));
			elapsed[e.keyCode] = null;
		}
		
		// Call this to check if a particular keyIsDown()
		// returns true if aKey is pressed
		// returns false if aKey is up or invalid
		public static function keyIsDown(aKey:int):Boolean
		{
			// check if aKey is invalid, otherwise
			// return appropriately
			if(aKey < 0) { return false; }
			return keys[aKey]?true:false;
		}
		
		// Call this to check how long (if at all) a particular key has been held
		// returns 0 of aKey is up or invalid
		// returns Number of milliseconds the key has been held
		public static function holdDuration(aKey:int):Number
		{
			//check if aKey is invalid, if so return 0
			if(aKey < 0) { return 0; }
			
			// store the current Date
			// get the Date when the aKey was pressed
			var now:Date = new Date();
			var then:Date = elapsed[aKey];
			
			// if the key is down (then != null)
			if (then)
			{
				// return the duration of the press
				return now.getTime() - elapsed[aKey].getTime();
			} else {
				// otherwise return 0
				return 0;
			}
		}
		
	}
	
}