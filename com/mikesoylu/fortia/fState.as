package com.mikesoylu.fortia 
{
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	public class fState extends Sprite 
	{
		private var shakeTween:Tween;
		/**
		 * Elapsed time since load
		 */
		protected static var elapsedTime:Number = 0;
		protected static var frameTime:Number = 0;
		
		// private var shakeCounter:Number = 0;
		
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
		
		public function flash(duration:Number, color:uint = 0xFFFFFF):void
		{
			var overlay:Quad = new Quad(fGame.width, fGame.height);
			addChild(overlay);
			
			var tween:Tween = new Tween(overlay, duration);
			tween.fadeTo(0);
			tween.onComplete = function():void { removeChild(overlay); };
			Starling.juggler.add(tween);
		}
		
		/** TODO: make this variable intensity */
		public function shake(duration:Number):void
		{
			// tween the screen to a random pos
			this.x = Math.random() * 20 - 10;
			this.y = Math.random() * 20 - 10;
			if (shakeTween != null)
			{
				Starling.juggler.remove(shakeTween);
			}
			shakeTween = new Tween(this, duration, Transitions.EASE_OUT);
			shakeTween.moveTo(0,0);
			Starling.juggler.add(shakeTween);
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
			
			fGame.updateSounds(dt);
			
			update(dt);
		}
	}

}