package com.mikesoylu.fortia 
{
	public class fObjectPool 
	{
		public var objects:Vector.<fIPoolable> = new Vector.<fIPoolable>();
		
		/** adds a new object to pool */
		public function addObject(obj:fIPoolable):fIPoolable
		{
			objects.push(obj);
			
			return obj;
		}
		
		/**
		 * gets an available(isAlive == false) object from pool and revives it
		 * @returns null if none available
		 */
		public function getObject():fIPoolable
		{
			var len:int = objects.length;
			for (var i:int = 0; i < len; i++)
			{
				var obj:fIPoolable = objects[i];
				if (obj.isAlive == false)
				{
					obj.revive();
					return obj;
				}
			}
			return null;
		}
	}
}