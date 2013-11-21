package com.layers
{
	import com.objects.Goal;
	import com.screens.GameScreen;
	import flash.display.MovieClip;
	import com.layers.XMLManager;
	import com.objects.Platform;
	import com.objects.Spikes;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import com.objects.PowerUp;
	
	public class LevelLayer extends Layer
	{
		//XML_PATH to our level.xml
		
		private var _platforms:Vector.<Platform>;
		private var _spikes:Vector.<Spikes>;
		private var _powerups:Vector.<PowerUp>;
		private var _levelHeight:Number;
		private var _levelWidth:Number;
		private var _loaded:Boolean;
		private var _spawnPoint:Point;
		private var _started:Boolean;
		private var _gridSize:Number;
		private var _goal:Goal;
		private var _currentLevel:Number = 0;
		public function LevelLayer(_parent:GameScreen) 
		{
			super(_parent);
			this._platforms = new Vector.<Platform>();
			this._spikes = new Vector.<Spikes>();
			this._powerups = new Vector.<PowerUp>();
			this._loaded = false;
			this._started = false;
			this._spawnPoint = new Point();
			this._gridSize = 40;
		}
		
		public function get platforms():Vector.<Platform>
		{
			return this._platforms;
		}
		
		public function get levelHeight():Number 
		{
			return this._levelHeight * this._gridSize;
		}
		
		public function get levelWidth():Number 
		{
			return this._levelWidth * this._gridSize;
		}
		
		public function get spikes():Vector.<Spikes> 
		{
			return _spikes;
		}
		
		public function get spawnPoint():Point 
		{
			return _spawnPoint;
		}
		
		public function get goal():Goal 
		{
			return _goal;
		}
		
		public function get currentLevel():Number 
		{
			return _currentLevel;
		}
		
		public function set currentLevel(value:Number):void 
		{
			_currentLevel = value;
		}
		
		public function get powerups():Vector.<PowerUp> 
		{
			return _powerups;
		}
		
		// setups the level
		public override function setup(mediator:LayerMediator):Boolean
		{
			super.setupMediator(mediator, "level");
			
			this.load();
			
			return true;
		}
		public function reload():void
		{
			this._levelWidth = 0;
			this._levelHeight = 0;
			
			this._spawnPoint = new Point();
			
			this.kill();
			
			this._platforms = new Vector.<Platform>();
			this._spikes = new Vector.<Spikes>();
			this._powerups = new Vector.<PowerUp>();
			
			this._goal = null;
			
			this.load();
		}
		private function load():void 
		{
			if (XMLManager.xmlInstance.xml != null)
			{
				this._levelWidth  = XMLManager.xmlInstance.xml.level[this._currentLevel].width[0].text();
				this._levelHeight = XMLManager.xmlInstance.xml.level[this._currentLevel].height[0].text();
				trace("Width: " + _levelWidth + ", Height: " + _levelHeight);
				
				//Set up the spawn point of the level
				this._spawnPoint.x = XMLManager.xmlInstance.xml.level[this._currentLevel].spawn[0].@x * this._gridSize;
				this._spawnPoint.y = XMLManager.xmlInstance.xml.level[this._currentLevel].spawn[0].@y * this._gridSize;
				trace("Spawn X: " + _spawnPoint.x +", Spawn Y:" + _spawnPoint.y);
				
				
				//Set up the goal, currently not implemented
				this._goal = new Goal(this);
				this._goal.x = XMLManager.xmlInstance.xml.level[this._currentLevel].goal[0].@x;
				this._goal.y = XMLManager.xmlInstance.xml.level[this._currentLevel].goal[0].@y;
				this._goal.setup(this._gridSize);
				trace("goal X: " + _goal.x +", goal Y:" + _goal.y);
				
				//Add the platforms
				//For all the remaining elements in the platform section
				for (var i:int = 0; i < XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].*.length(); i++)
				{
					//The platform type to be used in the switch statement
					var platType:String = XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].@type;
					//trace(platType);
					
					switch(platType)
					{
						case "platform":
							// platform data is entered as "x,y,width,height"
							var platform:Platform = new Platform(this);
							
							platform.x = XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].@x;
							platform.y = XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].@y ;
							platform.width = XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].width[0].text();
							platform.height = XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].height[0].text();
							
							platform.setup(this._gridSize);
							
							this._platforms.push(platform);
							break;
						case "spike":
							// spike data is entered as "x,y,numspikes,rotation"
							var spikes:Spikes = new Spikes(this);
							
							spikes._length =  XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].width[0] * 2;
							spikes._rotation = XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].rotation[0];
							spikes.x =  XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].@x;
							spikes.y =  XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].@y;
							
							spikes.setup(this._gridSize);
							
							this._spikes.push(spikes);
							break;
						case "powerup":
							var powerup:PowerUp = new PowerUp(this, XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].@name);
							
							powerup.x =  XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].@x;
							powerup.y =  XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].@y;
							
							powerup.setup(this._gridSize);
							trace(powerup.x);
							trace(powerup.y);
							this._powerups.push(powerup);
							break;
						default:
							throw new Error("You have entered an invalid platformtype");
					}
				}
				
				//Create the barriers of the world
				var rightWall:Platform = new Platform(this);
				rightWall.x = -1;
				rightWall.width = 2;
				rightWall.y = this._levelHeight / 2;
				rightWall.height = this._levelHeight + 8;
				rightWall.setup(this._gridSize);
				
				var leftWall:Platform = new Platform(this);
				leftWall.x = this._levelWidth + 1;
				leftWall.width = 2;
				leftWall.y = this._levelHeight / 2;
				leftWall.height = this._levelHeight + 8;
				leftWall.setup(this._gridSize);
				
				var topWall:Platform = new Platform(this);
				topWall.x = this._levelWidth / 2;
				topWall.width = this._levelWidth + 1;
				topWall.y = -1;
				topWall.height = 2;
				topWall.setup(this._gridSize);
				
				var bottomWall:Platform = new Platform(this);
				bottomWall.x = this._levelWidth / 2;
				bottomWall.width = this._levelWidth + 1;
				bottomWall.y = this._levelHeight + 1;
				bottomWall.height = 2;
				bottomWall.setup(this._gridSize);
				
				this._platforms.push(rightWall);
				this._platforms.push(leftWall);
				//this._platforms.push(topWall);
				this._platforms.push(bottomWall);
			}
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
				platform.kill();
			}
			for each(var spike:Spikes in this._spikes)
			{
				spike.kill();
			}
			for each(var powerup:PowerUp in this._powerups)
			{
				powerup.kill();
			}
			
			this._goal.kill();
		}
		// fulfills all requests we make
		public override function fulfill(key:String, target:Layer):void
		{
		}
		public function killPowerup(powerup:PowerUp)
		{
			powerup.kill();
			this._powerups.splice(this._powerups.indexOf(powerup), 1);
		}
	}
	
}
