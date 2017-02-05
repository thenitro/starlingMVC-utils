package mvcutils.promise {
    import mvcutils.errors.MustBeOverridenError;

    import starling.events.EventDispatcher;

    public class AbstractPromiser implements IPromiser {
        [Dispatcher]
        public var dispatcher:EventDispatcher;

        private var _inited:Boolean;

        public function AbstractPromiser() {
        }

        public final function get inited():Boolean {
            return _inited;
        }

        public function get initEvent():String {
            throw new MustBeOverridenError();
        };

        protected final function completeInit():void {
            _inited = true;
            dispatcher.dispatchEventWith(initEvent, false, this);
        }
    }
}
