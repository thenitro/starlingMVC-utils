package mvcutils.views {
    import starling.display.DisplayObject;

    internal class IndexedVO {
        private var _view:DisplayObject;
        private var _viewIndex:int;

        public function IndexedVO(pView:DisplayObject, pIndex:int) {
            _view = pView;
            _viewIndex = pIndex;
        }

        public function get view():DisplayObject {
            return _view;
        }

        public function get viewIndex():int {
            return _viewIndex;
        }

        public function toString():String {
            return '[ IndexedVO view=' + _view + ', viewIndex=' + _viewIndex + ']';
        }
    }
}
