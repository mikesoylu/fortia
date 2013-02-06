package com.mikesoylu.fortia 
{
	import flash.utils.Dictionary;
	
	public class fStateMachine 
	{
		private var states:Dictionary;
		private var parent:Object;
		private var _state:fIFSMState = null;
		
		public function fStateMachine(parent:Object)
		{
			this.parent = parent;
			states = new Dictionary();
		}
		
		/** adds and init's a new state with a name and returns the name of added state */
		public function addState(name:String, newState:fIFSMState):String
		{
			if (name in states)
			{
				throw new fError("FSM already has a state named \"" + name + "\"");
			} else
			{
				states[name] = newState;
				newState.init(parent, this);
			}
			
			return name;
		}
		
		/** returns the current state */
		public function get state():fIFSMState
		{
			return _state;
		}
		
		/** sets the current state by name */
		public function set state(name:String):void
		{
			_state = states[name];
		}
		
		public function update(dt:Number):void
		{
			if (null != _state)
			{
				_state.update(dt);
			}
		}
	}
}