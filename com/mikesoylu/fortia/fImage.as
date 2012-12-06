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
		
		public function fImage(texture:Texture)
		{
			super(texture);
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