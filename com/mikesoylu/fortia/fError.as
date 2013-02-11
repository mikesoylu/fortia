package com.mikesoylu.fortia 
{
	/**
	 * An error
	 */
	public class fError extends Error 
	{
		
		public function fError(string:String) 
		{
			message = "Fortia Error: " + string;
		}
	}
}