package com.objects 
{
	
	import com.layers.Layer;
	
	public class Platform extends GameObject 
	{
		private var _blocks:Vector.<Block>;
		public function Platform(layer:Layer) 
		{
			super(layer);
			this._blocks = new Vector.<Block>;
		}
		public function setup(gridSize:Number)
		{
			for (var i = 0; i < this.width; i += 0.5)
			{
				for (var j = 0; j < this.height; j += 0.5)
				{
					var tempBlock:Block = new Block(this._parent);
					tempBlock.x = i + this.x - this.width / 2 + 0.25;
					tempBlock.y = j + this.y - this.height / 2 + 0.25;
					tempBlock.setup(gridSize);
					this._blocks.push(tempBlock);
				}
			}
			
			this.x *= gridSize;
			this.y *= gridSize;
			this.width *= gridSize;
			this.height *= gridSize;
		}
		public override function kill():void
		{
			super.kill();
			for each(var b:Block in this._blocks)
			{
				b.kill();
			}
		}
	}
}
