package com.abstract 
{
//Created by Theodore "Ted" Greene
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class AUIElement extends MovieClip
	{
		protected var _gameManager:AGameManager;
		public function AUIElement(aGameManager:AGameManager) 
		{
			// constructor code
			//trace(this + " created");
			super();
			
			_gameManager = aGameManager;
		}//end constructor

	}//end class

}//end package
