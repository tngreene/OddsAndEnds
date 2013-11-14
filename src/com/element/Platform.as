package com.element 
{
	
	import com.abstract.AGameElement;
	import com.abstract.AGameManager;
	import flash.geom.ColorTransform;
		
	public class Platform extends AGameElement
	{
		public function Platform(pGameManager:AGameManager) 
		{
			super(pGameManager);
			
			
			/*var red:uint = Math.floor(Math.random() * 255);
			var green:uint = Math.floor(Math.random() * 255);
			var blue:uint = Math.floor(Math.random() * 255);
			this.transform.colorTransform = new ColorTransform(1, 1, 1, 1, red, green, blue);*/
		}
		public override function init():void
		{
			this.x *= Level.GRID_SIZE;
			this.y *=  Level.GRID_SIZE;
			this.width *=  Level.GRID_SIZE;
			this.height *=  Level.GRID_SIZE;
		}
	}
}
