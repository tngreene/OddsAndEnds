package com.objects 
{
	import com.layers.Layer;
	/**
	 * ...
	 * @author ...
	 */
	public class Goal extends GameObject 
	{
		
		public function Goal(layer:Layer) 
		{
			super(layer);
		}
		public function setup(gridSize:Number)
		{
			this.x *= gridSize;
			this.y *= gridSize;
		
		}
		
	}

}