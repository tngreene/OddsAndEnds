package com.objects
{
	
	import com.layers.Layer;

	// Reprents the player clip
	// does its own velocity and position calculations
	public class Player extends GameObject 
	{
		private var _dir:String;
		public function Player(layer:Layer) 
		{
			super(layer);
			this._dir = "left";
		}
		public override function  get halfHeight():Number
		{
			return 40;
		}
		public override function  get halfWidth():Number
		{
			return 8;
		}
		// reset accelerations
		public function resetAcceleration()
		{
			this.ax = 0;
			this.ay = 0;
		}
		public override function onFrame()
		{
			super.onFrame();
			if (this.dx < 0 )
			{
				this._dir = "left";
			} else if (this.dx > 0)
			{
				this._dir = "right";
				
			}
			if (this.airborne)
				this.gotoAndStop("jump " + this._dir);
			else if (this.dx != 0)
				this.gotoAndStop("run " + this._dir);
			else
				this.gotoAndStop(this._dir);
		}
	}
}
