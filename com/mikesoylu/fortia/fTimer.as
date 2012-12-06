package com.mikesoylu.fortia 
{
	import flash.utils.setTimeout;
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	
	public class fTimer implements IAnimatable
	{
		private var args:Array;
		
		private var elapsed:Number;
		
		private var callback:Function;
		private var duration:Number;
		private var numLoops:uint;
		
		public function fTimer(callback:Function, duration:Number, numLoops:uint, ...rest)
		{
			args = rest;
			this.callback = callback;
			this.duration = duration;
			this.numLoops = numLoops;
			
			elapsed = 0;
		}
		
		public function advanceTime(time:Number):void 
		{
			if (numLoops <= 0)
			{
				// we're done
				Starling.juggler.remove(this);
			}
			elapsed += time;
			if (elapsed >= duration)
			{
				numLoops--;
				elapsed = 0;
				callback.apply(null, args);
			}
		}
	}
}