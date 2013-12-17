package com.screens 
{
	import com.Document;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ...
	 */
	public class PauseScreen extends Screen 
	{
		
		public function PauseScreen(_parent:Document)
		{
			super(_parent);
			this.start_btn.addEventListener(MouseEvent.CLICK, this.toGame);
			this.instruct_btn.addEventListener(MouseEvent.CLICK, this.toInstructions);
			this.title_btn.addEventListener(MouseEvent.CLICK, this.exitToMain);
			//When the restart button is clicked it will dispatch "RESTART_LEVEL" for the player to be listenting to
			this.restart_btn.addEventListener(MouseEvent.CLICK, sendRestart);
		}
		
		public function sendRestart(e:Event)
		{
			//Tell the game to restart the level
			dispatchEvent(new Event("RESTART_LEVEL", true));
			
			//Go back to the game screen
			toGame(e);
		}
	}
}