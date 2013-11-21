package com.objects 
{
	import com.layers.Layer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PowerUp extends GameObject 
	{
		
		private var _powerUpName:String;
		
		public function PowerUp(_parent:Layer, powerUpName:String) 
		{
			super(_parent);
			this._powerUpName = powerUpName;
			this.gotoAndStop(this._powerUpName);
		}
		
		public function get powerUpName():String 
		{
			return _powerUpName;
		}
		public function setup(gridSize:Number)
		{
			this.x *= gridSize;
			this.y *= gridSize;
		}
	}

}