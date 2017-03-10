package mvcutils.optimization {
    import feathers.utils.math.roundToNearest;

    import flash.desktop.NativeApplication;
    import flash.events.Event;
    import flash.utils.getTimer;

    import starling.core.Starling;
    import starling.events.EnterFrameEvent;
    import starling.events.EventDispatcher;

    public class FrameRateController {
        private static const DEFAULT_FRAMERATE:int = 60;
        private static const ONE_FRAMERATE:int     =  1;

        [Dispatcher]
        public var dispatcher:EventDispatcher;

        private var _starling:Starling;

        private var _prevTime:int;
        private var _total:int;
        private var _frames:int;
        private var _prevAverage:int;

        public function FrameRateController(pStarling:Starling) {
            _starling = pStarling;

            NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, onAppActivate);
            NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, onAppDeactivate);

            _starling.stage.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
        }

        private function onAppActivate(pEvent:Event):void {
            setFrameRate(DEFAULT_FRAMERATE);

            _starling.stage.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
        }

        private function onAppDeactivate(pEvent:Event):void {
            setFrameRate(ONE_FRAMERATE);

            _starling.stage.removeEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
        }

        [Inline]
        private function setFrameRate(pValue:int):void {
            _starling.nativeStage.frameRate = pValue;
        }

        private function onEnterFrame(pEvent:starling.events.Event):void {
            var time:Number = getTimer();
            var timePassed:Number = time - _prevTime;
            var rate:int = 1000 / timePassed;

            _total += rate;
            _frames++;

            var average:int = roundToNearest(_total / _frames, 10);
            if (average != _prevAverage) {
                if (dispatcher) {
                    dispatcher.dispatchEventWith(FrameRateEvent.CHAGE, false, new FrameRateEvent(average));
                }

                _prevAverage = average;
            }

            _prevTime = time;
        }
    }
}
