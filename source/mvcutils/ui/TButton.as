package mvcutils.ui {
    import com.thenitro.santaiscomming.factories.AppUIFactory;

    import feathers.controls.Label;

    import mvcutils.scaling.Scaling;

    import starling.animation.Juggler;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.textures.Texture;
    import starling.utils.Color;

    public class TButton extends Sprite {
        [Juggler]
        public var juggler:Juggler;

        [Inject]
        public var factory:AppUIFactory;

        [Inject]
        public var scaling:Scaling;

        private var _localizationID:String;
        private var _texture:Texture;

        private var _label:Label;

        public function TButton(pLocalizationID:String, pTexture:Texture) {
            _localizationID = pLocalizationID;
            _texture = pTexture;

            super();
        }

        [PostConstruct]
        public function postConstruct():void {
            var image:Image = addChild(new Image(_texture)) as Image;
                image.scaleX = image.scaleY = scaling.textureScale;

            _label = factory.createLabel(_localizationID, 0, 0, 20, Color.RED);

            _label.x = (image.width - _label.width) / 2;
            _label.y = (image.height - _label.height) / 2;

            addChild(_label);

            addEventListener(TouchEvent.TOUCH, onTouch);
        }

        [PreDestroy]
        public function preDestroy():void {
            removeEventListener(TouchEvent.TOUCH, onTouch);
            removeChildren(0, -1, true);

            _label = null;

            _localizationID = null;
            _texture = null;
        }

        private function onTouch(pEvent:TouchEvent):void {
            var touch:Touch = pEvent.getTouch(this);
            if (touch && touch.phase == TouchPhase.ENDED) {
                alpha = 0.7;
                juggler.delayCall(
                        function():void {
                            dispatchEventWith(Event.TRIGGERED);
                            alpha = 1.0;
                        }, 0.2);
            }
        }
    }
}
