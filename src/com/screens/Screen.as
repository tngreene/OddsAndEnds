package com.screens 
{
	import com.Document;
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class Screen extends MovieClip
	{
		protected var _parent:Document;
		private var _pause:Boolean;
		public var update:Function;
		public function Screen(parent:Document) 
		{
			this._parent = parent;
			this._parent.addChild(this);
			this._pause = true;
			this.hide();
			this.update = this.doNothing;
		}
		private function doNothing():void
		{
			
		}
		public function show()
		{
			this.visible = true;
		}
		public function hide()
		{
			this.visible = false;
		}
		public function pause()
		{
			this._pause = true;
		}
		public function unpause()
		{
			this._pause = false;
		}
		public function togglePause()
		{
			this._pause = !this._pause;
		}
		public function paused():Boolean
		{
			return this._pause;
		}
		
		public function stopScreen()
		{
			this.hide();
			this.pause();
		}
		public function playScreen()
		{
			this.show();
			this.unpause();
		}
		public function toGame(e:Event)
		{
			this.stopScreen();
			this._parent.playScreen("game");
		}
		public function toInstructions(e:Event)
		{
			this.stopScreen();
			this._parent.playScreen("instructions");
		}
		public function toTitle(e:Event)
		{
			this.stopScreen();
			this._parent.playScreen("title");
		}
		public function toStory(e:Event)
		{
			this.stopScreen();
			this._parent.playScreen("story");
		}
		public function toCredits(e:Event)
		{
			this.stopScreen();
			this._parent.playScreen("credits");
		}
		public function toVictory(e:Event)
		{
			this.stopScreen();
			this._parent.playScreen("victory");
		}
		public function toPause(e:Event)
		{
			this.stopScreen();
			this._parent.playScreen("pause");
		}
		public function exitToMain(e:Event)
		{
			this._parent.resetGame(e);
			this.toTitle(e);
		}
	}

}