package com.manager
{
	import com.abstract.AGameManager;
	import com.manager.XMLManager;
	import com.MainGame;
	import com.element.Platform;
	import com.element.Spikes;
	import flash.geom.Point;
	
	public class LevelManager extends AGameManager
	{
		private var _platforms:Vector.<Platform>;
		private var _spikes:Vector.<Spikes>;
		private var _levelHeight:Number;
		private var _levelWidth:Number;
		private var _loaded:Boolean;
		private var _spawnPoint:Point;
		private var _started:Boolean;
		public function LevelManager(pMainGame:MainGame) 
		{
			super(pMainGame);
			this._platforms = new Vector.<Platform>();
			this._spikes = new Vector.<Spikes>();

			this._spawnPoint = new Point();
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
		
		public function get spikes():Vector.<Spikes> 
		{
			return _spikes;
		}
		
		public function get spawnPoint():Point 
		{
			return _spawnPoint;
		}
		
		// setups the level
		public override function init():void
		{			
			//The current level
			var currentLevel:Number = 0;
			
			//trace(levelID);
			//Set up the level width and height
			this._levelWidth  = XMLManager.xmlInstance.xml.level[currentLevel].width[0].text();
			this._levelHeight = XMLManager.xmlInstance.xml.level[currentLevel].height[0].text();
			trace("Width: " + _levelWidth + ", Height: " + _levelHeight);
			
			//Set up the spawn point of the level
			this._spawnPoint.x = XMLManager.xmlInstance.xml.level[currentLevel].spawn[0].@x;
			this._spawnPoint.y = XMLManager.xmlInstance.xml.level[currentLevel].spawn[0].@y;
			trace("Spawn X: " + _spawnPoint.x +", Spawn Y:" + _spawnPoint.y);
			
			//Set up the goal, currently not implemented
			/*this._goalPoint.x = XMLManager.xmlInstance.xml.level[currentLevel].goal[0].@x;
			this._goalPoint.y = XMLManager.xmlInstance.xml.level[currentLevel].goal[0].@y;
			trace("goal X: " + _goalPoint.x +", goal Y:" + _goalPoint.y);*/
			
			//Add the platforms
			//For all the remaining elements in the platform section
			for (var i:int = 0; i < XMLManager.xmlInstance.xml.level[currentLevel].platforms[0].*.length(); i++)
			{
				//The platform type to be used in the switch statement
				var platType:String = XMLManager.xmlInstance.xml.level[currentLevel].platforms[0].platform[i].@type;
				trace(platType);
				
				switch(platType)
				{
					case "platform":
						// platform data is entered as "x,y,width,height"
						//var info:Array = line.split(",");
						var platform:Platform = new Platform(this);
						
						platform.x = XMLManager.xmlInstance.xml.level[currentLevel].platforms[0].platform[i].@x;
						platform.y = XMLManager.xmlInstance.xml.level[currentLevel].platforms[0].platform[i].@y;
						platform.width = XMLManager.xmlInstance.xml.level[currentLevel].platforms[0].platform[i].width[0].text();
						platform.height = XMLManager.xmlInstance.xml.level[currentLevel].platforms[0].platform[i].height[0].text();
						
						this._platforms.push(platform);
						break;
					case "spike":
						// spike data is entered as "x,y,numspikes,rotation"
						var spikes:Spikes = new Spikes(this);
						
						spikes._length =  XMLManager.xmlInstance.xml.level[currentLevel].platforms[0].platform[i].width[0];
						spikes._rotation = XMLManager.xmlInstance.xml.level[currentLevel].platforms[0].platform[i].rotation[0];
						spikes.x =  XMLManager.xmlInstance.xml.level[currentLevel].platforms[0].platform[i].@x;
						spikes.y =  XMLManager.xmlInstance.xml.level[currentLevel].platforms[0].platform[i].@y;
						
						spikes.init();
						
						this._spikes.push(spikes);
						break;
					default:
						throw new Error("You have entered an invalid platformtype");
				}
			}
			
			//Create the barriers of the world
			var rightWall:Platform = new Platform(this);
			rightWall.x = -10;
			rightWall.width = 20;
			rightWall.y = this._levelHeight / 2;
			rightWall.height = this._levelHeight + 40;
			
			var leftWall:Platform = new Platform(this);
			leftWall.x = this._levelWidth + 10;
			leftWall.width = 20;
			leftWall.y = this._levelHeight / 2;
			leftWall.height = this._levelHeight + 40;
			
			
			var topWall:Platform = new Platform(this);
			topWall.x = this._levelWidth / 2;
			topWall.width = this._levelWidth + 40;
			topWall.y = -10;
			topWall.height = 20;
			
			var bottomWall:Platform = new Platform(this);
			bottomWall.x = this._levelWidth / 2;
			bottomWall.width = this._levelWidth + 40;
			bottomWall.y = this._levelHeight + 10;
			bottomWall.height = 20;
			
			this._platforms.push(rightWall);
			this._platforms.push(leftWall);
			this._platforms.push(topWall);
			this._platforms.push(bottomWall);
		}
	}
	
}
