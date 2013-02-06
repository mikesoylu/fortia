package com.mikesoylu.fortia 
{
	import flash.geom.Point;
	public class fUtil 
	{
		/** clamps value between low and hi */
		public static function clamp(low:*, hi:*, value:*):*
		{
			if (value > hi)
			{
				value = hi;
			} else if (value < low)
			{
				value = low;
			}
			return value;
		}
		
		/** linear interpolation, delta is between 0..1 */
		public static function lerp( delta:Number, from:Number, to:Number):Number
		{
			if ( delta > 1 ) return to;
			if ( delta < 0 ) return from;

			return from + ( to - from ) * delta;
		}
		
		/** returns the sign of a numeric value*/
		public static function sign(value:Number):Number
		{
			if (value == 0.0)
			{
				return 0.0;
			}
			return Math.abs(value)/value;
		}
		
		/** returns true if a is almost equal to b Note:threshold is a positive number */
		public static function isClose(a:*, b:*, threshold:*):Boolean
		{
			return (Math.abs(a - b) < threshold);
		}
		
		/** swaps two objects */
		public static function swap(a:*, b:*):void
		{
			var tmp:* = a;
			a = b;
			b = tmp;
		}
		
		/** returns the closest distance to angle dst */
		public static function toAngle(src:Number, dst:Number):Number
		{
			var va:Point = new Point(Math.cos(src), Math.sin(src));
			var vb:Point = new Point(Math.cos(dst), Math.sin(dst));
			
			var sine:Number = va.x * vb.y - va.y * vb.x; // cross
			var cosine:Number =  va.x * vb.x + va.y * vb.y; // dot
			
			return Math.atan2(sine, cosine);
		}
	}
}