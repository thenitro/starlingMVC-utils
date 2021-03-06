package mvcutils.statemachine {
	import flash.utils.Dictionary;

	import mvcutils.views.IndexedViewManager;

	import starling.events.Event;
	import starling.events.EventDispatcher;

	public class StateMachine extends EventDispatcher {
		[Inject]
		public var viewManager:IndexedViewManager;
		
		private var _states:Dictionary;
		
		private var _currState:State;
		private var _prevState:State;
		
		private var _args:Array;
		private var _prevArgs:Array;

		private var _viewIndex:int;
		
		public function StateMachine(pViewIndex:int = -1) {
			_viewIndex = pViewIndex;
			_states    = new Dictionary();

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
			
			_args = pArgs;
			
			_currState = state;
			_currState.addEventListener(StateEvent.POST_CONSTRUCT,
										postConstructEventHandler);

			viewManager.addView(_currState, _viewIndex);

			dispatchEventWith(StateEvent.STARTED, false, _currState);
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

			dispatchEventWith(StateEvent.STOPPED, false, _prevState);
		};
		
		private function postConstructEventHandler(pEvent:Event):void {
			_currState.removeEventListener(StateEvent.POST_CONSTRUCT,
										   postConstructEventHandler);
			
			_currState.start(_args);
		};
	};
}