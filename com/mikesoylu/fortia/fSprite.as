package com.mikesoylu.fortia 
{
	import flash.geom.Rectangle;
	import starling.display.Sprite;
	
	/**
	 * basic sprite with update and destroy functions
	 * should be used for sprites with children
	 * NOTE: Doesn't manage children. See fLayer.
	 */
	public class fSprite extends Sprite implements fIBasic
	{
		public var halfWidth:Number = NaN;
		public var halfHeight:Number = NaN;
		
		public function update(dt:Number):void
		{
			
		}
		
		public function destroy():void
		{
			
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