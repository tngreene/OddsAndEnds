package code.layers 
{
	
	// used to issue and fulfill requests
	// between layers for other layers
	public class LayerMediator 
	{
		// currently pending requests
		var _requests:Object;
		// current layers being mediated
		var _layers:Object;
		
		// setup for mapping layers and requests
		public function LayerMediator() 
		{
			this._layers = new Object();
			this._requests = new Object();
		}
		// adds a layer to the ones being mediated
		// fulfills all requests pending for them
		public function addLayer(layer:Layer, key:String)
		{
			// adds the layer to the layer map
			this._layers[key] = layer;
			// checks to see if there are pending requests
			if(key in this._requests)
			{
				// fulfills all requests
				for each(var requester:Layer in this._requests[key])
				{
					requester.fulfill(key, this._layers[key]);
				}
			}
		}
		// removes layers from mediation
		public function removeLayer(layer:Layer)
		{
			this._layers.splice(this._layers.indexOf(layer), 1);
		}
		// called when being a issued a request for another layer
		// requires the target layer name, and a copy of the requesting layer
		public function request(key:String, requester:Layer):void
		{
			// if its already here, send it out
			if(key in this._layers)
			{
				requester.fulfill(key, this._layers[key]);
			}
			else
			{
				// if its not already here, put in a request
				
				// sets up the list of layers pending for the
				// current key if not already set up
				if(!(key in this._requests))
					this._requests[key] = new Array();
				// pushes the request
				this._requests[key].push(requester);
			}
		}
	}
	
}
