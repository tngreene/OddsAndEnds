package com.objects 
{
	import flash.display.MovieClip;
	import com.layers.Layer;
	import flash.geom.Point;
	
	public class GameObject extends MovieClip
	{
		// layer its sitting in
		protected var _parent:Layer;
		// flags the gameobject to be a moving game object
		// this means it rounds its x and y position to the nearest whole number
		// this should fix most collision errors
		protected var _moves:Boolean = false;
		// velocities
		public var dx:Number;
		public var dy:Number;
		// accelerations
		public var ax:Number;
		public var ay:Number;

		public function GameObject(_parent:Layer) 
		{
			this._parent = _parent;
			this._parent.addChild(this);
			this.dx = 0;
			this.dy = 0;
			this.ax = 0;
			this.ay = 0;
		}
		public function kill():void
		{
			this._parent.removeChild(this);
			this._parent = null;
		}
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
			return Math.round((this.dx + this.ax) * 100) / 100;
		}
		public function get fdy():Number
		{
			return Math.round((this.dy + this.ay) * 100) / 100;
		}
		public function distanceTo(go:GameObject)
		{
			return Math.sqrt(Math.pow((go.x - this.x), 2) + Math.pow((go.y - this.y), 2) ); 
		}
		public function get airborne():Boolean
		{
			return this.dy != 0 || this.ay != 0;
		}
		// update velocities and position
		public function onFrame()
		{
			this.dx += this.ax;
			this.dy += this.ay;
			this.x += this.dx;
			this.y += this.dy;
		}
		public final function sweepTestCollision(target:GameObject):Object
		{
			var ret:Object = new Object();
			ret["collision"] = false;
			var rdx:Number = this.fdx - target.fdx;
			var rdy:Number = this.fdy - target.fdy;
			ret["rdx"] = rdx;
			ret["rdy"] = rdy;
			
			
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
		
		public function lineIntersect(start:Point, finish:Point):Boolean
		{
			var mLine:Number = (finish.y - start.y) / (finish.x - start.x);
			var bLine:Number = start.y - mLine * start.x;
			
			var left:Number = this.x - this.halfWidth;
			var right:Number = this.x + this.halfWidth;
			var top:Number = this.y - this.halfHeight;
			var bottom:Number = this.y + this.halfHeight;
			
			var leftIntersectY = left * mLine + bLine;
			var rightIntersectY = right * mLine + bLine;
			
			var topIntersectX = (top - bLine) / mLine;
			var bottomIntersectX = (bottom - bLine) / mLine;
			
			if (leftIntersectY <= top && leftIntersectY >= bottom && leftIntersectY <= Math.max(finish.y, start.y) && leftIntersectY >= Math.min(finish.y, start.y))
			{
				return true;
			}
			if (rightIntersectY <= top && rightIntersectY >= bottom && rightIntersectY <= Math.max(finish.y, start.y) && rightIntersectY >= Math.min(finish.y, start.y))
			{
				return true;
			}
			
			
			if (topIntersectX <= top && topIntersectX >= bottom && topIntersectX <= Math.max(finish.x, start.x) && topIntersectX >= Math.min(finish.x, start.x))
			{
				return true;
			}
			if (bottomIntersectX <= bottom && bottomIntersectX >= bottom && bottomIntersectX <= Math.max(finish.x, start.x) && bottomIntersectX >= Math.min(finish.x, start.x))
			{
				return true;
			}
			
			return false;
		}
		public override function get x():Number
		{
			if (this._moves)
				return Math.round(super.x);
			else
				return super.x;
		}
		public override function get y():Number
		{
			if (this._moves)
				return Math.round(super.y);
			else
				return super.y;
		}
	}
	
}
