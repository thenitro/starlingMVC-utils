package mvcutils.views {
    import starling.display.DisplayObject;
    import starling.display.Sprite;

    public class IndexedViewManager {
        private var _parent:Sprite;

        private var _indexes:Vector.<IndexedVO>;

        public function IndexedViewManager(pParent:Sprite) {
            _parent  = pParent;
            _indexes = new <IndexedVO>[];
        }

        public function addView(pView:DisplayObject, pIndex:int = -1):DisplayObject {
            if (_parent.contains(pView)) {
                return pView;
            }

            if (pIndex == -1) {
                pIndex = _parent.numChildren;
            }

            _indexes.push(new IndexedVO(pView, pIndex));
            _parent.addChild(pView);

            updateChild();

            return pView;
        }

        public function removeView(pView:DisplayObject, pDispose:Boolean = false):void {
            if (!_parent.contains(pView)) {
                return;
            }

            _parent.removeChild(pView, pDispose);
            _indexes = _indexes.filter(function(pItem:IndexedVO, pIndex:int, pVector:Vector.<IndexedVO>):Boolean {
                if (pItem.view == pView) {
                    return false;
                }

                return true;
            });

            updateChild();
        }

        public function contains(pView:DisplayObject):Boolean {
            return _parent.contains(pView);
        }

        [Inline]
        private function updateChild():void {
            _indexes = _indexes.sort(function(pA:IndexedVO, pB:IndexedVO):Number {
                return pA.viewIndex > pB.viewIndex ? 1 : -1;
            });

            for (var i:int = 0; i < _indexes.length; i++) {
                _parent.setChildIndex(_indexes[i].view, i);
            }
        }
    }
}
