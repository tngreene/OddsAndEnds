package com.objects 
{
	import com.layers.Layer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CrumblingPlatform extends GameObject 
	{
		private var _state:String;
		private var _time:Number;
		private var _crumbleBlocks:Vector.<CrumbleBlock>;
		public var breakTime:Number;
		public function CrumblingPlatform(_parent:Layer) 
		{
			super(_parent);
			this._state = "solid";
			this._time = 0;
			this._crumbleBlocks = new Vector.<CrumbleBlock>();
		}
		public function onBreak()
		{
			if (this._state == "solid")
			{
				this._time = 0;
				this._state = "breaking";
			}
		}
		public function setup(gridSize:Number)
		{
			for (var i = 0; i < this.width; i += 1)
			{
				var tempBlock:CrumbleBlock = new CrumbleBlock(this._parent);
				tempBlock.x = i + this.x - this.width / 2 + 0.5;
				tempBlock.y = this.y - this.height / 2 + 0.25;
				tempBlock.setup(gridSize);
				this._crumbleBlocks.push(tempBlock);
			}
			
			this.x *= gridSize;
			this.y *= gridSize;
			this.width *= gridSize;
			this.height *= gridSize;
		}
		private function eq(x:Number):Number { return -0.1 * x * x; };
		public override function onFrame()
		{
			switch(this._state)
			{
				case "solid":
					this._time = 0;
					break;
				case "breaking":
					if (this._time > this.breakTime)
					{
						this._state = "falling";
						this._time = 0;
					}
					break;
				case "falling":
					this.dy = -(eq(this._time + 1) - eq(this._time));
					for each(var block:CrumbleBlock in this._crumbleBlocks)
					{
						block.y += this.dy;
						block.alpha -= 0.02;
						if (block.alpha <= 0)
						{
							this.visible = false;
						}
					}
					this.alpha -= 0.02;
					if (this.alpha <= 0)
					{
						// kill this
						this.visible = false;
						this._parent.destroy(this);
					}
					
					break;
			}
			super.onFrame();
			this._time ++;
		}
	}

}