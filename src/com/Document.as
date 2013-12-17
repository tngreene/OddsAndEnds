package com 
{
	import com.collections.Set;
	import com.screens.CreditsScreen;
	import com.screens.GameScreen;
	import com.screens.InstructionScreen;
	import com.screens.PauseScreen;
	import com.screens.Screen;
	import com.screens.StoryScreen;
	import com.screens.TitleScreen;
	import com.screens.VictoryScreen;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.system.fscommand;
	

	public class Document extends MovieClip
	{
		private var _screens:Object;
		//where the file will be loaded from
		public function Document()
		{
			var set1:Set = new Set();
			
			
			var set2:Set = new Set();
			
			set2.flag("spike_shield");
			set2.flag("lightning_rod");
			set2.flag("strong_arm");
			
			
			//trace(set1.toString());
			
			//trace(set2.toString());
			
			
			
			
			
			
			
			
			this._screens = new Object();
			
			this._screens["game"] = new GameScreen(this);
			this._screens["title"] = new TitleScreen(this);
			this._screens["instructions"] = new InstructionScreen(this);
			this._screens["story"] = new StoryScreen(this);
			this._screens["credits"] = new CreditsScreen(this);
			this._screens["victory"] = new VictoryScreen(this);
			this._screens["pause"] = new PauseScreen(this);
			
			this._screens["title"].playScreen();
			var _music:Sound = new music();
			var tempChannel:SoundChannel = _music.play(0, 9999);
			this.addEventListener(Event.ENTER_FRAME, this.onFrame);
		}
		public function onFrame(e:Event)
		{
			for each (var screen:Screen in this._screens)
			{
				if (screen.visible && !screen.paused())
				{
					screen.update();
				}
			}
		}
		public function pauseScreen(name:String)
		{
			this._screens[name].pause();
		}
		public function unpauseScreen(name:String)
		{
			this._screens[name].unpause();
		}
		public function togglePauseScreen(name:String)
		{
			this._screens[name].togglePause();
		}
		public function showScreen(name:String)
		{
			this._screens[name].show();
		}
		public function hideScreen(name:String)
		{
			this._screens[name].hide();
		}
		public function stopScreen(name:String)
		{
			this._screens[name].stopScreen();
		}
		public function playScreen(name:String)
		{
			this._screens[name].playScreen();
		}
		public function exitClick(e:Event)
		{
			fscommand("quit");
		}
		public function resetGame(e:Event)
		{
			this._screens["game"].reset();
		}
		
	}
}
