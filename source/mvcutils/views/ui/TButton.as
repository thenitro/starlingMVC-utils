package mvcutils.views.ui {
    import mvcutils.events.GlobalEvents;

    import mvcutils.localization.Localization;
    import mvcutils.textures.ITextureManager;

    import feathers.controls.Label;

    import mvcutils.scaling.Scaling;

    import starling.animation.Juggler;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.EventDispatcher;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.textures.Texture;
    import starling.utils.Color;

    public class TButton extends Sprite {
        [Juggler]
        public var juggler:Juggler;

        [Dispatcher]
        public var dispatcher:EventDispatcher;

        [Inject]
        public var factory:AppUIFactory;

        [Inject]
        public var scaling:Scaling;

        [Inject(source="LocalizationManager")]
        public var localization:Localization;

        [Inject(source="TextureManager")]
        public var textures:ITextureManager;

        private var _localizationID:String;
        private var _textureId:String;

        private var _image:Image;
        private var _label:Label;

        public function TButton(pLocalizationID:String, pTextureId:String) {
            _localizationID = pLocalizationID;
            _textureId = pTextureId;

            super();
        }

        [PostConstruct]
        public function postConstruct():void {
            var texture:Texture = textures.getTexture(_textureId);
            if (texture) {
                _image = addChild(new Image(texture)) as Image;
                _image.scaleX = _image.scaleY = scaling.textureScale;
            }

            _label = factory.createLabel(_localizationID, 0, 0, 20, Color.RED);
            addChild(_label);

            centerLabel();

            addEventListener(TouchEvent.TOUCH, onTouch);
        }

        public function setText(pText:String):void {
            _label.text = pText;
            _label.validate();

            centerLabel();
        }

        [PreDestroy]
        public function preDestroy():void {
            removeEventListener(TouchEvent.TOUCH, onTouch);
            removeChildren(0, -1, true);

            _label = null;

            _localizationID = null;
            _textureId = null;
        }

        [Inline]
        private function centerLabel():void {
            if (_image) {
                _label.x = (_image.width - _label.width) / 2;
                _label.y = (_image.height - _label.height) / 2;
            }
        }

        private function onTouch(pEvent:TouchEvent):void {
            var touch:Touch = pEvent.getTouch(this);
            if (touch && touch.phase == TouchPhase.ENDED) {
                dispatcher.dispatchEventWith(GlobalEvents.BUTTON_CLICK);
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
