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
		public function fLayer()
		{
			super();
			
			// all fortia objects are not touchable by default
			touchable = false;
		}
		
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
		
		/** returns the scale if scaleX == scaleY */
		public function get scale():Number
		{
			return scaleX == scaleY ? scaleX : 0;
		}
		
		public function set scale(rhs:Number):void
		{
			scaleX = rhs;
			scaleY = rhs;
		}
		
		/** this guy doesn't have a rect */
		public final function get rect():Rectangle 
		{
			throw new fError("fLayer doesn't have a rect");
			
			return null;
		}
	}
}