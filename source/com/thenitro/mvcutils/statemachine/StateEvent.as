package com.thenitro.mvcutils.statemachine {
    import starling.events.Event;

    public class StateEvent extends Event {
        public static const STARTED:String = 'state_started_event';
        public static const STOPPED:String = 'state_stopped_event';

        internal static const POST_CONSTRUCT:String = 'post_construct_event';

        public function StateEvent(type:String) {
            super(type);
        }
    }
}
