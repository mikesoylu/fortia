package com.mikesoylu.fortia 
{
	
	public interface fIState 
	{
		/**
		 * Called when this is added to a FSM
		 * @param	parent The parent of the FSM, most likely a fScene instance
		 * @param	parentFSM The fStateMachine that added this state
		 */
		function init(parent:Object, parentFSM:fStateMachine):void;
		
		/** called when the FSM switches to this state */
		function activate():void;
		
		/** called when the FSM switches from this state */
		function deactivate():void;
		
		/** called every frame when this is the active state of the FSM */
		function update(dt:Number):void;
	}
}