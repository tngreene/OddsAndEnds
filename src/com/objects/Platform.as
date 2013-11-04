package com.objects 
{
	
	import com.layers.Layer;
	
	public class Platform extends GameObject 
	{
		public function Platform(layer:Layer) 
		{
			super(layer);
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
				}
			}
			
			this.x *= gridSize;
			this.y *= gridSize;
			this.width *= gridSize;
			this.height *= gridSize;
		}
	}
}
