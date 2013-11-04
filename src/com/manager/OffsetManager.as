package com.manager 
{
	import com.abstract.AGameManager;
	import com.MainGame;
	import flash.display.MovieClip;
	
	public class OffsetManager extends AGameManager
	{
		//private var _playerLayer:PlayerLayer;
		//private var _levelLayer:LevelLayer;
		
		private var _offsetX:Number;
		private var _offsetY:Number
		public function OffsetManager(pMainGame:MainGame) 
		{
			super(pMainGame);
		}
		
	
		// calls all the functions
		// that need to be called once a frame
		public override function update():void
		{
			/*this._offsetX = -this._playerLayer.player.x + stage.stageWidth / 2;
			if (this._offsetX > 0)
				this._offsetX = 0;
			else if (this._offsetX < -this._levelLayer.levelWidth + stage.stageWidth)
				this._offsetX  = -this._levelLayer.levelWidth + stage.stageWidth;
				
			this._offsetY = -this._playerLayer.player.y + stage.stageHeight / 2;
			if (this._offsetY > 0)
				this._offsetY = 0;
			else if (this._offsetY < -this._levelLayer.levelHeight + stage.stageHeight)
				this._offsetY = -this._levelLayer.levelHeight + stage.stageHeight;*/
		}
		// kills the player clip
		public override function deconstruct():void
		{

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