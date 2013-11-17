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
		}
	}
}