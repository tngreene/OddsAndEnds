package com.manager
{
	import com.abstract.AGameManager;
	import com.as3toolkit.events.KeyboarderEvent;
	import com.as3toolkit.ui.Keyboarder;
	import com.MainGame;
	import com.element.Player;
	import flash.ui.Keyboard;
	
	public class PlayerManager extends AGameManager
	{
		private var _player:Player;
		//private var _level:LevelLayer = null;
		//private var _keyboard:KeyboardLayer = null;
		private var _jumping:Boolean;//This makes no sense to me
		private var _gravity:Number = 0.2;
		private var _started:Boolean = false;
		
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
				
			this._player.x = 0; //this._level.spawnPoint.x;
			this._player.y = 0;// this._level.spawnPoint.y;
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
		}
		// limits the x velocity so we dont go too fast
		private function limitVelocities()
		{
			if (Math.abs(this._player.dy) < 0.0002)
			{
				this._player.dy = 0;
			}
			if (Math.abs(this._player.dx) < 0.0002)
			{
				this._player.dx = 0;
			}
			if (Math.abs(this._player.ay) < 0.0002)
			{
				this._player.ay = 0;
			}
			if (Math.abs(this._player.ax) < 0.0002)
			{
				this._player.ax = 0;
			}
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
				this._player.ax += this._player.dx * -0.5;
			}
		}
		// checks the screen boundries
		private function checkBounds()
		{
			/*var collision = true;
			while (collision)
			{
				collision = false;
				for each(var platform:GameObject in this._level.platforms)
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
						collision = true;
					}
				}
				for each(var spike:GameObject in this._level.spikes)
				{
					test = this._player.sweepTestCollision(spike);
					if (test["collision"])
					{
						if (test["direction"] == "x")
						{
							this._player.ax -= (1 - test["time"]) * this._player.fdx;
							
						} else if (test["direction"] == "y")
						{
							this._player.ay -= (1 - test["time"]) * this._player.fdy;
						}
						trace("You just died!");
						collision = true;
					}
				}
			}
			*/
			
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
			}
			// if were holding right or left accelerate quickly in that direction
			// terminal velocityis the accel / friction constant
			if(Keyboarder.keyIsDown(Keyboard.RIGHT) )//&& !this._player.airborne)
			{
				this._player.ax += 2 * (this._player.airborne ? 0.04 : 1);
				this._player.pose = "run";
				this._player.dir = "right";
			}
			else if(Keyboarder.keyIsDown(Keyboard.LEFT) )//&& !this._player.airborne)
			{
				this._player.ax += -2 * (this._player.airborne ? 0.04 : 1);
				this._player.pose = "run";
				this._player.dir = "left";
			} else
			{
				this._player.pose = "";
				this.applyFriction();
			}
		}

		
		public function get player():Player 
		{
			return _player;
		}
	}
	
}
