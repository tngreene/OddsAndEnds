package com.layers 
{
	import com.objects.Goal;
	import com.screens.GameScreen;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	/**
	 * This represents a sound manager.
	 * The big important method to this is playSound(...)
	 * It accesses the dictionary and plays a sound from it.
	 * 
	 * The sound files are represented by linkage and do not need classes.
	 * Hence why you'll see ... = new SoundEffectThing(); but no SoundEffectThing class
	 * This saves on the class overload for a bunch of stuff that really isn't needed.
	 * In the library the linkage will simply be SoundEffecThing, not SoundEffectThing.as
	 * 
	 * http://www.flashandmath.com/howtos/as3link/
	 * @author Theodore Greene
	 */
	public class SoundLayer extends Layer 
	{
		//CONSTANTS
		private const FAKE_END:Number = .000001;
		
		//FAKE ENUM FOR ALL SOUNDS, helps reduce the number of miss typings
		public const RESPAWN:uint = 0;
		public const MOVE:uint = 1;
		public const DIE:uint = 2;
		public const JUMP:uint = 3;
		public const GOAL:uint = 4;
		public const MUSIC:uint = 5;
		
		//Dictionary of sounds KEY IS UINT, VALUE IS SOUND
		public var _soundDict:Dictionary = new Dictionary(true);
		//PUBLIC VARIABLES
		
		//PRIVATE VARIABLES
		private var _respawn:Sound = new respawn();
		private var _move:Sound = new move();
		private var _die:Sound = new die();
		private var _jump:Sound = new jump();
		private var _goal:Sound = new goal();
		private var _music:Sound = new music();
		
		private var _keyboard:KeyboardLayer = null;
		var temp:SoundTransform = new SoundTransform();
		private var _volumeControl:SoundMixer;// = new SoundMixer();
		public function SoundLayer(_parent:GameScreen) 
		{
			super(_parent);
			
		}//end constructor
	
		//PUBLIC FUNCTIONS
		public override function setup(mediator:LayerMediator):Boolean
		{
			super.setupMediator(mediator, "sound");
			
			//Assaigns a new soundchannel to the dictionary spot
			
			/*
			* Sets each spot in the dictionary to a sound channel featuring a sound
			* The reason for this is two fold
			* 1.) Populate the dictionary
			* 2.) Ensure that our later code (playSound's if statements) will work
			* Sadly, AS3's sound is this much terrible.
			*/
			_soundDict[RESPAWN] = _respawn.play(_respawn.length - FAKE_END);
			_soundDict[MOVE] = _move.play(_move.length - FAKE_END);
			_soundDict[DIE] = _die.play(_die.length-FAKE_END);
			_soundDict[JUMP] = _jump.play(_jump.length - FAKE_END);
			_soundDict[GOAL] = _goal.play(_goal.length-FAKE_END);
			
			/*DISABLE LINE TO STOP MUSIC*/_soundDict[MUSIC] = _music.play(0,9999);
			this._mediator.request("keyboard", this);
			stage.addEventListener("LAST_KEY",toggleMute);
			return true;
		}
		
		//Plays a sound by passing in it's name
		public function playSound(name:uint)
		{
			//Test to see if there is a sound channel with that name, is not needed?
			var playSound:SoundChannel = _soundDict[name];
			
			switch(name)
			{
				case RESPAWN:
					if (_soundDict[name].position >= _respawn.length)
					{
						_soundDict[name] = _respawn.play();
					}
					break;
				case MOVE:
					if (_soundDict[name].position >= _move.length)
					{
						_soundDict[name] = _move.play();
					}
					break;
				case DIE:
					if (_soundDict[name].position >= _die.length)
					{
						_soundDict[name] = _die.play();
					}
					break;
				case JUMP:
					if (_soundDict[name].position >= _jump.length)
					{
						_soundDict[name] = _jump.play();
					}
					break;
				case GOAL:
					if (_soundDict[name].position >= _goal.length)
					{
						_soundDict[name] = _goal.play();
					}
					break;
				case MUSIC:
					//_soundDict[name] = _music.play(0,int.MAX_VALUE);
					break;
				default:
					throw new Error("Not a real sound");
					break;
			}
		}
		
		public override function onFrame():void
		{
			
		}
		public function toggleMute(e:Event)
		{
			
			SoundMixer.soundTransform=temp;
			
			//trace(temp.volume);
			if (_keyboard.LastKeyPressed == 77)
			{
				if (temp.volume== 0)
				{
					temp.volume = 1;
				}
				else 
				{
					temp.volume = 0;
				}
			}
			//trace(temp.volume);
		}
		public override function kill():void
		{
			/*DISABLE LINE TO STOP MUSIC*/_soundDict[MUSIC].stop();			
			removeEventListener(_keyboard.LAST_KEY,toggleMute);
		}
		public override function fulfill(key:String, target:Layer):void
		{
			if(key == "keyboard")
			{
				this._keyboard = target as KeyboardLayer;
				
			}
			
		}
		
		//PRIVATE FUNCTIONS
	
	}//end class
	
}//end package