package com
{
	import com.manager.LevelManager;
	import com.manager.OffsetManager;
	import com.manager.PlayerManager;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * This class is the main game screen for the game
	 * @author Theodore Greene
	 */
	public class  MainGame extends Sprite
	{
		//A fake enum for our finite state machine
		public static const FSM_GAME_START:uint = 0;
		public static const FSM_SPAWN:uint = 1;//Player spawning or respawning
		public static const FSM_PLAYING:uint = 2;//Playing the game (aka moving, jumping, etc)
		public static const FSM_DIEING:uint = 3;//Player dieing
		public static const FSM_GAME_OVER:uint = 4;//Player has lost all lives
		
		//the finite statemachine varialb
		public static var FSM_MODE:uint = FSM_GAME_START;
		
		//private gameManagers
		private var _levelManager:LevelManager;
		private var _offsetManager:OffsetManager;
		private var _playerManager:PlayerManager;
		
		public function get levelManager():LevelManager
		{
			return _levelManager;
		}
		public function get playerManager():PlayerManager
		{
			return _playerManager;
		}
		public function MainGame()
		{
			//Create managers here
			_levelManager = new LevelManager(this);
			_offsetManager = new OffsetManager(this);
			_playerManager = new PlayerManager(this);
			
			//Call init's afterward
			_levelManager.init();
			
			//Player
			_playerManager.init();
			
			_offsetManager.init();
			//Set up vital variables here
		}
		
		public function init()
		{
			//Add the managers via add child
			addChild(_levelManager);
			addChild(_offsetManager);
			addChild(_playerManager);
			
			//Add event listeners
			addEventListener(Event.ENTER_FRAME, gameLoop);
		}
		
		public function deconstruct()
		{
			removeEventListener(Event.ENTER_FRAME, gameLoop);
		}
		private function gameLoop(e:Event):void
		{
			switch(FSM_MODE)
			{
				case FSM_GAME_START:
					changeState(FSM_GAME_START,FSM_SPAWN);
					break;
				case FSM_SPAWN:
					_playerManager.respawn();
					changeState(FSM_SPAWN, FSM_PLAYING);
					break;
				case FSM_PLAYING:
					//Call the update methods of various classes
					_playerManager.update();
					_offsetManager.update();
					if (_playerManager.player.dead == true)
					{
						changeState(FSM_PLAYING, FSM_DIEING);
					}
					if (_playerManager.win == true)
					{
						_levelManager.levels[_levelManager.currentLevel].background.changeBackground("psyc_t");
						changeState(FSM_PLAYING, FSM_SPAWN);
					}
					//make the stage move
					//this.x = _offsetManager.offsetX;
					//this.y = _offsetManager.offsetY;
					break;
				case FSM_DIEING:
					//if player has lives
					//{
					changeState(FSM_DIEING, FSM_SPAWN);
					//}
					//else{
					//changeState(FSM_DIEING, 
					break;
				case FSM_GAME_OVER:
					break;
				default:
					throw new Error("You have entered an invalid mode");
					break;
			}
		}
		
		//Changes from one state to another, entering in a nonexistant state causes to ignore
		//that switch statement. USE WITH EXTREME CAUTION!
		//Debating whether or not it is a good idea to be able to say what you're chaningfrom
		private function changeState(changeFrom:uint, changeTo:uint):void
		{
			//Change from block
			switch(FSM_MODE)
			{
				case FSM_GAME_START:
					break;
				case FSM_SPAWN:
					break;
				case FSM_PLAYING:
					break;
				case FSM_DIEING:
					break;
				case FSM_GAME_OVER:
					break;
				default:
					trace("You have entered an invalid mode");
					break;
			}
			
			//Change to block
			switch(changeTo)
			{
				case FSM_GAME_START:
					FSM_MODE = FSM_GAME_START;
					break;
				case FSM_SPAWN:
					FSM_MODE = FSM_SPAWN;
					break;
				case FSM_PLAYING:
					FSM_MODE = FSM_PLAYING;
					break;
				case FSM_DIEING:
					FSM_MODE = FSM_DIEING;
					break;
				case FSM_GAME_OVER:
					FSM_MODE = FSM_GAME_OVER;
					break;
				default:
					trace("trace you have entered an invalid mode");
					break;
			}
		}
	}
	
}