package mvcutils.optimization {
    public class FrameRateEvent {
        public static const CHAGE:String = 'FRE_Change';

        private var _fps:int;

        public function FrameRateEvent(pFPS:int) {
            _fps = pFPS;
        }

        public function get fps():int {
            return _fps;
        }
    }
}
