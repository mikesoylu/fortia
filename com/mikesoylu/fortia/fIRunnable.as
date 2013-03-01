package com.mikesoylu.fortia 
{
	
	/**
	 * @author bms
	 */
	public interface fIRunnable 
	{
		/** is called when the thread initializes */
		function init(params:Object):void;
		
		/** is called callCount times on every update */
		function process():void;
		
		/** should return true when the runnable is complete */
		function get complete():Boolean;
	}
	
}