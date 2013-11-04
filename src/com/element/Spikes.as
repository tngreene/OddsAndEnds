package com.element 
{
	import com.abstract.AGameElement;
	import com.abstract.AGameManager;
	
	public class Spikes extends AGameElement 
	{
		private var _spikes:Vector.<Spike>;
		//Not a good solution but I just wanted to make it work once
		public var _length:Number;
		public var _rotation:Number;
		private var _halfWidth:Number;
		private var _halfHeight:Number;
		
		public override function get halfHeight():Number
		{
			return this._halfHeight;
		}
		public override function get halfWidth():Number
		{
			return this._halfWidth;
		}
		
		//, length:Number, rotation:Number
		//Changes the contructor
		public function Spikes(pGameManager:AGameManager) 
		{
			super(pGameManager);
			this._spikes = new Vector.<Spike>();
			this._length = length;
			this._rotation = rotation;
		}
		
		public override function init():void
		{
			/*var tempSpike:Spike = new Spike(this._parent);
			if (this._rotation == 0 || this._rotation == 180)
			{
				this._halfWidth = 10 * this._length;
				this._halfHeight = 10;
			} else
			{
				this._halfWidth = 10;
				this._halfHeight = 10 * this._length;
			}
			this.x -= this.halfWidth;
			this.y -= this.halfHeight;
			for (var i:int = 0; i < this._length; i++)
			{
				if(i != 0)
					tempSpike = new Spike(this._parent);
				if (this._rotation == 0 || this._rotation == 180)
				{
					tempSpike.x = this.x + i * 20 + 10;
					tempSpike.y = this.y + 10;
				} else
				{
					tempSpike.x = this.x + 10;
					tempSpike.y = this.y + i * 20 + 10;
				}
				tempSpike.rotation = this._rotation;
				this._spikes.push(tempSpike);
			}
			this.x += this.halfWidth;
			this.y += this.halfHeight;*/
		}
	}

}