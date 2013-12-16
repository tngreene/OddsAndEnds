package com.layers
{
	import com.objects.GameObject;
	import com.objects.Goal;
	import com.objects.RecieverConductor;
	import com.objects.SourceConductor;
	import com.screens.GameScreen;
	import fl.motion.Source;
	import flash.display.MovieClip;
	import com.layers.XMLManager;
	import com.objects.Platform;
	import com.objects.Spikes;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import com.objects.PowerUp;
	import com.objects.Crusher;
	public class LevelLayer extends Layer
	{
		//XML_PATH to our level.xml
		
		private var _platforms:Vector.<Platform>;
		private var _spikes:Vector.<Spikes>;
		private var _powerups:Vector.<PowerUp>;
		private var _crushers:Vector.<Crusher>;
		private var _sources:Vector.<SourceConductor>;
		private var _recievers:Vector.<RecieverConductor>;
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
			this._crushers = new Vector.<Crusher>();
			this._sources = new Vector.<SourceConductor>;
			this._recievers = new Vector.<RecieverConductor>;
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
		
		public function get crushers():Vector.<Crusher> 
		{
			return _crushers;
		}
		
		public function get sources():Vector.<SourceConductor> 
		{
			return _sources;
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
			this._crushers = new Vector.<Crusher>();
			
			this._goal = null;
			
			this.load();
		}
		private function load():void 
		{
			if (XMLManager.xmlInstance.xml != null)
			{
				this._levelWidth  = XMLManager.xmlInstance.xml.level[this._currentLevel].width[0].text();
				this._levelHeight = XMLManager.xmlInstance.xml.level[this._currentLevel].height[0].text();
				//trace("Width: " + _levelWidth + ", Height: " + _levelHeight);
				
				//Set up the spawn point of the level
				this._spawnPoint.x = XMLManager.xmlInstance.xml.level[this._currentLevel].spawn[0].@x * this._gridSize;
				this._spawnPoint.y = XMLManager.xmlInstance.xml.level[this._currentLevel].spawn[0].@y * this._gridSize;
				//trace("Spawn X: " + _spawnPoint.x +", Spawn Y:" + _spawnPoint.y);
				
				
				//Set up the goal, currently not implemented
				this._goal = new Goal(this);
				this._goal.x = XMLManager.xmlInstance.xml.level[this._currentLevel].goal[0].@x;
				this._goal.y = XMLManager.xmlInstance.xml.level[this._currentLevel].goal[0].@y;
				this._goal.setup(this._gridSize);
				//trace("goal X: " + _goal.x +", goal Y:" + _goal.y);
				
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
							this._powerups.push(powerup);
							break;
						case "crusher":
							var crusher:Crusher = new Crusher(this);
							
							crusher.x =  XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].@x;
							crusher.y =  XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].@y;
							
							crusher.delay = XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].delay[0];
							crusher.crushTime = XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].crushTime[0];
							crusher.riseTime = XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].riseTime[0];
							crusher.holdTime = XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].holdTime[0];
							crusher.crushDistance = XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].crushDistance[0];
							crusher.timeOffset = XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].firstCrushDelay[0];
							
							crusher.setup(this._gridSize);
							this._crushers.push(crusher);
							break;
						case "generator":
							var source:SourceConductor = new SourceConductor(this);
							var reciever:RecieverConductor = new RecieverConductor(this);
							
							source.x =  XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].source[0].@x;
							source.y =  XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].source[0].@y;
							source.rotation =  XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].source[0].@rotation;
							source.maxRange = XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].@maxRange;
							
							reciever.x =  XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].destination[0].@x;
							reciever.y =  XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].destination[0].@y;
							reciever.rotation =  XMLManager.xmlInstance.xml.level[this._currentLevel].platforms[0].platform[i].destination[0].@rotation;
							
							source.setup(this._gridSize);
							reciever.setup(this._gridSize);
							this._sources.push(source);
							this._recievers.push(reciever);
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
			for each(var crusher:Crusher in this._crushers)
			{
				crusher.onFrame();
			}
			for each(var source:SourceConductor in this._sources)
			{
				source.onFrame();
			}
			for each(var reciever:RecieverConductor in this._recievers)
			{
				reciever.onFrame();
			}
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
			for each(var crusher:Crusher in this._crushers)
			{
				crusher.kill();
			}
			for each(var source:SourceConductor in this._sources)
			{
				source.kill();
			}
			for each(var reciever:RecieverConductor in this._recievers)
			{
				reciever.kill();
			}
			
			this._goal.kill();
		}
		// fulfills all requests we make
		public override function fulfill(key:String, target:Layer):void
		{
		}
		public override function destroy(go:GameObject):void
		{
			if (go is PowerUp)
			{
				this._powerups.splice(this._powerups.indexOf(go), 1);
				go.kill();
			}
			if (go is Crusher)
			{
				this._crushers.splice(this._crushers.indexOf(go), 1);
				go.kill();
			}
		}
	}
	
}
