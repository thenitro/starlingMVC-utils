package com.thenitro.mvcutils.statemachine {
	import com.creativebottle.starlingmvc.views.ViewManager;

	import flash.utils.Dictionary;

	import starling.events.Event;
	import starling.events.EventDispatcher;

	public class StateMachine extends EventDispatcher {
		[Inject]
		public var viewManager:ViewManager;
		
		private var _states:Dictionary;
		
		private var _currState:State;
		private var _prevState:State;
		
		private var _args:Array;
		private var _prevArgs:Array;
		
		public function StateMachine() {
			_states = new Dictionary();
			
			super();
		};
		
		public function get prevState():State {
			return _prevState;
		};
		
		public function get prevArgs():Array {
			return _prevArgs;
		};
		
		public function get currentState():State {
			return _currState;
		};
		
		public function getStateByID(pStateID:String):State {
			return _states[pStateID] as State;
		};
		
		public function startState(pStateID:String, pArgs:Array = null):void {
            if (_currState && _currState.id == pStateID) {
                return;
            }

			forceStopState();

			var state:State = getStateByID(pStateID);
			
			if (!state) {
				trace(this + ".startState(pStateID) ERROR there is no state", pStateID);
				return;
			}
			
			dispatchEventWith(StateEvent.STARTED, false, _prevState);
			
			_args = pArgs;
			
			_currState = state;
			_currState.addEventListener(StateEvent.POST_CONSTRUCT,
										postConstructEventHandler);

			viewManager.addView(_currState);

            dispatchEventWith(StateEvent.STOPPED, false, _currState);
		};
		
		public function stopCurrentState():void {
			forceStopState();
			
			_prevState = null;
			_prevArgs  = null;
		};

		protected function addState(pState:State):void {
			_states[pState.id] = pState;
		};
		
		private function forceStopState():void {
			if (_currState) {
				_prevState = _currState;
				_prevState.stop();
				
				_prevArgs = _args;

				viewManager.removeView(_prevState);
			}
			
			_currState = null;
			_args      = null;
		};
		
		private function postConstructEventHandler(pEvent:Event):void {
			_currState.removeEventListener(StateEvent.POST_CONSTRUCT,
										   postConstructEventHandler);
			
			_currState.start(_args);
		};
	};
}