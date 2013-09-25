package code.layers
{
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import code.objects.Player;
	
	public class PlayerLayer extends Layer
	{
		private var _player:Player;
		private var _keyboard:KeyboardLayer;
		private var _jumping:Boolean;
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
			this._player.y = stage.stageHeight;
			// not jumping either
			this._jumping = false;
			this.addChild(this._player);
			// requests keyboard access
			this._mediator.request("keyboard", this);
		}
		
		// calls all the functions
		// that need to be called once a frame
		public override function onFrame():void
		{
			// set acceleration to 0 so we can mess with it later
			this._player.resetAcceleration();
			// check keys
			this.checkKeys();
			// calculate drag and friction
			this.calculateAcceleration();
			// make sure we dont go too fast
			this.limitVelocities();
			// actually move the character
			this._player.onFrame();
			// make sure we dont go off screen
			this.checkBounds();
		}
		// limits the x velocity so we dont go too fast
		private function limitVelocities()
		{
			// if its speeds greater than 10, set it to 10
			if(Math.abs(this._player.dx) > 10)
			{
				this._player.dx = (this._player.dx / Math.abs(this._player.dx)) * 10;
			}
		}
		// calculates drag and friction
		private function calculateAcceleration()
		{
			// if we aren't airborne
			// add friction
			if(this._player.dy == 0 && this._player.ay == 0)
				this._player.ax += this._player.dx * -0.2;
		}
		// checks the screen boundries
		private function checkBounds()
		{
			// if were falling below the stage
			// fix it
			if(this._player.y > stage.stageHeight)
			{
				// puts us on the grand
				this._player.y = stage.stageHeight;
				// stops us from moving and lets us jump again
				this._player.dy = 0;
				this._player.ay = 0;
				this._jumping = false;
			}
			// make sure we dont overextend past the left and right of the screen
			if(this._player.x > stage.stageWidth)
			{
				this._player.x = stage.stageWidth;
			}
			if(this._player.x < 0)
			{
				this._player.x = 0;
			}
		}
		// checks the keys
		private function checkKeys()
		{
			// if were holding right or left accelerate quickly in that direction
			// terminal velocityis the accel / friction constant
			if(this._keyboard.isKeyDown(Keyboard.RIGHT))
			{
				this._player.ax += 2;
			}
			else if(this._keyboard.isKeyDown(Keyboard.LEFT))
			{
				this._player.ax += -2;
			}
			// jump
			// only if we arent already jumping
			if(this._keyboard.isKeyDown(Keyboard.UP) && !this._jumping)
			{
				this._player.dy = -10;
				this._player.ay = 0.5;
				this._jumping = true;
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
			}
		}
	}
	
}
