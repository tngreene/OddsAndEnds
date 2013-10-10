package com.abstract 
{
//Created by Theodore "Ted" Greene
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class AbstractUIElement extends MovieClip
	{
		protected var _gameManager:AbstractGameManager;
		public function AbstractUIElement(aGameManager:AbstractGameManager) 
		{
			// constructor code
			//trace(this + " created");
			super();
			
			_gameManager = aGameManager;
		}//end constructor

	}//end class

}//end package
