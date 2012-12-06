package com.mikesoylu.fortia 
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import starling.events.Event;
	import starling.core.Starling;

	public class fGame extends Sprite
	{
		public static var starling:Starling;		
		
		public function fGame(initialClass:Class, AA:int = 1)
		{
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			Starling.multitouchEnabled = true;
			Starling.handleLostContext = true;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			starling = new Starling(initialClass, stage);
			starling.antiAliasing = AA;
			starling.simulateMultitouch = true;
			starling.start();
		}
        
		public static function get state():fState
		{
			return starling.stage.getChildAt(0) as fState;
		}
		
		public static function set state(rhs:fState):void
		{
			(starling.stage.getChildAt(0) as fState).destroy();
			starling.stage.removeChildAt(0, true);
			starling.stage.addChildAt(rhs, 0);
		}
		
		public static function width():int
		{
			return starling.stage.stageWidth;
		}
		
		public static function height():int
		{
			return starling.stage.stageHeight;
		}
	}
}