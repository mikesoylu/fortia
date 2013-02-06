package com.mikesoylu.fortia 
{
	/**
	 * ...
	 * @author bms
	 */
	public class fError extends Error 
	{
		
		public function fError(string:String) 
		{
			message = "Fortia Error: " + string;
		}
	}
}