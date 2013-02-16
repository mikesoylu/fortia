package com.mikesoylu.fortia 
{
	
	public interface fIState 
	{
		/** called when this is added to the FSM */
		function init(parent:Object, parentFSM:fStateMachine):void;
		
		/** is called when the FSM switches to this state */
		function activate():void;
		
		/** is called when the FSM switches from this state */
		function deactivate():void;
		
		/** is called every frame when this is the active state of the FSM */
		function update(dt:Number):void;
	}
}