package com.screens 
{
	import com.Document;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ...
	 */
	public class InstructionScreen extends Screen 
	{
		
		public function InstructionScreen(_parent:Document)
		{
			super(_parent);
			this.start_btn.addEventListener(MouseEvent.CLICK, this.toGame);
			this.title_btn.addEventListener(MouseEvent.CLICK, this.toTitle);
		}
	}
}