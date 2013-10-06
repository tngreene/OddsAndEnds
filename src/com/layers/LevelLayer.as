package com.layers
{
	import flash.display.MovieClip;
	import com.objects.Platform;
	
	public class LevelLayer extends Layer
	{
		private var _platforms:Vector.<Platform>;
		public function LevelLayer(_parent:MovieClip) 
		{
			super(_parent);
			this._platforms = new Vector.<Platform>();
		}
		
		public function get platforms():Vector.<Platform>
		{
			return this._platforms;
		}
		
		// setups the player
		public override function setup(mediator:LayerMediator):void
		{
			super.setupMediator(mediator, "level");
			
			this._platforms.push(new Platform(this));
			
			this._platforms[0].x = 150;
			this._platforms[0].y = 400;
			
			
			this._platforms.push(new Platform(this));
			
			this._platforms[1].x = 100;
			this._platforms[1].y = 280;
			
			this._platforms.push(new Platform(this));
			
			this._platforms[2].x = 200;
			this._platforms[2].y = 100;
		}
		// calls all the functions
		// that need to be called once a frame
		public override function onFrame():void
		{
		}
		// kills the player clip
		public override function kill():void
		{
			for each(var platform:Platform in this._platforms)
			{
				this.removeChild(platform);
			}
		}
		// fulfills all requests we make
		public override function fulfill(key:String, target:Layer):void
		{
		}
	}
	
}
