package com.element
{
	import com.abstract.AGameManager;
	import com.abstract.AGameElement;

	// Reprents the player clip
	// does its own velocity and position calculations
	public class Player extends AGameElement 
	{
		private var _dir:String;
		private var _pose:String;
		private var _dead:Boolean = false;
		
		//Recomend: Replace this with a method that asks if the health is low enough
		//the less variable based programing the better
		public function get dead():Boolean
		{
			return _dead;
		}
		public function set dead(value:Boolean)
		{
			_dead = value;
		}
		public function Player(pGameManager:AGameManager) 
		{
			super(pGameManager);
			this._dir = "left";
		}
		public override function get halfHeight():Number
		{
			return 40;
		}
		public override function  get halfWidth():Number
		{
			return 8;
		}
		
		public function get dir():String 
		{
			return _dir;
		}
		
		public function set dir(value:String):void 
		{
			_dir = value;
		}
		
		public function get pose():String 
		{
			return _pose;
		}
		
		public function set pose(value:String):void 
		{
			_pose = value;
		}
		// reset accelerations
		public function resetAcceleration()
		{
			this.ax = 0;
			this.ay = 0;
		}
		
		public function takeDamage(amount:uint):void
		{
			//health--
			//if health is < 0
			//dead is true
			
			//for now though, just make you dead.
			_dead = true;
		}
		public override function update():void
		{
			super.update();//Not sure how this line works
			if (this.dx == 0)
				this.pose = "";
			
			if (this.airborne)
				this.gotoAndStop("jump " + this._dir);
			else
				this.gotoAndStop((this.pose == "" ? "" : (this.pose + " ")) + this._dir);
		}
	}
}
