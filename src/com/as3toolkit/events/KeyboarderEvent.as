/*
* KeyboarderEvent Class
* by Joe Pietruch
* 
* Used in combination with com.as3toolkit.ui.Keyboarder
* Augments Flash's existing KeyboardEvent by adding
* two important events:
*
* 1 - FIRST_PRESS event - fired on first KEY_DOWN
*     ( and does not fire again until that key has a KEY_UP )
*
* 2 - RELEASE event - fired like KEY_UP, but with duration held
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

package com.as3toolkit.events {
	
	import flash.events.Event;
	
	public class KeyboarderEvent extends Event {
		
		// KeyboarderEvent CONSTANTS
		public static const FIRST_PRESS:String = "keyJustPressed";
		public static const RELEASE:String = "keyReleased";
		
		// which key was pressed?
		public var keyCode:int;
		
		// how long was it held?
		public var duration:Number;
		
		public function KeyboarderEvent(atype:String, akc:int, adur:Number = 0):void
		{
			// pass the Event type along to the superclass
			// store which key was pressed/released
			// store 0 or the duration of the hold
			super(atype);
			keyCode = akc;
			duration = adur;
		}
		
	}
	
}