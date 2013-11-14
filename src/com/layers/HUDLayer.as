package com.layers 
{
	import com.objects.HUD;
	import flash.display.MovieClip;
	
	public class HUDLayer extends Layer 
	{
			
		private var _hud_mc:HUD;
		public function HUDLayer(_parent:MovieClip) 
		{
			super(_parent);
			this._hud_mc = new HUD(this);
		}
		// setups the player
		public override function setup(mediator:LayerMediator):Boolean
		{
			super.setupMediator(mediator, "hud");
			this._mediator.request("offset", this);
			return true;
		}
		override public function onFrame():void 
		{
			this._hud_mc.death_counter.text = "";
		}
		public override function fulfill(key:String, target:Layer):void
		{
			if (key == "offset")
			{
				this._levelLayer = target as LevelLayer;
			} else if (key == "player")
			{
				this._playerLayer = target as PlayerLayer;
			}
		}
	}

}