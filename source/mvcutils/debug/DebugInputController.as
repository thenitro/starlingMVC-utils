package mvcutils.debug {
    import flash.ui.Keyboard;

    import mvcutils.debug.DebugController;

    import starling.core.Starling;
    import starling.display.Stage;
    import starling.events.KeyboardEvent;

    public class DebugInputController {
        [Inject]
        public var debug:DebugController;

        public function DebugInputController() {
        }

        [PostConstruct]
        public function postConstruct():void {
            var stage:Stage = Starling.current.stage;

            stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        }

        private function onKeyDown(pEvent:KeyboardEvent):void {
            if (pEvent.keyCode == Keyboard.S) {
                debug.screenshot();
            }

            if (pEvent.keyCode == Keyboard.C) {
                debug.contextLost();
            }
        }
    }
}
