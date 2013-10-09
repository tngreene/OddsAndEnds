package com.layers
{
	import flash.display.MovieClip;
	import com.objects.Platform;
	import com.objects.Spikes;
	
	public class LevelLayer extends Layer
	{
		private var _platforms:Vector.<Platform>;
		private var _spikes:Vector.<Spikes>;
		private var _levelHeight:Number;
		private var _levelWidth:Number;
		public function LevelLayer(_parent:MovieClip) 
		{
			super(_parent);
			this._platforms = new Vector.<Platform>();
			this._spikes = new Vector.<Spikes>();
		}
		
		public function get platforms():Vector.<Platform>
		{
			return this._platforms;
		}
		
		public function get levelHeight():Number 
		{
			return this._levelHeight;
		}
		
		public function get levelWidth():Number 
		{
			return this._levelWidth;
		}
		
		// setups the level
		public override function setup(mediator:LayerMediator):void
		{
			super.setupMediator(mediator, "level");
			this._platforms.push(new Platform(this));
			
			this._platforms[0].x = 0;
			this._platforms[0].y = 340;
			
			
			this._platforms.push(new Platform(this));
			
			this._platforms[1].x = 450;
			this._platforms[1].y = 300;
			this._platforms[1].height = 200;
			
			
			this._platforms.push(new Platform(this));
			
			this._platforms[2].x = 200;
			this._platforms[2].y = 150;
			
			this._platforms.push(new Platform(this));
			
			this._platforms[3].x = 320;
			this._platforms[3].y = 481;
			this._platforms[3].width = 680;
			
			this._platforms.push(new Platform(this));
			
			this._platforms[4].x = -5;
			this._platforms[4].y = 240;
			this._platforms[4].width = 10;
			this._platforms[4].height = 500;
			
			
			
			this._spikes.push(new Spikes(this, 4, 90));
			
			this._spikes[0].x = 0;
			this._spikes[0].y = 320;
			
			this._spikes[0].setup();
			
			
			this._levelHeight = 480;
			this._levelWidth = 640;
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
