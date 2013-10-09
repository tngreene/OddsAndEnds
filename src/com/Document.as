package com 
{
	import com.layers.OffsetLayer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.layers.Layer;
	import com.layers.PlayerLayer;
	import com.layers.KeyboardLayer;
	import com.layers.LayerMediator;
	import com.layers.LevelLayer;

	public class Document extends MovieClip
	{
		private var layers:Vector.<Layer>;
		private var offsetLayer:OffsetLayer;
		public function Document()
		{
			setup();
		}
		// set up layers on the screen
		public function setup():void
		{
			this.layers = new Vector.<Layer>();
			this.offsetLayer = new OffsetLayer(this);
			this.layers.push(this.offsetLayer);
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
			this.x = this.offsetLayer.offsetX;
			this.y = this.offsetLayer.offsetY;
			for each(var layer:Layer in this.layers)
			{
				layer.onFrame();
			}
		}
	}
}
