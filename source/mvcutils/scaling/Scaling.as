package mvcutils.scaling {
    import nmath.NMath;

    import starling.display.Sprite;

    import starling.display.Stage;

    public class Scaling {
        private var _stage:Stage;
        private var _root:Sprite;

        private var _originWidth:Number;
        private var _originHeight:Number;

        private var _textureScale:Number;

        public function Scaling(pStage:Stage, pRoot:Sprite,
                                pOriginWidth:Number, pOriginHeight:Number) {
            _root  = pRoot;
            _stage = pStage;

            _originWidth  = pOriginWidth;
            _originHeight = pOriginHeight;

            var scaleX:Number = pStage.stageWidth  / pOriginWidth;
            var scaleY:Number = pStage.stageHeight / pOriginHeight;

            _textureScale = Math.min(scaleX, scaleY);
        }

        public function get root():Sprite {
            return _root;
        }

        public function get stage():Stage {
            return _stage;
        }

        public function get originWidth():Number {
            return _originWidth;
        }

        public function get originHeight():Number {
            return _originHeight;
        }

        public function get textureScale():Number {
            return _textureScale;
        }

        [Inline]
        public function getScaledByX(pValue:Number):int {
            return int(NMath.map(pValue, 0, _originWidth, 0, _stage.stageWidth));
        }

        [Inline]
        public function getScaledByY(pValue:Number):int {
            return int(NMath.map(pValue, 0, _originHeight, 0, _stage.stageHeight));
        }
    }
}
