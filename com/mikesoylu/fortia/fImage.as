package com.mikesoylu.fortia 
{
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * like fSprite but can't have children
	 */
	public class fImage extends Image implements fIBasic
	{
		public var halfWidth:Number;
		public var halfHeight:Number;
		
		public function fImage(texture:Texture, x:Number = 0, y:Number = 0, setPivotToCenter:Boolean = false)
		{
			super(texture);
			this.x = x;
			this.y = y;
			
			if (true == setPivotToCenter)
			{
				pivotX = width * 0.5;
				pivotY = height * 0.5;
			}
		}
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
			return new Rectangle(x - halfWidth, y - halfHeight, halfWidth << 1, halfHeight << 1);
		}
	}
}