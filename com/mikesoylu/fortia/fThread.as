package com.mikesoylu.fortia 
{
	/**
	 * @author bms
	 */
	public class fThread
	{
		public var onComplete:Function;
		public var runnable:fIRunnable;
		public var callCount:int;
		
		public function fThread(runnable:fIRunnable, initParams:Object = null, callCount:int = 1, onComplete:Function = null)
		{
			this.onComplete = onComplete;
			this.callCount = callCount;
			this.runnable = runnable;
			
			if (null != runnable)
			{
				runnable.init(initParams);
			}
		}
		
		public function update():void
		{
			if (null != runnable)
			{
				for (var i:int = 0; i < callCount; i++)
				{
					runnable.process();
					if (runnable.complete && null != onComplete)
					{
						onComplete();
						runnable = null;
						break;
					}
				}
			}
		}
		
		public function get complete():Boolean
		{
			if (null != runnable)
			{
				return false;
			}
			// if null either never processed or is complete
			return true;
		}
	}
}