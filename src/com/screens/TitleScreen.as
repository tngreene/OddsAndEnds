package com.screens 
{
	import com.Document;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ...
	 */
	public class TitleScreen extends Screen 
	{
		
		public function TitleScreen(_parent:Document)
		{
			super(_parent);
			this.start_btn.addEventListener(MouseEvent.CLICK, this.toGame);
			this.instruct_btn.addEventListener(MouseEvent.CLICK, this.toInstructions);
			this.story_btn.addEventListener(MouseEvent.CLICK, this.toStory);
			this.credits_btn.addEventListener(MouseEvent.CLICK, this.toCredits);
			this.exit_btn.addEventListener(MouseEvent.CLICK, this._parent.exitClick);
		}
	}
}