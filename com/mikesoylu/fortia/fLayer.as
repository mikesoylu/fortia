package com.mikesoylu.fortia 
{
	import flash.geom.Rectangle;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	/**
	 * basic sprite with update and destroy functions
	 * should be used for sprites with children
	 */
	public class fLayer extends Sprite implements fIBasic
	{
		public var mask:uint = 0x000000;
		
		public function update(dt:Number):void
		{
			for (var i:int = 0; i < numChildren; i++)
			{
				var ch:DisplayObject = getChildAt(i);
				if (ch is fIBasic && ch.visible)
				{
					(ch as fIBasic).update(dt);
				}
			}
		}
		public function destroy():void
		{
			for (var i:int = 0; i < numChildren; i++)
			{
				var ch:DisplayObject = getChildAt(i);
				if (ch is fIBasic)
				{
					(ch as fIBasic).destroy();
				}
			}
		}
		/** this guy doesn't have a rect */
		public final function get rect():Rectangle 
		{
			return null;
		}
	}
}