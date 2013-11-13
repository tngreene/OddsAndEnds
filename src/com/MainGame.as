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
					if (_levelManager.levels.length == 0)
					{
						
					}
					else
					{
						changeState(FSM_GAME_START);
					}
					break;
				case FSM_SPAWN:
					changeState(FSM_SPAWN);
					break;
				case FSM_PLAYING:
					//Call the update methods of various classes
					_playerManager.update();
					_offsetManager.update();
					this.x = _offsetManager.offsetX;
					this.y = _offsetManager.offsetY;
					break;
				case FSM_DIEING:
					break;
				case FSM_GAME_OVER:
					break;
				default:
					throw new Error("You have entered an invalid mode");
					break;
			}
		}
		
		//Changes the FSM by calling the Leave/EnterState methods.
		//The parameter represents the state you are chaging from,
		//the machine knows what you will be going to next.
		private function changeState(changeFrom:uint):void
		{
			switch(changeFrom)
			{
				case FSM_GAME_START:
					leaveState(FSM_GAME_START);
					enterState(FSM_SPAWN);
					break;
				case FSM_SPAWN:
					leaveState(FSM_SPAWN);
					enterState(FSM_PLAYING);
					break;
				case FSM_PLAYING:
					break;
				case FSM_DIEING:
					break;
				case FSM_GAME_OVER:
					break;
				default:
					throw new Error("You have entered an invalid mode");
					break;
			}
		}
		
		//Used to clean up or export values of an object while leaving a state
		//do not call on your own
		//put in the mode you are leaving
		private function leaveState(mode:uint):void
		{
			switch(mode)
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
					throw new Error("You have entered an invalid mode");
					break;
			}
		}
		
		//Used to set up objects or variables before entering a state,
		//Do not call on your own, use change state instead
		//Put in the mode you will be entering
		private function enterState(mode:uint):void
		{
			//MUST INCLUDE THE FSM_MODE change. This should be the only place it changes
			//In order to keep the system in line. Other code is optional too
			switch(mode)
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
					throw new Error("You have entered an invalid mode");
					break;
			}
		}
	}
	
}