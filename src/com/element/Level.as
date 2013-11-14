package com.element 
{
	import com.abstract.AGameElement;
	import com.abstract.AGameManager;
	import flash.geom.Point;
	import com.manager.XMLManager;
	/**
	 * This class represents a level with map data (spawn/goal, obsticles, etc)
	 * It is managed by the level manager. 
	 * @author Theodore Greene
	 */
	public class Level extends AGameElement 
	{
		//CONSTANTS
		
		//PUBLIC VARIABLES
		
		//PRIVATE VARIABLES
		private var _platforms:Vector.<Platform>;
		private var _spikeStrip:Vector.<Spikes>;
		private var _levelHeight:Number;
		private var _levelWidth:Number;
		private var _spawnPoint:Point;
		private var _goal:Goal;
		private var _background:Background;
				//GETTERS
		public function get platforms():Vector.<Platform>
		{
			return this._platforms;
		}
		public function get background():Background
		{
			return _background;
		}
		public function get levelHeight():Number 
		{
			return this._levelHeight;
		}
		
		public function get levelWidth():Number 
		{
			return this._levelWidth;
		}
		
		public function get spikeStrip():Vector.<Spikes> 
		{
			return _spikeStrip;
		}
		
		public function get spawnPoint():Point 
		{
			return _spawnPoint;
		}
		public function get goal():Goal
		{
			return _goal;
		}
		public function Level(pGameManager:AGameManager, levelID:uint) 
		{
			super(pGameManager);
			//Add it as a child in the displayobject hierarchy
			pGameManager.addChild(this);
			
			//Set up the collection of platforms
			this._platforms = new Vector.<Platform>();
			
			//Set up the collection of spikes
			this._spikeStrip = new Vector.<Spikes>();
			
			//And the spawn Point
			this._spawnPoint = new Point();
			
			//Set up the level width and height
			this._levelWidth  = XMLManager.xmlInstance.xml.level[levelID].width[0].text();
			this._levelHeight = XMLManager.xmlInstance.xml.level[levelID].height[0].text();
			trace("Width: " + _levelWidth + ", Height: " + _levelHeight);
			
			//Set up the spawn point of the level
			this._spawnPoint.x = XMLManager.xmlInstance.xml.level[levelID].spawn[0].@x;
			this._spawnPoint.y = XMLManager.xmlInstance.xml.level[levelID].spawn[0].@y;
			trace("Spawn X: " + _spawnPoint.x +", Spawn Y:" + _spawnPoint.y);
			

			
			//Create the background
			var backName:String = XMLManager.xmlInstance.xml.level[levelID].background[0].@name;
			_background = new Background(pGameManager,backName);
			addChild(_background);//Add it first thing so that it is at the very back of the display obects
			
			//Set up the goal
			_goal = new Goal(pGameManager);
			this._goal.x = XMLManager.xmlInstance.xml.level[levelID].goal[0].@x;
			this._goal.y = XMLManager.xmlInstance.xml.level[levelID].goal[0].@y;
			addChild(_goal);
			//trace("goal X: " + _goalPoint.x +", goal Y:" + _goalPoint.y);
			
			//Add the platforms
			//For all the remaining elements in the platform section
			for (var i:int = 0; i < XMLManager.xmlInstance.xml.level[levelID].platforms[0].*.length(); i++)
			{
				//The platform type to be used in the switch statement
				var platType:String = XMLManager.xmlInstance.xml.level[levelID].platforms[0].platform[i].@type;
				//trace(platType);
				
				switch(platType)
				{
					case "platform":
						// platform data is entered as "x,y,width,height"
						//var info:Array = line.split(",");
						var platform:Platform = new Platform(pGameManager);
						addChild(platform);//Add it to the stage
						
						platform.x = XMLManager.xmlInstance.xml.level[levelID].platforms[0].platform[i].@x;
						platform.y = XMLManager.xmlInstance.xml.level[levelID].platforms[0].platform[i].@y;
						
						//Set the width and height
						platform.width = Number(XMLManager.xmlInstance.xml.level[levelID].platforms[0].platform[i].width[0].text());
						platform.height = Number(XMLManager.xmlInstance.xml.level[levelID].platforms[0].platform[i].height[0].text());
						
						//trace("Platform X: " + platform.x + ", Y: " + platform.y + ", Width: " + platform.width + ", Height: " + platform.height);
						this._platforms.push(platform);
						break;
					case "spike":
						// spike data is entered as "x,y,numspikes,rotation"
						var spikes:Spikes = new Spikes(pGameManager);
						addChild(spikes);//Add it to the stage
						
						spikes.length =  XMLManager.xmlInstance.xml.level[levelID].platforms[0].platform[i].width[0];
						spikes.rotation = XMLManager.xmlInstance.xml.level[levelID].platforms[0].platform[i].rotation[0];
						spikes.x =  XMLManager.xmlInstance.xml.level[levelID].platforms[0].platform[i].@x;
						spikes.y =  XMLManager.xmlInstance.xml.level[levelID].platforms[0].platform[i].@y;
						
						spikes.init();
						trace("spikes X: " + spikes.x + ", Y: " + spikes.y + ", Width: " + spikes.width + ", Height: " + spikes.height);
						this._spikeStrip.push(spikes);
						break;
					default:
						throw new Error("You have entered an invalid platformtype");
				}
			}
			
			//Create the barriers of the world
			var rightWall:Platform = new Platform(this._gameManager);
			rightWall.x = -10;
			rightWall.width = 20;
			rightWall.y = this._levelHeight / 2;
			rightWall.height = this._levelHeight + 40;
			
			var leftWall:Platform = new Platform(this._gameManager);
			leftWall.x = this._levelWidth + 10;
			leftWall.width = 20;
			leftWall.y = this._levelHeight / 2;
			leftWall.height = this._levelHeight + 40;
			
			
			var topWall:Platform = new Platform(this._gameManager);
			topWall.x = this._levelWidth / 2;
			topWall.width = this._levelWidth + 40;
			topWall.y = -10;
			topWall.height = 20;
			
			var bottomWall:Platform = new Platform(this._gameManager);
			bottomWall.x = this._levelWidth / 2;
			bottomWall.width = this._levelWidth + 40;
			bottomWall.y = this._levelHeight + 10;
			bottomWall.height = 20;
			
			this._platforms.push(rightWall);
			this._platforms.push(leftWall);
			this._platforms.push(topWall);
			this._platforms.push(bottomWall);
		}//end constructor
		

		
		//SETTERS
	
		//PUBLIC FUNCTIONS
		public override function init():void
		{
			
		}
		public override function deconstruct():void
		{
			
		}
		public override function update():void
		{
			
		}
		//PRIVATE FUNCTIONS
	
	}//end class
	
}//end package