package com.thenitro.mvcutils.statemachine {
	import starling.display.Sprite;

	public class State extends Sprite {
		private var _machine:StateMachine;
		private var _id:String;
		
		public function State(pMachine:StateMachine, pID:String) {
			_machine = pMachine;
			_id      = pID;
			
			super();
		};
		
		public final function get id():String {
			return _id;
		};
		
		public function get machine():StateMachine {
			return _machine;
		};

		[PostConstruct]
		public function postConstruct():void {
			dispatchEventWith(StateEvent.POST_CONSTRUCT);
		};
		
		public function start(pArgs:Array = null):void {
		};
		
		public function stop():void {
		};
	};
}