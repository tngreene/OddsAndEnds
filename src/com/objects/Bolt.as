package com.objects 
{
	import com.layers.Layer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Bolt extends GameObject 
	{
		private var _oldHeight:Number;
		private var _startingFrame:Number;
		public function Bolt(_parent:Layer) 
		{
			super(_parent);
			this._startingFrame = Math.floor(Math.random() * 30) + 1;
			this.gotoAndPlay(this._startingFrame);
			this.height /= 4;
			this.width /= 4;
			
		}
		
	}

}