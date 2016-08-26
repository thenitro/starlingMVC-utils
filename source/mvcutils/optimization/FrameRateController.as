package mvcutils.optimization {
    import flash.desktop.NativeApplication;
    import flash.display.Stage;
    import flash.events.Event;

    public class FrameRateController {
        private static const DEFAULT_FRAMERATE:int = 60;
        private static const ONE_FRAMERATE:int     =  1;

        private var _stage:Stage;

        public function FrameRateController(pStage:Stage) {
            _stage = pStage;

            NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, onAppActivate);
            NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, onAppDeactivate);
        }

        private function onAppActivate(pEvent:Event):void {
            setFrameRate(DEFAULT_FRAMERATE);
        }

        private function onAppDeactivate(pEvent:Event):void {
            setFrameRate(ONE_FRAMERATE);
        }

        [Inline]
        private function setFrameRate(pValue:int):void {
            _stage.frameRate = pValue;
        }
    }
}
