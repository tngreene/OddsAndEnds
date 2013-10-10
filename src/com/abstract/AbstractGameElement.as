package com.abstract
{
	import flash.display.MovieClip;
	import com.abstract.AbstractGameManager;
//Created by Theodore "Ted" Greene

	//Abstract class that all game elements must inhent from
	public class AbstractGameElement extends MovieClip
	{
		//velocities of x,y, rotations
		public var vx:Number;
		public var vy:Number;
		
				/*
		   Left and right are used for scaling when reversing directions
		   as well as movement, make sure all fish are pointing to the right or they will always move backwards
				     Up(-1)
			            |
			Left(-1)--------Right(1)
		                |
			        Down(1)
		*/
		protected static const DIRECTION_L:int =-1;
		protected static const DIRECTION_U:int =-1;
		protected static const DIRECTION_R:int =1;
		protected static const DIRECTION_D:int =1;
		
		protected var _gameManager:AbstractGameManager;
		public function AbstractGameElement(aGameManager:AbstractGameManager) 
		{
			// constructor code
			//trace(this + " created");
			
			super();
			
			_gameManager = aGameManager;
		}//end constructor
		
		//checks to see if two game elements are colliding, returns true if they are
		//to check if a Fish is colliding with the net you would put the fish in the first and net in the second
		public function isColliding(firstGE:AbstractGameElement, secondGE:AbstractGameElement):Boolean
		{
			//If the first game element is colliding with the second
			if(firstGE.hitTestObject(secondGE))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
	
	}//end class

}//end package
