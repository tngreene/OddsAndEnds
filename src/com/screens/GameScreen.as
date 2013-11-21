package com.screens 
{
	import com.Document;
	import com.layers.BackgroundLayer;
	import com.layers.HUDLayer;
	import com.layers.KeyboardLayer;
	import com.layers.LayerMediator;
	import com.layers.LevelLayer;
	import com.layers.OffsetLayer;
	import com.layers.PlayerLayer;
	import com.layers.Layer;
	import com.layers.SoundLayer;
	import com.layers.XMLManager
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class GameScreen extends Screen 
	{
		private static const XML_PATH:String = "level.xml";
		private var layers:Vector.<Layer>;
		private var offsetLayer:OffsetLayer;
		private var mediator:LayerMediator;
		private var setupDone:Boolean;
		
		public function GameScreen(parent:Document) 
		{
			super(parent);
			
			this.layers = new Vector.<Layer>();	
			this.layers.push(new BackgroundLayer(this));
			this.offsetLayer = new OffsetLayer(this);
			this.layers.push(this.offsetLayer);
			this.layers.push(new LevelLayer(this));
			this.layers.push(new SoundLayer(this));
			this.layers.push(new PlayerLayer(this));
			this.layers.push(new HUDLayer(this));
			this.layers.push(new KeyboardLayer(this));
			
			
			this.mediator = new LayerMediator();
			this.setupDone = false;
			
			//Make the XML Manager work, since this is replacing the url loading, it controls setup
			XMLManager.xmlInstance.loadXML(XML_PATH);
			XMLManager.xmlInstance.addEventListener(XMLManager.LOAD_COMPLETE, startSetup);
			
		}
		public function reset()
		{
			
			this.layers = new Vector.<Layer>();	
			this.layers.push(new BackgroundLayer(this));
			this.offsetLayer = new OffsetLayer(this);
			this.layers.push(this.offsetLayer);
			this.layers.push(new LevelLayer(this));
			this.layers.push(new SoundLayer(this));
			this.layers.push(new PlayerLayer(this));
			this.layers.push(new HUDLayer(this));
			this.layers.push(new KeyboardLayer(this));
			this.mediator = new LayerMediator();
			this.setupDone = false;
			
			this.startSetup(null);
			
		}
		public function startSetup(e:Event)
		{
			super.update = setupLayers;
		}
		// set up layers on the screen
		public function setupLayers():void
		{
			this.setupDone = true;
	
			for(var i:int = 0; i < this.layers.length; i++)
			{
				if (!this.layers[i].setup(mediator))
				{
					this.setupDone = false;
				}
			}

			if (this.setupDone)
			{
				super.update = this.onFrame;
			}
		}
		// basic game loop
		public function onFrame()
		{
			this.x = Math.floor(this.offsetLayer.offsetX);
			this.y = Math.floor(this.offsetLayer.offsetY);
			for each(var layer:Layer in this.layers)
			{
				layer.onFrame();
			}
		}
		
	}

}