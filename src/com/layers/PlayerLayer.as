package com.layers
{
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import com.objects.Player;
	import com.objects.Platform;
	import com.objects.GameObject;
	
	public class PlayerLayer extends Layer
	{
		private var _player:Player;
		private var _level:LevelLayer;
		private var _keyboard:KeyboardLayer;
		private var _jumping:Boolean;
		private var _gravity:Number = 0.2;
		
		public function PlayerLayer(_parent:MovieClip) 
		{
			super(_parent);
		}
		
		// setups the player
		public override function setup(mediator:LayerMediator):void
		{
			super.setupMediator(mediator, "player");
			// initializes the player
			this._player = new Player(this);
			// sets him in the middle by default
			this._player.x = stage.stageWidth / 2;
			this._player.y = 0;
			// not jumping either
			this._jumping = false;
			this.addChild(this._player);
			// requests keyboard access
			this._mediator.request("keyboard", this);
			this._mediator.request("level", this);
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
			// calculate drag and friction
			this.applyFriction();
			// make sure we dont go too fast
			this.limitVelocities();
			
			if(this._jumping && !this._player.airborne)
				this._jumping = false;
			// actually move the character
			this._player.onFrame();
		}
		private function applyGravity()
		{
			this._player.ay += this._gravity;
		}
		// limits the x velocity so we dont go too fast
		private function limitVelocities()
		{
			if (Math.abs(this._player.dy) < 0.02)
			{
				this._player.dy = 0;
			}
			if (Math.abs(this._player.dx) < 0.02)
			{
				this._player.dx = 0;
			}
			if (Math.abs(this._player.ay) < 0.02)
			{
				this._player.ay = 0;
			}
			if (Math.abs(this._player.ax) < 0.02)
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
			if(this._player.dy == 0 && this._player.ay == 0)
				this._player.ax += this._player.dx * -0.8;
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
					var xDist:Number = this._player.fx - platform.x;
					var yDist:Number = this._player.fy - platform.y;
					var xDir:Number = xDist / Math.abs(xDist);
					var yDir:Number = yDist / Math.abs(yDist);
					var xRadius:Number = (this._player.halfWidth + platform.halfWidth);
					var yRadius:Number = (this._player.halfHeight + platform.halfHeight);
					var xPen:Number = xRadius - Math.abs(xDist);
					var yPen:Number = yRadius - Math.abs(yDist);
					
					if (this._player.fdx == 0)
					{
						var yTime:Number = (platform.y - this._player.y) / this._player.fdy;
						var yTimeMin:Number = Math.min(yTime + yRadius / this._player.fdy, yTime - yRadius / this._player.fdy);
						if (yTimeMin >= 0 && yTimeMin < 1 && Math.abs(xDist) < xRadius)
						{
							collision = true;
							this._player.ay -= (1 - yTimeMin) * this._player.fdy;
						}
						
					} else if (this._player.fdy == 0)
					{
						var xTime:Number = (platform.x - this._player.x) / this._player.fdx;
						var xTimeMin:Number = Math.min(xTime + xRadius / this._player.fdx, xTime - xRadius / this._player.fdx);
						if (xTimeMin >= 0 && xTimeMin < 1 && Math.abs(yDist) < yRadius)
						{
							collision = true;
							this._player.ax -= (1 - xTimeMin) * this._player.fdx;
						}
					} else
					{
						var xTime:Number = (platform.x - this._player.x) / this._player.fdx;
						var yTime:Number = (platform.y - this._player.y) / this._player.fdy;
						
						var xTimeMin:Number = Math.min(xTime + xRadius / this._player.fdx, xTime - xRadius / this._player.fdx);
						var yTimeMin:Number = Math.min(yTime + yRadius / this._player.fdy, yTime - yRadius / this._player.fdy);
						if (xTimeMin < 1 && yTimeMin < 1)
						{
							var xTimeMax:Number = Math.max(xTime + xRadius / this._player.fdx, xTime - xRadius / this._player.fdx); 
							var yTimeMax:Number = Math.max(yTime + yRadius / this._player.fdy, yTime - yRadius / this._player.fdy);
							
							if (xTimeMin < yTimeMax && yTimeMin < xTimeMax)
							{
								if ((xTimeMin <= yTimeMin || yTimeMin < 0) && xTimeMin >= 0 )
								{
									collision = true;
									this._player.ax -= (1 - xTimeMin) * this._player.fdx;
								}else if(yTimeMin >= 0)
								{
									collision = true;
									this._player.ay -= (1 - yTimeMin) * this._player.fdy;
								}
							}
						}
					}
				}
			}
			
		}
		// checks the keys
		private function checkKeys()
		{
			// jump
			// only if we arent already jumping
			if(this._keyboard.isKeyDown(Keyboard.UP) && !this._jumping)
			{
				this._player.ay += -8;
				this._jumping = true;
			}
			// if were holding right or left accelerate quickly in that direction
			// terminal velocityis the accel / friction constant
			if(this._keyboard.isKeyDown(Keyboard.RIGHT) )//&& !this._player.airborne)
			{
				this._player.ax += 2 * (this._player.airborne ? 0.04 : 1);
			}
			else if(this._keyboard.isKeyDown(Keyboard.LEFT) )//&& !this._player.airborne)
			{
				this._player.ax += -2 * (this._player.airborne ? 0.04 : 1);
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
	}
	
}
