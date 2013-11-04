package  com.abstract
{	
//Created by Theodore "Ted" Greene

	import flash.display.Sprite;
	import com.MainGame;
	
	//this class is an abstract that all other game managers must inherint from
	//a manager class allows for control and use of protected black box classes
	public class AGameManager extends Sprite
	{
		protected var _mainGame:MainGame;
		
		public function AGameManager(pMainGame:MainGame) 
		{
			// constructor code
			//trace(this + " created");
			
			_mainGame = pMainGame;
		}//end constructor
		
		public function init():void
		{
			
		}
		public function deconstruct():void
		{
			
		}
		public function update():void
		{
			
		}
	}//end class
}//end package
