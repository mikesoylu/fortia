package com.mikesoylu.fortia 
{
	import flash.geom.Rectangle;
	public interface fIBasic 
	{
		function update(dt:Number):void;
		function destroy():void;
		
		/** this is used for general overlapping queries */
		function get rect():Rectangle;
	}
}