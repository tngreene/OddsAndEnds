package com 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.abstract.*;
	/*import com.layers.Layer;
	import com.layers.PlayerLayer;
	import com.layers.KeyboardLayer;
	import com.layers.LayerMediator;
	import com.layers.LevelLayer;*/

	public class Document extends MovieClip
	{
		//private var layers:Vector.<Layer>;
		private var _model:AModel;
		private var _view:AView;
		private var _controller:AController;
		public function Document()
		{
			//setup();
		}
		// set up layers on the screen
		/*public function setup():void
		{
			this.layers = new Vector.<Layer>();
			this.layers.push(new PlayerLayer(this));			
			this.layers.push(new KeyboardLayer(this));
			this.layers.push(new LevelLayer(this));
			// give the layers a mediator
			// to enable communication between layers
			
			var mediator:LayerMediator = new LayerMediator();
			
			for(var i:int = 0; i < this.layers.length; i++)
			{
				this.layers[i].setup(mediator);
			}
			
			this.addEventListener(Event.ENTER_FRAME, this.onFrame);
		}
		// basic game loop
		public function onFrame(e:Event)
		{
			for each(var layer:Layer in this.layers)
			{
				layer.onFrame();
			}
		}*/
	}
}
