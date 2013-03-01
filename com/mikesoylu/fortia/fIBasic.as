package com.mikesoylu.fortia 
{
	import flash.geom.Rectangle;
	
	/**
	 * basic fortia entity
	 */
	public interface fIBasic 
	{
		function update(dt:Number):void;
		function destroy():void;
		function set scale(rhs:Number):void;
		function get scale():Number;
		
		/** used for QuadTree overlapping queries is not affected by scale or rotation */
		function get rect():Rectangle;
	}
}