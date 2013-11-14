package com.layers 
{
	import com.objects.HUD;
	import com.objects.Player;
	import flash.display.MovieClip;
	
	public class HUDLayer extends Layer 
	{
			
		private var _hud_mc:HUD;
		private var _offsetLayer:OffsetLayer;
		private var _playerLayer:PlayerLayer;
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
			this._mediator.request("player", this);
			return true;
		}
		override public function onFrame():void 
		{
			this._hud_mc.death_counter.text = "Deaths: " + this._playerLayer.deaths;
			this.x = -this._parent.x;
			this.y = -this._parent.y;
		}
		public override function fulfill(key:String, target:Layer):void
		{
			if (key == "offset")
			{
				this._offsetLayer = target as OffsetLayer;
			} else if (key == "player")
			{
				this._playerLayer = target as PlayerLayer;
			}
		}
	}

}