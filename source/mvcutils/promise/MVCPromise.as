package mvcutils.promise {
    import com.creativebottle.starlingmvc.events.EventMap;

    import starling.events.Event;

    import starling.events.EventDispatcher;

    public class MVCPromise {
        private var _dispatcher:EventDispatcher;

        private var _map:EventMap;
        private var _promisers:int;
        private var _onComplete:String;

        public function MVCPromise(pDispatcher:EventDispatcher,
                                   pPromisers:Vector.<IPromiser>,
                                   pOnComplete:String) {

            _map = new EventMap();
            _promisers = 0;

            _dispatcher = pDispatcher;
            _onComplete = pOnComplete;

            for each (var promiser:IPromiser in pPromisers) {
                if (promiser.inited) {
                    continue;
                }

                _map.addMap(_dispatcher, promiser.initEvent, onInitEvent);

                _promisers++;
            }

            if (_promisers == 0) {
                complete();
            }
        }

        [Inline]
        private function complete():void {
            _dispatcher.dispatchEventWith(_onComplete);
            _dispatcher = null;

            _map.removeAllMappedEvents();
            _map = null;

            _onComplete = null;
        }

        private function onInitEvent(pEvent:Event):void {
            var promiser:IPromiser = pEvent.data as IPromiser;

            _map.removeMap(_dispatcher, promiser.initEvent, onInitEvent);
            _promisers--;

            if (_promisers <= 0) {
                complete();
            }
        }
    }
}
