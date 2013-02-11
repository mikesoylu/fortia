package com.mikesoylu.fortia
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import starling.core.Starling;
	
	/**
	 * Main entry point of a fortia game
	 */
	public class fGame extends Sprite
	{
		public static var starling:Starling = null;
		
		static private var _isHighDefinition:Boolean = false;
		static private var _isRunningOnDevice:Boolean = false;
		
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
		
		/**
		 * This is called once the fortia game stage is created
		 */
		protected function initGame(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initGame);
			
			if (null != starling)
			{
				throw new fError("game already initialised");
			}
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			starling = new Starling(initialClass, stage);
			starling.antiAliasing = AA;
			starling.simulateMultitouch = true;
			starling.start();
			
			_isHighDefinition = fGame.height >= 720;
			
			switch (Capabilities.playerType)
			{
				case 'PlugIn':
				case 'ActiveX':
				case 'StandAlone':
					_isRunningOnDevice = false;
					break;
				default:
					_isRunningOnDevice = true;
			}
			
			trace("<fGame> isHighDefinition:", _isHighDefinition);
			trace("<fGame> isRunningOnDevice:", _isRunningOnDevice);
			trace("<fGame>", fGame.width + "x" + fGame.height);
		}
		
		/**
		 * gets the current fState
		 */
		public static function get scene():fScene
		{
			return starling.stage.getChildAt(0) as fScene;
		}
		
		/**
		 * changes the state and kills the previous
		 */
		public static function set scene(rhs:fScene):void
		{
			(starling.stage.getChildAt(0) as fScene).destroy();
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
		
		/** is the app screen height bigger than 720px */
		static public function get isHighDefinition():Boolean 
		{
			return _isHighDefinition;
		}
		
		/** is the app running on a mobile device */
		static public function get isRunningOnDevice():Boolean 
		{
			return _isRunningOnDevice;
		}
	}
}