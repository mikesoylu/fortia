package com.mikesoylu.fortia 
{
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * Game entity like <code>fSprite</code> but can't have children
	 */
	public class fImage extends Image implements fIBasic
	{
		public var halfWidth:Number = NaN;
		public var halfHeight:Number = NaN;
		
		public function fImage(texture:Texture, x:Number = 0, y:Number = 0, setPivotToCenter:Boolean = true)
		{
			super(texture);
			
			this.x = x;
			this.y = y;
			
			// all fortia objects are not touchable by default
			touchable = false;
			
			if (true == setPivotToCenter)
			{
				halfWidth = pivotX = width * 0.5;
				halfHeight = pivotY = height * 0.5;
			}
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