package com.mikesoylu.fortia 
{
	import adobe.utils.CustomActions;
	import starling.utils.AssetManager;
	
	/**
	 * for static access of starling's AssetManager
	 */
	public class fAssetManager 
	{
		private static var _instance:AssetManager = null;
		
		/** the starling AssetManager instance */
		static public function get instance():AssetManager 
		{
			if (null == _instance)
			{
				_instance = new AssetManager();
			}
			return _instance;
		}
	}
}