package code 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import code.layers.Layer;
	import code.layers.PlayerLayer;
	import code.layers.KeyboardLayer;
	import code.layers.LayerMediator;

	public class Document extends MovieClip
	{
		private var layers:Vector.<Layer>;
		public function Document()
		{
			setup();
		}
		// set up layers on the screen
		public function setup():void
		{
			this.layers = new Vector.<Layer>();
			this.layers.push(new PlayerLayer(this));			
			this.layers.push(new KeyboardLayer(this));
			
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
		}
	}
}
