package com.element 
{
	import com.abstract.AGameElement;
	import com.abstract.AGameManager;
	
	public class Spikes extends AGameElement 
	{
		private var _spikes:Vector.<Spike>;// = new Vector.<Spike>();
		
		private var _length:Number;
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
		
		public function innerSpikes():Vector.<Spike>
		{
			return _spikes;
		}
		public function get length():Number
		{
			return _length;
		}
		public function set length(value:Number)
		{
			_length = value;
		}
				
		//, length:Number, rotation:Number
		//Changes the contructor
		public function Spikes(pGameManager:AGameManager) 
		{
			super(pGameManager);
			this._spikes = new Vector.<Spike>();
			this._length = length;
			//this._rotation = rotation;
		}
		
		public override function init():void
		{
			var tempSpike:Spike = new Spike(this._gameManager);
			if (this.rotation == 0 || this.rotation == 180)
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
					tempSpike = new Spike(this._gameManager);
				if (this.rotation == 0 || this.rotation == 180)
				{
					tempSpike.x = this.x + i * 20 + 10;
					tempSpike.y = this.y + 10;
				} else
				{
					tempSpike.x = this.x + 10;
					tempSpike.y = this.y + i * 20 + 10;
				}
				tempSpike.rotation = this.rotation;
				this._spikes.push(tempSpike);
			}
			this.x += this.halfWidth;
			this.y += this.halfHeight;
		}
	}

}