package com.mikesoylu.fortia 
{
	import flash.geom.Rectangle;
	import starling.display.Sprite;
	
	/**
	 * Basic sprite with update and destroy functions, should be used for sprites with children
	 * WARNING: Doesn't manage children. See <code>fLayer</code>
	 */
	public class fSprite extends Sprite implements fIBasic
	{
		public var halfWidth:Number = NaN;
		public var halfHeight:Number = NaN;
		
		public function fSprite()
		{
			super();
			// all fortia objects are not touchable by default
			touchable = false;
		}
		
		public function update(dt:Number):void
		{
			
		}
		
		public function destroy():void
		{
			
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
		
		/**
		 * This is faster then get bounds() and depends on halfWidth and halfHeight
		 * WARNING: it assumes the pivot is the center of the object
		 */
		public function get rect():Rectangle 
		{
			if (isNaN(halfHeight) || isNaN(halfWidth))
			{
				throw new fError("halfHeight or halfWidth is not set");
			}
			return new Rectangle(x - halfWidth, y - halfHeight, halfWidth << 1, halfHeight << 1);
		}
	}
}