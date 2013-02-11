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
		
		/** used for QuadTree overlapping queries */
		function get rect():Rectangle;
	}
}