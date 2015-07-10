package mvcutils.views {
    import starling.display.DisplayObject;
    import starling.display.Sprite;

    public class IndexedViewManager {
        private var _parent:Sprite;
        private var _indexes:Array;

        public function IndexedViewManager(pParent:Sprite) {
            _parent  = pParent;
            _indexes = [];
        }

        public function addView(pView:DisplayObject, pIndex:int = -1):DisplayObject {
            if (_parent.contains(pView)) {
                return pView;
            }

            if (pIndex == -1) {
                pIndex = _parent.numChildren;
            }

            _indexes[pIndex] = pView;
            _parent.addChild(pView);

            updateChild();

            return pView;
        }

        public function removeView(pView:DisplayObject, pDispose:Boolean = false):void {
            if (!_parent.contains(pView)) {
                return;
            }

            _parent.removeChild(pView, pDispose);
            _indexes.splice(_indexes.indexOf(pView), 1);

            updateChild();
        }

        public function contains(pView:DisplayObject):Boolean {
            return _parent.contains(pView);
        }

        [Inline]
        private function updateChild():void {
            for (var i:int = 0; i < _indexes.length; i++) {
                var child:DisplayObject = _indexes[i] as DisplayObject;
                if (!child) {
                    continue;
                }

                _parent.setChildIndex(child, i);
            }
        }
    }
}
