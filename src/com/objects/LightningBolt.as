package com.objects 
{
	import com.layers.Layer;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ...
	 */
	public class LightningBolt extends GameObject 
	{
		private var _target:Point;
		private var _source:Point;
		private var _bolts:Vector.<Bolt>;
		private var _boltHeight:Number = 260 / 4 - 4;
		public function LightningBolt(_parent:Layer) 
		{
			super(_parent);
			this._target = new Point();
			this._source = new Point();
			this._bolts = new Vector.<Bolt>();
		}
		
		public function get target():Point 
		{
			return this._target;
		}
		
		public function set target(value:Point):void 
		{
			this._target = value;
			
			this.recalculate();
		}
		
		public function get source():Point 
		{
			return this._source;
		}
		
		public function set source(value:Point):void 
		{
			this._source = value;
			this.recalculate();
		}
		public function recalculate()
		{
			var boltVector = this._source.subtract(this.target);
			var boltAngle = Math.PI + Math.atan2(boltVector.y, boltVector.x);
			var dx = this._boltHeight * Math.cos(boltAngle);
			var dy = this._boltHeight * Math.sin(boltAngle);
			var distance:Number = boltVector.length;
			var boltsNeeded:Number = Math.ceil(distance / this._boltHeight);
			while (boltsNeeded < this._bolts.length)
			{
				this._bolts.pop().kill();
			}
			if (boltsNeeded > this._bolts.length && this._bolts.length != 0) // if we need more bolts pop the last one to reset its height
				this._bolts.pop().kill();
			while (boltsNeeded > this._bolts.length)
			{
				this._bolts.push(new Bolt(this._parent));
			}
			var distanceRemaining:Number = distance;
			var i = 0;
			for each(var bolt:Bolt in this._bolts)
			{
				if (distanceRemaining < this._boltHeight)
				{
					bolt.rotation = 0
					bolt.height = distance % this._boltHeight;
					bolt.x = this.target.x - bolt.height * Math.cos(boltAngle) * .5;
					bolt.y = this.target.y - bolt.height * Math.sin(boltAngle)* .5;
				} else
				{
					
					bolt.x = i * dx + dx / 2 + this.source.x;
					bolt.y = i * dy + dy / 2 + this.source.y;
				}
				bolt.rotation = boltAngle * 180 / Math.PI + 90;
				distanceRemaining -= this._boltHeight;
				i++;
			}
		}
		public override function kill():void
		{
			super.kill();
			for each(var bolt:Bolt in this._bolts)
			{
				bolt.kill();
			}
		}
	}

}