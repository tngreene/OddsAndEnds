package com.objects 
{
	import flash.display.MovieClip;
	import com.layers.Layer;
	
	public class GameObject extends MovieClip
	{
		// layer its sitting in
		private var _parent:Layer;
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

	}
	
}
