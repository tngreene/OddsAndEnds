package com.objects 
{
	
	import com.layers.Layer;
	
	public class Crusher extends GameObject 
	{
		public var delay:Number; // delay at top before a crush starts
		public var crushTime:Number; // duration of the crush
		public var riseTime:Number; // duration of the rise
		public var timeOffset:Number; // the delay before the first crush is done
		public var holdTime:Number; // the time to hold at the bottom
		public var crushDistance:Number; // how far down the crusher goes
		private var time:uint;
		private var state:String;
		public function Crusher(layer:Layer) 
		{
			super(layer);
			this.state = "firstCrush";
			this.time = 0;
		}
		public function setup(gridSize:Number)
		{
			this.x *= gridSize;
			this.y *= gridSize;
			this.crushDistance *= gridSize;
		}
		public function onBreak()
		{
			this.state = "breaking";
			this.time = 0;
		}
		private function eq(x:Number):Number { return -0.1 * x * x + 3 * x; };
		public override function onFrame()
		{
			this.dy = 0;
			switch(this.state)
			{
				case "breaking":
					this.y--;
					if (this.time >= 30)
					{
						this.state = "broken";
						this.time = 0;
					}
					break;
				case "broken":
					this.y -= eq(this.time + 1) - eq(this.time);
					this.alpha -= 0.02;
					if (this.alpha <= 0)
					{
						// kill this
						this._parent.destroy(this);
					}
					break;
				case "firstCrush":
					if (this.time >= this.timeOffset)
					{
						this.state = "crush";
						this.time = 0;
					}
					break;
				case "crush":
					this.dy = this.crushDistance / this.crushTime;
					if (this.time >= this.crushTime)
					{
						this.state = "hold";
						this.time = 0;
					}
					break;
				case "hold":
					if (this.time >= this.holdTime)
					{
						this.state = "rise";
						this.time = 0;
					}
					break;
				case "rise":
					this.dy = -this.crushDistance / this.riseTime;
					
					if (this.time >= this.riseTime)
					{
						this.state = "delay";
						this.time = 0;
					}
					break;
				case "delay":
					if (this.time >= this.delay)
					{
						this.state = "crush";
						this.time = 0;
					}
					break;
			}
			this.time++;
			super.onFrame();
		}
		public override function kill():void
		{
			super.kill();
		}
	}
}
