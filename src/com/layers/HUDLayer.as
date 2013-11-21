package com.layers 
{
	import com.objects.HUD;
	import com.objects.Player;
	import com.screens.GameScreen;
	import flash.display.MovieClip;
	
	public class HUDLayer extends Layer 
	{
			
		private var _hud_mc:HUD;
		//private var _item_hud_mc:ItemHUD;
		private var _offsetLayer:OffsetLayer;
		private var _playerLayer:PlayerLayer;
		private var _levelLayer:LevelLayer;
		public function HUDLayer(_parent:GameScreen) 
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
			this._mediator.request("level", this);
			return true;
		}
		override public function onFrame():void 
		{
			this._hud_mc.death_counter.text = "Deaths: " + this._playerLayer.deaths;
			this.x = -this._parent.x;
			this.y = -this._parent.y;
			this._hud_mc.level_counter.text = "Level: " + (this._levelLayer.currentLevel + 1);
			for each(var str:String in this._playerLayer.ownedPowerups)
			{
				this._hud_mc[str + "_mc"].visible = true;
				this._hud_mc[str + "_mc"].gotoAndStop(str);
				this._hud_mc[str + "_mc"].alpha = 0.2;
			}
			for each(str:String in this._playerLayer.activePowerups)
			{
				this._hud_mc[str + "_mc"].alpha = 0.8;
			}
		}
		public override function fulfill(key:String, target:Layer):void
		{
			if (key == "offset")
			{
				this._offsetLayer = target as OffsetLayer;
			} else if (key == "player")
			{
				this._playerLayer = target as PlayerLayer;
			} else if (key == "level")
			{
				this._levelLayer = target as LevelLayer;
			}
		}
	}

}