package mvcutils.views.ui {
    import flash.text.TextFormatAlign;

    import mvcutils.fonts.DynamicFontManager;
    import mvcutils.localization.Localization;
    import mvcutils.textures.ITextureManager;
    import feathers.controls.Label;
    import feathers.text.BitmapFontTextFormat;
    import mvcutils.scaling.Scaling;

    public class AppUIFactory {
        [Inject]
        public var scaling:Scaling;

        [Inject(source="FontManager")]
        public var fonts:DynamicFontManager;

        [Inject(source="LocalizationManager")]
        public var localization:Localization;

        [Inject(source="TextureManager")]
        public var textures:ITextureManager;

        public function AppUIFactory() {
        }

        [PostConstruct]
        public function postConstruct():void {
        }

        [Inline]
        public function createLabel(pTextID:String, pX:int, pY:int, pFontSize:uint, pFontColor:uint, align:String = TextFormatAlign.LEFT):Label {
            var result:Label = new Label();
                result.textRendererProperties.textFormat =
                        new BitmapFontTextFormat(fonts.fontName,
                                scaling.getScaledByY(pFontSize),
                                pFontColor, align);
                result.text = localization.getField(pTextID) || pTextID;
                result.validate();

                result.x = pX;
                result.y = pY;

            return result;
        }

        [Inline]
        public function createButton(pTextID:String, pTextureID:String = null):TButton {
            return new TButton(pTextID, pTextureID);
        }
    }
}
