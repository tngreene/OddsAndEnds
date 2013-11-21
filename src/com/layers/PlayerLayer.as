package com.layers
{
	import com.collections.Set;
	import com.objects.PowerUp;
	import com.screens.GameScreen;
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import com.objects.Player;
	import com.objects.Platform;
	import com.objects.GameObject;
	import flash.utils.Dictionary;
	
	public class PlayerLayer extends Layer
	{
		private var _player:Player;
		private var _level:LevelLayer = null;
		private var _keyboard:KeyboardLayer = null;
		private var _jumping:Boolean;
		private var _gravity:Number = 0.2;
		private var _started:Boolean = false;
		private var _dead:Boolean = false;
		private var _win:Boolean = false;
		private var _deaths:Number = 0;
		private var _keyToPowerup:Dictionary = new Dictionary();
		
		public function PlayerLayer(_parent:GameScreen) 
		{
			super(_parent);
		}
		
		// setups the player
		public override function setup(mediator:LayerMediator):Boolean
		{
			super.setupMediator(mediator, "player");
			if (!this._started)
			{
				// initializes the player
				this._player = new Player(this);
				// sets him in the middle by default
				// not jumping either
				this._jumping = false;
				
				this._keyToPowerup[Keyboard.Q] = {name: "spike_shield", pressed: false};
				this._keyToPowerup[Keyboard.W] = {name: "strong_arm", pressed: false};
				this._keyToPowerup[Keyboard.E] = {name: "lightning_rod", pressed: false};
				
				this.addChild(this._player);
				// requests keyboard access
				this._mediator.request("keyboard", this);
				this._mediator.request("level", this);
				this._started = true;
			}
			
			if (this._level != null)
			{
				this.respawn();
				return true;
			}
			return false;
		}
		
		// calls all the functions
		// that need to be called once a frame
		public override function onFrame():void
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
			
			if (this._dead)
			{
				this._dead = false;
				this.respawn();
				this._deaths++;
			}
			if (this._win)
			{
				this._win = false;
				this._level.currentLevel++;
				trace(XMLManager.xmlInstance.xml.levels.@maxId);
				if (this._level.currentLevel <= XMLManager.xmlInstance.xml.levels.@maxId)
				{
					this._level.reload();
					this.respawn();
				} else 
				{
					this._parent.toVictory(null);
					this._parent.reset();
				}
			}
			
			if(this._jumping && !this._player.airborne)
				this._jumping = false;
			// actually move the character
			this._player.onFrame();
		}
		private function applyGravity()
		{
			this._player.ay += this._gravity;
		}
		private function cutOff(num:Number):Number
		{
			return Math.round(num * 10000) / 10000;
		}
		// limits the x velocity so we dont go too fast
		private function limitVelocities()
		{
			this._player.dy = cutOff(this._player.dy);
			this._player.dx = cutOff(this._player.dx);
			this._player.ay = cutOff(this._player.ay);
			this._player.ax = cutOff(this._player.ax);
			this._player.x = cutOff(this._player.x);
			this._player.y = cutOff(this._player.y);
			// if its speeds greater than 10, set it to 10
			if(Math.abs(this._player.fdx) > 8)
			{
				this._player.ax += (this._player.dx / Math.abs(this._player.dx)) * (8 - Math.abs(this._player.fdx));
			}
			if(Math.abs(this._player.fdy) > 14)
			{
				this._player.ay += (this._player.dy / Math.abs(this._player.dy)) * (14 - Math.abs(this._player.fdy));
			}
		}
		// calculates drag and friction
		private function applyFriction()
		{
			// if we aren't airborne
			// add friction
			if(this._player.dy == 0 && !this._jumping)
				this._player.ax += this._player.dx * -0.05;
		}
		// checks the screen boundries
		private function checkBounds()
		{
			var collision = true;
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
						if(!this._player.activePowerups.flagged("spike_shield"))
							this._dead = true;
						if (test["time"] < 0.9999999)
							collision = true;
					}
				}
				for each(var powerup:PowerUp in this._level.powerups)
				{
					test = this._player.sweepTestCollision(powerup);
					if (test["collision"])
					{
						this._player.powerup(powerup.powerUpName);
					this._level.killPowerup(powerup);
					}
				}
				
				test = this._player.sweepTestCollision(this._level.goal);
				if (test["collision"])
				{
					this._win = true;
				}
			}
			
			
		}
		public function get ownedPowerups():Vector.<String>
		{
			return this._player.ownedPowerups.items;
		}
		public function get activePowerups():Vector.<String>
		{
			return this._player.activePowerups.items;
		}
		// checks the keys
		private function checkKeys()
		{
			for (var key:Object in this._keyToPowerup)
			{
				if (this._keyboard.isKeyDown(key as uint))
				{
					if (!this._keyToPowerup[key].pressed)
						this._player.togglePowerup(this._keyToPowerup[key].name);
					this._keyToPowerup[key].pressed = true;
				}
				else
				{
					this._keyToPowerup[key].pressed = false;
				}
			}
			// if were holding right or left accelerate quickly in that direction
			// terminal velocityis the accel / friction constant
			if(this._keyboard.isKeyDown(Keyboard.RIGHT) )//&& !this._player.airborne)
			{
				this._player.ax += 4 * (this._player.airborne ? 0.1 : 1);
				this._player.pose = "run";
				this._player.dir = "right";
			}
			else if(this._keyboard.isKeyDown(Keyboard.LEFT) )//&& !this._player.airborne)
			{
				this._player.ax += -4 * (this._player.airborne ? 0.04 : 1);
				this._player.pose = "run";
				this._player.dir = "left";
			} else
			{
				this._player.pose = "standing";
				this.applyFriction();
			}
			// jump
			// only if we arent already jumping
			if ((this._keyboard.isKeyDown(Keyboard.SPACE) || this._keyboard.isKeyDown(Keyboard.UP)) && !this._jumping && !this._player.activePowerups.flagged("spike_shield"))
			{
				this._player.ay += -8;
				this._jumping = true;
			}
			// pause
			if (this._keyboard.isKeyDown(Keyboard.P))
			{
				this._parent.toPause(null);
			}
		}
		// kills the player clip
		public override function kill():void
		{
			this.removeChild(this._player);
			this._player = null;
		}
		// fulfills all requests we make
		public override function fulfill(key:String, target:Layer):void
		{
			if(key == "keyboard")
			{
				this._keyboard = target as KeyboardLayer;
			} else if(key == "level")
			{
				this._level = target as LevelLayer;
			}
		}
		
		public function get player():Player 
		{
			return this._player;
		}
		
		public function get deaths():Number 
		{
			return this._deaths;
		}
		
		public function respawn():void
		{
			this._player.x = this._level.spawnPoint.x;
			this._player.y = this._level.spawnPoint.y;
			this._player.dx = 0;
			this._player.dy = 0;
			this._player.ax = 0;
			this._player.ay = 0;
		}
	}
	
}
