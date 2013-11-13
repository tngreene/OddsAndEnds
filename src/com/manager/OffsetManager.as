package com.manager 
{
	import com.abstract.AGameManager;
	import com.element.Level;
	import com.MainGame;
	import flash.display.MovieClip;
	
	public class OffsetManager extends AGameManager
	{
		private var _offsetX:Number;
		private var _offsetY:Number;
		
		public function OffsetManager(pMainGame:MainGame) 
		{
			super(pMainGame);
		}
		
	
		// calls all the functions
		// that need to be called once a frame
		public override function update():void
		{
			//A variable to represent the current level
			var curLevel:Level = this._mainGame.levelManager.levels[this._mainGame.levelManager.currentLevel];
			
			//OffsetX = the player's x position + half the stage width (inverted)
			this._offsetX = -this._mainGame.playerManager.player.x + stage.stageWidth / 2;
			
			//If the offset is greater than 0
			if (this._offsetX > 0)
			{
				//Resset it
				this._offsetX = 0;
			}
			//Otherwise if this is less than the inverse of the levelwidth and stage width
			else if (this._offsetX < -curLevel.levelWidth + stage.stageWidth)
			{
				//Reset it
				this._offsetX  = -curLevel.levelWidth + stage.stageWidth;
			}
			
			//Repeat for the Y
			this._offsetY = -this._mainGame.playerManager.player.y + stage.stageHeight / 2;
			if (this._offsetY > 0)
			{
				this._offsetY = 0;
			}
			else if (this._offsetY < -curLevel.levelHeight + stage.stageHeight)
			{
				this._offsetY = -curLevel.levelHeight + stage.stageHeight;
			}
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