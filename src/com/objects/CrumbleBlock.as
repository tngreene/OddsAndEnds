package com.objects 
{
	import com.layers.Layer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CrumbleBlock extends GameObject 
	{
		
		public function CrumbleBlock(_parent:Layer) 
		{
			super(_parent);
			
		}
		public function setup(gridSize:Number)
		{
			this.x *= gridSize;
			this.y *= gridSize;
		}
		
	}

}