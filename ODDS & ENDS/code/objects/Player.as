package code.objects
{
	
	import flash.display.MovieClip;
	import code.layers.Layer;

	// Reprents the player clip
	// does its own velocity and position calculations
	public class Player extends MovieClip 
	{
		// layer its sitting in
		private var _parent:Layer;
		// velocities
		public var dx:Number;
		public var dy:Number;
		// accelerations
		public var ax:Number;
		public var ay:Number;
		
		public function Player(_parent:Layer) 
		{
			this._parent = _parent;
			this._parent.addChild(this);
			this.dx = 0;
			this.dy = 0;
			this.ax = 0;
			this.ay = 0;
		}
		// update velocities and position
		public function onFrame()
		{
			this.dx += this.ax;
			this.dy += this.ay;
			this.x += this.dx;
			this.y += this.dy;
		}
		// reset accelerations
		public function resetAcceleration()
		{
			this.ax = 0;
		}
	}
}
