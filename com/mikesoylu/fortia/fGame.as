package com.mikesoylu.fortia 
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import starling.core.Starling;

	public class fGame extends Sprite
	{
		public static var starling:Starling;		
		
		static public var isHighDefinition:Boolean = false;
		
		internal var initialClass:Class;
		internal var AA:int;
		
		public function fGame(initialClass:Class, AA:int = 1)
		{
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			Starling.multitouchEnabled = true;
			Starling.handleLostContext = true;
			
			this.initialClass = initialClass;
			this.AA = AA;
			
			addEventListener(Event.ADDED_TO_STAGE, initGame);
		}
		
		protected function initGame(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initGame);
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			starling = new Starling(initialClass, stage);
			starling.antiAliasing = AA;
			starling.simulateMultitouch = true;
			starling.start();
			
			isHighDefinition = fGame.height > 1024;
			
			trace("<fGame> isHighDefinition:", isHighDefinition);
			trace("<fGame>", fGame.width, "x", fGame.height);
		}
        
		/**
		 * gets the current fState
		 */
		public static function get state():fState
		{
			return starling.stage.getChildAt(0) as fState;
		}
		
		/**
		 * changes the state and kills the previous
		 */
		public static function set state(rhs:fState):void
		{
			(starling.stage.getChildAt(0) as fState).destroy();
			starling.stage.removeChildAt(0, true);
			starling.stage.addChildAt(rhs, 0);
		}
		
		public static function get width():int
		{
			return starling.stage.stageWidth;
		}
		
		public static function get height():int
		{
			return starling.stage.stageHeight;
		}
	}
}