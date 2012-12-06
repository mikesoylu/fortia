package com.mikesoylu.fortia 
{
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	public class fState extends Sprite 
	{
		/**
		 * Elapsed time since load
		 */
		protected static var elapsedTime:Number = 0;
		protected static var frameTime:Number = 0;
		
		private var shakeCounter:Number = 0;
		
		public function fState() 
		{
			addEventListener(Event.ADDED, init);
		}
		/** is called when object is added */
		public function init(e:Event):void
		{
			removeEventListener(Event.ADDED, init);
			addEventListener(EnterFrameEvent.ENTER_FRAME, frameListener);
		}
		
		/** TODO: make this variable intensity */
		public function shake(duration:Number):void
		{
			if (shakeCounter < duration)
			{
				shakeCounter = duration;
			}
		}
		/** is called on enter frame, dt is in seconds */
		public function update(dt:Number):void
		{
			
		}
		/** is called when state is removed */
		public function destroy():void
		{
			removeEventListener(EnterFrameEvent.ENTER_FRAME, frameListener);
			for (var i:int = 0; i < numChildren; i++)
			{
				var ch:DisplayObject = getChildAt(i);
				if (ch is fIBasic)
				{
					(ch as fIBasic).destroy();
				}
			}
			// clear the juggler
			Starling.juggler.purge();
		}
		
		private function frameListener(e:EnterFrameEvent):void
		{
			elapsedTime += e.passedTime;
			var dt:Number = e.passedTime;
			frameTime = dt;
			var i:int;
			/* iterate over children */
			for (i = 0; i < numChildren; i++)
			{
				var ch:DisplayObject = getChildAt(i);
				if (ch is fIBasic && ch.visible)
				{
					(ch as fIBasic).update(dt);
				}
			}
			
			// shake the mother fucker
			if (shakeCounter > 0)
			{
				x = Math.random() * 10 - 5;
				y = Math.random() * 10 - 5;
			} else
			{
				x = 0;
				y = 0;
			}
			shakeCounter -= dt;
			
			update(dt);
		}
	}

}