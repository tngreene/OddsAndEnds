package com.layers 
{
	import com.objects.Background;
	import flash.display.MovieClip;
	
	public class BackgroundLayer extends Layer 
	{
			
		private var _background_mc:Background;
		
		public function BackgroundLayer(_parent:MovieClip) 
		{
			super(_parent);
			this._background_mc = new Background(this);
		}
		// setups the player
		public override function setup(mediator:LayerMediator):Boolean
		{
			super.setupMediator(mediator, "background");
			return true;
		}
		
	}

}