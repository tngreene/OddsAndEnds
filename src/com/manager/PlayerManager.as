package com.manager
{
	import com.abstract.AGameManager;
	import com.as3toolkit.ui.Keyboarder;
	import com.element.Platform;
	import com.element.Player;
	import com.element.Spikes;
	import com.MainGame;
	import flash.ui.Keyboard;
	
	public class PlayerManager extends AGameManager
	{
		private var _player:Player;
		public function get player():Player 
		{
			return _player;
		}
		private var _gravity:Number = 0.2;
		private var _win:Boolean = false;
		public function get win():Boolean
		{
			return _win;
		}
		
		private var _jumping:Boolean;//This makes no sense to me, variable based programming

		public function PlayerManager(pMainGame:MainGame) 
		{
			super(pMainGame);
			//...
			//Keyboarder.Instance.addEventListener(KeyboarderEvent.FIRST_PRESS, onKeyPress);
			//Keyboarder.Instance.addEventListener(KeyboarderEvent.RELEASE, onKeyRelease);
		}
		
		public override function init():void
		{
			//Creates the player
			this._player = new Player(this);
			this.addChild(this._player);
			// sets him in the middle by default
			// not jumping either
			this._jumping = false;
				
			this._player.x = _mainGame.levelManager.levels[_mainGame.levelManager.currentLevel].spawnPoint.x; //this._level.spawnPoint.x;
			this._player.y = _mainGame.levelManager.levels[_mainGame.levelManager.currentLevel].spawnPoint.y;// this._level.spawnPoint.y;
		}
		
		// kills the player clip
		public override function deconstruct():void
		{
			this.removeChild(this._player);
			this._player = null;
		}
		// calls all the functions
		// that need to be called once a frame
		public override function update():void
		{
			trace("X: " + this.player.x);
			trace("Y: " + this.player.y);
			// set acceleration to 0 so we can mess with it later
			this._player.resetAcceleration();
			// check keys
			this.checkKeys();
			// apply gravity
			this.applyGravity();
			// make sure we dont go off screen
			this.checkBounds();
			// make sure we dont go too fast
			this.limitVelocities();
			
			if(this._jumping && !this._player.airborne)
				this._jumping = false;
			// actually move the character
			this._player.update();
		}
		private function applyGravity()
		{
			this._player.ay += this._gravity;
			trace("player.dy " + _player.dy);
		}
		// limits the x velocity so we dont go too fast
		private function limitVelocities()
		{
			function cutOff(num:Number):Number
			{
				return Math.round(num * 10000) / 10000;
			}
			this._player.dy = cutOff(this._player.dy);
			this._player.dx = cutOff(this._player.dx);
			this._player.ay = cutOff(this._player.ay);
			this._player.ax = cutOff(this._player.ax);
			
			// if its speeds greater than 10, set it to 10
			if(Math.abs(this._player.fdx) > 5)
			{
				this._player.dx = (this._player.dx / Math.abs(this._player.dx)) * 5;
			}
			if(Math.abs(this._player.fdy) > 14)
			{
				this._player.dy = (this._player.dy / Math.abs(this._player.dy)) * 14;
			}
		}
		// calculates drag and friction
		private function applyFriction()
		{
			// if we aren't airborne
			// add friction
			if (this._player.dy == 0 && !this._jumping)
			{
				this._player.ax += this._player.dx * -1;
			}
		}
		
		// checks the screen boundries
		private function checkBounds()
		{
			var noCollision = true;
			while (noCollision)
			{
				noCollision = false;
				//For each platform in the levelManager's current level's collection of platforms
				for each(var platform:Platform in this._mainGame.levelManager.levels[this._mainGame.levelManager.currentLevel].platforms)
				{
					var test:Object = this._player.sweepTestCollision(platform);
					if (test["collision"])
					{
						if (test["direction"] == "x")
						{
							this._player.ax -= (1 - test["time"]) * this._player.fdx;
							
						} else if (test["direction"] == "y")
						{
							this._player.ay -= (1 - test["time"]) * this._player.fdy;
							
						}
						noCollision = true;
					}
				}
				
				//Variable to help clean up the aweful verboseness of this
				var loopSpikeStrips:Vector.<Spikes> = this._mainGame.levelManager.
											levels[this._mainGame.levelManager.currentLevel].
																				spikeStrip;
				//For all the spike strips in the level
				for (var i:int = 0; i < loopSpikeStrips.length; i++)
				{
					test = this._player.sweepTestCollision(loopSpikeStrips[i]);
					if (test["collision"])
					{
						if (test["direction"] == "x")
						{
							this._player.ax -= (1 - test["time"]) * this._player.fdx;
							
						} else if (test["direction"] == "y")
						{
							this._player.ay -= (1 - test["time"]) * this._player.fdy;
						}
						_player.takeDamage(1);
						//this._dead = true;
						noCollision = true;
					}
				}
				
				test = this._player.sweepTestCollision(_mainGame.levelManager.
											levels[this._mainGame.levelManager.currentLevel].goal);
				if (test["collision"])
				{
					this._win = true;
					trace("win");
				}
			}
		}
		
		
		// checks the keys
		private function checkKeys()
		{
			// jump
			// only if we arent already jumping
			if(Keyboarder.keyIsDown(Keyboard.UP) && !this._jumping)
			{
				this._player.ay += -8;
				this._jumping = true;
				//trace("up");
			}
			// if were holding right or left accelerate quickly in that direction
			// terminal velocityis the accel / friction constant
			if(Keyboarder.keyIsDown(Keyboard.RIGHT) )//&& !this._player.airborne)
			{
				this._player.ax += 2 * (this._player.airborne ? 0.04 : 1);
				this._player.pose = "run";
				this._player.dir = "right";
				//trace("right");
			}
			else if(Keyboarder.keyIsDown(Keyboard.LEFT) )//&& !this._player.airborne)
			{
				this._player.ax += -2 * (this._player.airborne ? 0.04 : 1);
				this._player.pose = "run";
				this._player.dir = "left";
				//trace("left");
			} 
			else
			{
				this._player.pose = "";
				this.applyFriction();
				//trace("else");
			}
		}
		
		public function respawn():void
		{
			this._player.x = _mainGame.levelManager.levels[_mainGame.levelManager.currentLevel].spawnPoint.x;
			this._player.y = _mainGame.levelManager.levels[_mainGame.levelManager.currentLevel].spawnPoint.y;
			this._player.dx = 0;
			this._player.dy = 0;
			this._player.ax = 0;
			this._player.ay = 0;
			this._player.dead = false;
			this._win = false;
		}
	}
}
