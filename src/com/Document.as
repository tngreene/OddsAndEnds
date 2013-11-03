package com 
{
	//1 michigan
	import com.layers.OffsetLayer;
	//Add the xml manager
	import com.layers.XMLManager;
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.layers.Layer;
	import com.layers.PlayerLayer;
	import com.layers.KeyboardLayer;
	import com.layers.LayerMediator;
	import com.layers.LevelLayer;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class Document extends MovieClip
	{
		//where the file will be loaded from
		private static const XML_PATH:String = "level.xml";
		private var layers:Vector.<Layer>;
		private var offsetLayer:OffsetLayer;
		private var mediator:LayerMediator;
		private var setupDone:Boolean;
		public function Document()
		{
			this.layers = new Vector.<Layer>();
			this.offsetLayer = new OffsetLayer(this);
			this.layers.push(this.offsetLayer);
			this.layers.push(new LevelLayer(this));
			this.layers.push(new PlayerLayer(this));			
			this.layers.push(new KeyboardLayer(this));
			
			this.mediator = new LayerMediator();
			this.setupDone = false;
			//this.addEventListener(Event.ENTER_FRAME, this.setup);
			//Make the XML Manager work, since this is replacing the url loading, it controls setup
			XMLManager.xmlInstance.loadXML(XML_PATH);
			XMLManager.xmlInstance.addEventListener(XMLManager.LOAD_COMPLETE, setup);
		}
		// set up layers on the screen
		public function setup(e:Event):void
		{
			this.setupDone = true;
	
			for(var i:int = 0; i < this.layers.length; i++)
			{
				if (!this.layers[i].setup(mediator))
				{
					this.setupDone = false;
				}
			}

				//this.removeEventListener(Event.ENTER_FRAME, this.setup);
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
