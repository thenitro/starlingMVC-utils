package mvcutils.scaling {
    import nmath.NMath;

    import starling.display.Sprite;

    import starling.display.Stage;

    public class Scaling {
        private var _stage:Stage;
        private var _root:Sprite;

        private var _originWidth:Number;
        private var _originHeight:Number;

        public function Scaling(pStage:Stage, pRoot:Sprite,
                                pOriginWidth:Number, pOriginHeight:Number) {
            _root  = pRoot;
            _stage = pStage;

            _originWidth  = pOriginWidth;
            _originHeight = pOriginHeight;
        }

        public function get root():Sprite {
            return _root;
        }

        [Inline]
        public function getScaledByX(pValue:Number):Number {
            return NMath.map(pValue, 0, _originWidth, 0, _stage.stageWidth);
        }

        [Inline]
        public function getScaledByY(pValue:Number):Number {
            return NMath.map(pValue, 0, _originHeight, 0, _stage.stageHeight);
        }
    }
}
