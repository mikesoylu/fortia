package com.mikesoylu.fortia
{
	import com.mikesoylu.fortia.fGame;
	import flash.net.SharedObject;

	/**
	 * This is used to save local game data to disc, i.e savegames, settings..
	 */
	public class fSaveManager 
	{
		private static const DEFAULT_ID:String = "fortiaApp";
		
		public static var appID:String = DEFAULT_ID;
		
		private static var _sharedObject:SharedObject = null;
		
		public static function get sharedObject():SharedObject 
		{
			if (null == _sharedObject)
			{
				if (DEFAULT_ID == appID)
				{
					fGame.log("<SaveManager> Warning: using default appID");
				}
				_sharedObject = SharedObject.getLocal(appID);
			}
			return _sharedObject;
		}
		
		public static function getData(field:String):Object
		{
			return sharedObject.data[field];
		}
		
		public static function clear():void
		{
			sharedObject.clear();
		}
		
		public static function setData(field:String, value:Object):void
		{
			sharedObject.data[field] = value;
			sharedObject.flush()
		}
	}
}