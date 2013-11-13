package com.manager
{
	import com.abstract.AGameManager;
	import com.element.Level;
	import com.element.Platform;
	import com.element.Spikes;
	import com.MainGame;
	import com.manager.XMLManager;
	
	public class LevelManager extends AGameManager
	{	
		//Current level
		private var _currentLevel:uint;
		private var _levels:Vector.<Level>;
		
		public function get levels():Vector.<Level>
		{
			return _levels;
		}
		
		public function get currentLevel():uint
		{
			return _currentLevel;
		}
		
		public function LevelManager(pMainGame:MainGame) 
		{
			super(pMainGame);
			
			_currentLevel = 0;//At the start of the program current Level will be 0
			_levels = new Vector.<Level>();
		}
		
		// setups the level manager
		public override function init():void
		{			
			//Create atleast level one (aka level 0)
			addLevel(_currentLevel);
		}
		
		public override function deconstruct():void
		{
			
		}
		public override function update():void
		{
			
		}
		
		//Creates a level and adds it to this class's vector of levels
		public function addLevel(levelID:uint)
		{
			//Create the level
			var tempLevel:Level = new Level(this, levelID);
			//Add it to the vector of levels
			_levels.push(tempLevel);
		}
	}
	
}
