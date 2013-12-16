package com.objects 
{
	import com.layers.Layer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Conductor extends GameObject 
	{
		
		public function get sourceX()
		{
			return this.x + 6 * Math.cos(this.rotation * Math.PI / 180 - Math.PI / 2);
		}
		
		public function get sourceY()
		{
			return this.y + 6 * Math.sin(this.rotation * Math.PI / 180 - Math.PI / 2);
		}
		public function Conductor(_parent:Layer) 
		{
			super(_parent);
			
		}
		
	}

}