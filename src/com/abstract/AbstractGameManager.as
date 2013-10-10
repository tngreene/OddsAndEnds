package  com.abstract
{	
//Created by Theodore "Ted" Greene

	import flash.display.Sprite;
	import com.MainGame;
	
	//this class is an abstract that all other game managers must inherint from
	//a manager class allows for control and use of protected black box classes
	public class AbstractGameManager extends Sprite
	{
		protected var _mainGame:MainGame;
		
		public function AbstractGameManager(pMainGame:MainGame) 
		{
			// constructor code
			//trace(this + " created");
			
			_mainGame = pMainGame;
		}//end constructor
	}//end class
}//end package
