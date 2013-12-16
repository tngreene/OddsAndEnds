package com.objects 
{
	/**
	 * ...
	 * @author ...
	 */
	public class Timer 
	{
		private var _duration:Number;
		private var _time:Number;
		private var _running:Boolean;
		private var _callback:Function;
		public function Timer()
		{
			this._running = false;
		}
		public function start(duration:Number, callback:Function)
		{
			this._duration = duration;
			this._running = true;
			this._time = 0;
			this._callback = callback;
		}
		public function onFrame()
		{
			if (this._running)
			{
				this._time++;
				if (this._time > this._duration)
				{
					this._running = false;
					this._callback();
				}
			}
		}
		
		public function isRunning():Boolean 
		{
			return _running;
		}
	}

}