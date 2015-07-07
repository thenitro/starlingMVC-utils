package mvcutils.statemachine {
	import starling.display.Sprite;

	public class State extends Sprite {
		private var _constructed:Boolean;

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
		
		public final function get machine():StateMachine {
			return _machine;
		};

		public final function get constructed():Boolean {
			return _constructed;
		};

		[PostConstruct]
		public final function postConstruct():void {
			if (!_constructed) {
				construct();
			}

			_constructed = true;

			dispatchEventWith(StateEvent.POST_CONSTRUCT);
		};
		
		public function start(pArgs:Array = null):void {
		};
		
		public function stop():void {
		};

		protected function construct():void {

		};
	};
}