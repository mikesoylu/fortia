package com.mikesoylu.fortia 
{
	
	public interface fIState 
	{
		function init(parent:Object, parentFSM:fStateMachine):void;
		function update(dt:Number):void;
	}
}