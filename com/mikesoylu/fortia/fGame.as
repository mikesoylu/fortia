package com.mikesoylu.fortia
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.system.Capabilities;
	import flash.events.Event;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import starling.display.BlendMode;
	import starling.display.DisplayObject;
	
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import starling.core.Starling;
	import starling.events.Event;

	/**
	 * Main entry point of a fortia game
	 */
	public class fGame extends Sprite
	{
		public static const debug:Boolean = CONFIG::debug;

		private static var _starling:Starling = null;
		private static var _isHighDefinition:Boolean = false;
		private static var _isRunningOnDevice:Boolean = false;
		private static var _isHardware:Boolean = false;

		internal var initialClass:Class;
		internal var AA:int;
		internal static var debugText:TextField;

		public function fGame(initialClass:Class, AA:int = 1)
		{
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

			Starling.multitouchEnabled = true;
			Starling.handleLostContext = true;

			this.initialClass = initialClass;
			this.AA = AA;

			addEventListener(flash.events.Event.ADDED_TO_STAGE, initGame);
		}

		/**
		 * This is called once the fortia game stage is created
		 */
		protected function initGame(e:flash.events.Event):void
		{
			removeEventListener(flash.events.Event.ADDED_TO_STAGE, initGame);

			if (null != _starling)
			{
				throw new fError("game already initialised");
			}

			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			_starling = new Starling(initialClass, stage);
			_starling.antiAliasing = AA;

			if (debug)
			{
				_starling.simulateMultitouch = true;
				_starling.enableErrorChecking = true;
				_starling.showStatsAt(HAlign.RIGHT);
			}

			_starling.start();

			_isHighDefinition = Math.max(fGame.height, fGame.width) >= 1080;

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
			trace("<fGame> stageSize:", fGame.width + "x" + fGame.height);

			_starling.addEventListener(starling.events.Event.CONTEXT3D_CREATE, onContextCreated);
		}
		
		private function onContextCreated(e:starling.events.Event):void 
		{
			// are we running hardware or software?
			_isHardware = Starling.context.driverInfo.toLowerCase().indexOf("software") == -1; 
			trace("<fGame> isHardware:", _isHardware);
		}

		/**
		 * visual debug logging for devices
		 */
		public static function log(msg:String):void
		{
			trace("<Visual Log> " + msg);
			if (false == debug || null == _starling.stage)
			{
				return;
			}

			if (null == debugText)
			{
				debugText = new TextField(width, height, msg, "mini", 8, 0xFFFFFF);
				debugText.vAlign = VAlign.TOP;
				debugText.hAlign = HAlign.LEFT;
				debugText.touchable = false;
				_starling.stage.addChild(debugText);
			} else
			{
				debugText.text += "\n" + msg;
			}

			// re-fit the text
			if (debugText.text.split("\n").length > (height / debugText.fontSize - 1))
			{
				debugText.text = debugText.text.slice(debugText.text.search("\n") + 1);
			}
		}

		/**
		 * gets the current fScene
		 */
		public static function get scene():fScene
		{
			for (var i:int = 0; i < _starling.stage.numChildren; i++)
			{
				var ch:DisplayObject = _starling.stage.getChildAt(i);
				if (ch is fScene)
				{
					return ch as fScene;
				}
			}
			return null;
		}

		/**
		 * changes the scene and kills the previous
		 */
		public static function set scene(rhs:fScene):void
		{
			for (var i:int = 0; i < _starling.stage.numChildren; i++)
			{
				var ch:DisplayObject = _starling.stage.getChildAt(i);
				if (ch is fScene)
				{
					(ch as fScene).destroy();
					_starling.stage.removeChildAt(i, true);
					_starling.stage.addChildAt(rhs, i);
					return;
				}
			}
		}

		public static function get mouseX():Number
		{
			return _starling.nativeStage.mouseX;
		}

		public static function get mouseY():Number
		{
			return _starling.nativeStage.mouseY;
		}

		public static function get width():int
		{
			return _starling.stage.stageWidth;
		}

		public static function get height():int
		{
			return _starling.stage.stageHeight;
		}

		/** is the app screen height >= 720px */
		static public function get isHighDefinition():Boolean
		{
			return _isHighDefinition;
		}

		/** is the app running on a mobile device */
		static public function get isRunningOnDevice():Boolean
		{
			return _isRunningOnDevice;
		}
		
		static public function get isHardware():Boolean 
		{
			return _isHardware;
		}
	}
}
