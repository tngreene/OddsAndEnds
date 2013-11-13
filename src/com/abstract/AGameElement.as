package com.abstract
{
	import flash.display.MovieClip;
	import com.abstract.AGameManager;
//Created by Theodore "Ted" Greene

	//Abstract class that all game elements must inhent from
	public class AGameElement extends MovieClip
	{
		// velocities
		public var dx:Number;
		public var dy:Number;
		// accelerations
		public var ax:Number;
		public var ay:Number;
		
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
		
		protected var _gameManager:AGameManager;
		public function AGameElement(aGameManager:AGameManager) 
		{
			// constructor code
			//trace(this + " created");
			
			super();
			
			_gameManager = aGameManager;
			this.dx = 0;
			this.dy = 0;
			this.ax = 0;
			this.ay = 0;
		}//end constructor
		
		//checks to see if two game elements are colliding, returns true if they are
		/*public function isColliding(firstGE:AGameElement, secondGE:AGameElement):Boolean
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
		}*/
		
		public function get halfWidth():Number
		{
			return Math.floor(this.width / 2);
		}
		public function get halfHeight():Number
		{
			return Math.floor(this.height / 2);
		}
		
		public function get fx():Number
		{
			return this.x + this.fdx;
		}
		public function get fy():Number
		{
			return this.y + this.fdy;
		}
		public function get fdx():Number
		{
			return this.dx + this.ax;
		}
		public function get fdy():Number
		{
			return this.dy + this.ay;
		}
		
		//Not sure if every single game element should have this
		public function get airborne():Boolean
		{
			return this.dy != 0 || this.ay != 0;
		}
		public function init():void
		{
			//overide this
		}
		public function deconstruct():void
		{
			//override this
		}
		public function update():void
		{
			this.dx += this.ax;
			this.dy += this.ay;
			this.x += this.dx;
			this.y += this.dy;
		}
		public final function sweepTestCollision(target:AGameElement):Object
		{
			var ret:Object = new Object();
			ret["collision"] = false;
			var rdx:Number = this.fdx - target.fdx;
			var rdy:Number = this.fdy - target.fdy;
			
			var xDist:Number = this.fx - target.x;
			var yDist:Number = this.fy - target.y;
			var xRadius:Number = (this.halfWidth + target.halfWidth);
			var yRadius:Number = (this.halfHeight + target.halfHeight);
			
			if (rdx == 0)
			{
				var yTime:Number = (target.y - this.y) / rdy;
				var yTimeMin:Number = Math.min(yTime + yRadius / rdy, yTime - yRadius / rdy);
				if (yTimeMin >= 0 && yTimeMin < 1 && Math.abs(xDist) < xRadius)
				{
					ret["collision"] = true;
					ret["direction"] = "y";
					ret["time"] = yTimeMin;
				}
				
			} else if (rdy == 0)
			{
				var xTime:Number = (target.x - this.x) / rdx;
				var xTimeMin:Number = Math.min(xTime + xRadius / rdx, xTime - xRadius / rdx);
				if (xTimeMin >= 0 && xTimeMin < 1 && Math.abs(yDist) < yRadius)
				{
					ret["direction"] = "x";
					ret["time"] = xTimeMin;
					ret["collision"] = true;
				}
			} else
			{
				xTime = (target.x - this.x) / rdx;
				yTime = (target.y - this.y) / rdy;
				
				xTimeMin = Math.min(xTime + xRadius / rdx, xTime - xRadius / rdx);
				yTimeMin = Math.min(yTime + yRadius / rdy, yTime - yRadius / rdy);
				if (xTimeMin < 1 && yTimeMin < 1)
				{
					var xTimeMax:Number = Math.max(xTime + xRadius / rdx, xTime - xRadius / rdx); 
					var yTimeMax:Number = Math.max(yTime + yRadius / rdy, yTime - yRadius / rdy);
					
					if (xTimeMin < yTimeMax && yTimeMin < xTimeMax)
					{
						if ((xTimeMin <= yTimeMin || yTimeMin < 0) && xTimeMin >= 0 )
						{
							ret["direction"] = "x";
							ret["time"] = xTimeMin;
							ret["collision"] = true;
						} else if(yTimeMin >= 0)
						{
							ret["direction"] = "y";
							ret["time"] = yTimeMin;
							ret["collision"] = true;
						}
					}
				}
			}
			return ret;
		}
		
	}//end class

}//end package
