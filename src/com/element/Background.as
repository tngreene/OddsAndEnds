package com.element
{
	import com.abstract.AGameManager;
	import com.abstract.AGameElement;

	// Reprents the player clip
	// does its own velocity and position calculations
	public class Background extends AGameElement 
	{
		//Represents what background the movie clip is
		//similar to pose
		private var _backName:String;
		
		public function Background(pGameManager:AGameManager, backName:String) 
		{
			super(pGameManager);
			this._backName = backName;//Eventually will be stored in the xml
		}
		public override function init():void
		{
			
		}
		public override function deconstruct():void
		{
			
		}
		public override function update():void
		{
			super.update();//Not sure how this line works
		}
		
		//Changes the background by advancing to a certain frame
		//implemented as a function instead of setter so more code could be
		//fit in
		public function changeBackground(nextSlide:String):void
		{
			this._backName = nextSlide;
			gotoAndStop(nextSlide);
			//potential code
			//checking for invalid input,
			//transitions
			//effects
			//etc
		}
	}
}
