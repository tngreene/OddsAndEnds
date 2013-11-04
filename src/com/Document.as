package com 
{
	import com.abstract.*;
	import com.as3toolkit.ui.Keyboarder;
	import com.manager.OffsetManager;
	import com.manager.XMLManager;
	import flash.display.MovieClip;
	import flash.events.Event;
	//Add the xml manager
	/*import com.layers.Layer;
	import com.layers.PlayerLayer;
	import com.layers.KeyboardLayer;
	import com.layers.LayerMediator;
	import com.layers.LevelLayer;*/

	public class Document extends MovieClip
	{
		private static const XML_PATH:String = "level.xml";
		private var mainGame:MainGame;
		private var kb:Keyboarder;
		
		//private var _view:AView;
		//private var mediator:LayerMediator;
		//private var setupDone:Boolean;
		
		public function Document()
		{
			//Makes a new keyboarder
			kb = new Keyboarder(this);
			
			//Sets up the xml
			XMLManager.xmlInstance.loadXML(XML_PATH);
			XMLManager.xmlInstance.addEventListener(XMLManager.LOAD_COMPLETE, onLoaded);
		}
		
		//Once the XML has loaded the game can really start!
		public function onLoaded(e:Event):void
		{
			/*Inside of here will be a mini FSM that controls going from the start menu (with hopefully eventually an options screen)
			 * to the main game to the start screen or the game over screen
			 * and from the game over screen to the start screen
			 * 
			 *               //Press play        //Lose condition
			 * [Start Screen]----------->[Main Game]----------->[Game Over]
			 *       <-Click "Go to Menu"/        \-Click "Quit"->    |
			 *                                                        |
			 *     ^______________________________________Click "Back"|
			 * */
			
			//Create the start menu
			//startMenu = new StartMenu();
			//addChild(startMenu);
			
			//Create a new main game
			mainGame = new MainGame();
			addChild(mainGame);
			
			//Create 
			mainGame.init();
			
			//Create the game over screen
			//gameOverScreen = new GameOverScreen();
			//addChild(gameOverScreen)
		}
	}
}
