package com.screens 
{
	import com.Document;
	/**
	 * ...
	 * @author ...
	 */
	public class ScreenManager 
	{
		public static function stop(origin:Screen)
		{
			if (origin != null)
			{
				origin.hide();
				origin.pause();
			}
		}
		public static function startGame(origin:Screen, doc:Document)
		{
			ScreenManager.stop(origin);
			doc.showScreen("game");
			doc.unpauseScreen("game");
		}
		public static function toInstructions(origin:Screen, doc:Document)
		{
			ScreenManager.stop(origin);
			doc.showScreen("instructions");
			doc.unpauseScreen("instructions");
		}
		public static function toTitle(origin:Screen, doc:Document)
		{
			ScreenManager.stop(origin);
			doc.showScreen("title");
			doc.unpauseScreen("title");
		}
		
	}

}