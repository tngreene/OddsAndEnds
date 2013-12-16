package com.objects 
{
	import com.layers.Layer;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SourceConductor extends Conductor 
	{
		public var maxRange:Number;
		private var _lightningBolt:LightningBolt;
		private var _oldtarget:RecieverConductor;
		public function SourceConductor(_parent:Layer) 
		{
			super(_parent);
			this._lightningBolt = new LightningBolt(_parent);
		}
		public function setup(gridSize:Number)
		{
			this.x *= gridSize;
			this.y *= gridSize;
			this.maxRange *= gridSize;
			this._lightningBolt.source = new Point(this.sourceX, this.sourceY);
		}
		
		public override function onFrame() 
		{
			super.onFrame();
			var target:RecieverConductor = null;
			var smallestDistance:Number = maxRange + 0.2;
			for each(var reciever:RecieverConductor in RecieverConductor.getInstances())
			{
				if (reciever.distanceTo(this) < smallestDistance)
				{
					target = reciever;
					smallestDistance = target.distanceTo(this);
				}
			}
			if (target != null )//&& target != this._oldtarget)
			{
				this._lightningBolt.target = new Point(target.sourceX, target.sourceY);
				this._oldtarget = target;
			}
		}
		public override function kill():void 
		{
			super.kill();
			this._lightningBolt.kill();
		}
		
	}

}