package com.objects 
{
	import com.layers.Layer;
	/**
	 * ...
	 * @author ...
	 */
	public class Block extends GameObject 
	{
		
		public function Block(parent:Layer) 
		{
			super(parent);
		}
		public function setup(gridSize:Number)
		{
			this.x *= gridSize;
			this.y *= gridSize;
		}
	}

}