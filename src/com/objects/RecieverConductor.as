package com.objects 
{
	import com.layers.Layer;
	/**
	 * ...
	 * @author ...
	 */
	public class RecieverConductor extends Conductor
	{
		private static var _instances:Vector.<RecieverConductor> = new Vector.<RecieverConductor>();
		public function RecieverConductor(parent:Layer) 
		{
			super(parent);
			RecieverConductor._instances.push(this);
		}
		public function setup(gridSize:Number)
		{
			this.x *= gridSize;
			this.y *= gridSize;
		}
		override public function kill():void 
		{
			RecieverConductor._instances.splice(RecieverConductor._instances.indexOf(this), 1);
			super.kill();
		}
		
		static public function getInstances():Vector.<RecieverConductor> 
		{
			return _instances;
		}
	}

}