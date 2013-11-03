package com.layers 
{
	import flash.display.MovieClip;
	
	public class OffsetLayer extends Layer 
	{
		private var _playerLayer:PlayerLayer;
		private var _levelLayer:LevelLayer;
		private var _offsetX:Number;
		private var _offsetY:Number
		public function OffsetLayer(_parent:MovieClip) 
		{
			super(_parent);
		}
		
		
		// setups the player
		public override function setup(mediator:LayerMediator):Boolean
		{
			super.setupMediator(mediator, "offset");
			this._mediator.request("level", this);
			this._mediator.request("player", this);
			return true;
		}
		// calls all the functions
		// that need to be called once a frame
		public override function onFrame():void
		{
			this._offsetX = -this._playerLayer.player.x + stage.stageWidth / 2;
			if (this._offsetX > 0)
				this._offsetX = 0;
			else if (this._offsetX < -this._levelLayer.levelWidth + stage.stageWidth)
				this._offsetX  = -this._levelLayer.levelWidth + stage.stageWidth;
				
			this._offsetY = -this._playerLayer.player.y + stage.stageHeight / 2;
			if (this._offsetY > 0)
				this._offsetY = 0;
			else if (this._offsetY < -this._levelLayer.levelHeight + stage.stageHeight)
				this._offsetY = -this._levelLayer.levelHeight + stage.stageHeight;
		}
		// kills the player clip
		public override function kill():void
		{
			this._levelLayer = null;
			this._playerLayer = null;
		}
		// fulfills all requests we make
		public override function fulfill(key:String, target:Layer):void
		{
			if (key == "level")
			{
				this._levelLayer = target as LevelLayer;
			} else if (key == "player")
			{
				this._playerLayer = target as PlayerLayer;
			}
		}
		
		public function get offsetX():Number 
		{
			return _offsetX;
		}
		
		public function get offsetY():Number 
		{
			return _offsetY;
		}
	}

}