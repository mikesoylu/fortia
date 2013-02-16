package com.mikesoylu.fortia 
{
	import flash.utils.Dictionary;
	
	/**
	 * Basic finite state machine for game logic.
	 * States are accessed by their names so you needn't track their references.
	 */
	public class fStateMachine 
	{
		private var states:Dictionary;
		private var parent:Object;
		private var _state:fIState = null;
		
		public function fStateMachine(parent:Object)
		{
			this.parent = parent;
			states = new Dictionary();
		}
		
		/** adds and init's a new state with a name and returns the name of added state */
		public function addState(name:String, newState:fIState):String
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
		
		/** sets and activates the current state by name, also deactivates previous */
		public function set state(name:String):void
		{
			if (name in states)
			{
				if (null != _state)
				{
					_state.deactivate();
				}
				_state = states[name];
				_state.activate();
				
			} else
			{
				throw new fError("FSM has no state named \"" + name + "\"");
			}
		}
		
		/** updates the current state */
		public function update(dt:Number):void
		{
			if (null != _state)
			{
				_state.update(dt);
			}
		}
	}
}