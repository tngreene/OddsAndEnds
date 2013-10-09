package com.objects 
{
	import com.layers.Layer;
	
	public class Spikes extends GameObject 
	{
		private var _spikes:Vector.<Spike>;
		private var _length:Number;
		private var _rotation:Number;
		private var _halfWidth:Number;
		private var _halfHeight:Number;
		public override function get halfHeight():Number
		{
			return this._halfWidth;
		}
		public override function get halfWidth():Number
		{
			return this._halfHeight;
		}
		
		public function Spikes(layer:Layer, length:Number, rotation:Number) 
		{
			super(layer);
			this._spikes = new Vector.<Spike>();
			this._length = length;
			this._rotation = rotation;
		}
		public function setup()
		{
			if (this._rotation == 0 || this._rotation == 180)
			{
				this._halfHeight = 4;
				this._halfWidth = 8 * this._length;
			} else
			{
				this._halfWidth = 4;
				this._halfHeight = 8 * this._length;
			}
			var tempSpike:Spike;
			for (var i:int = 0; i < this._length; i++)
			{
				tempSpike = new Spike(this._parent);
				if (this._rotation == 0 || this._rotation == 180)
				{
					tempSpike.x = this.x + i * 16 + 4;
					tempSpike.y = this.y + 4;
				} else
				{
					tempSpike.x = this.x + 4;
					tempSpike.y = this.y + i * 16 + 4;
				}
				tempSpike.rotation = this._rotation;
				this._spikes.push(tempSpike);
			}
		}
	}

}