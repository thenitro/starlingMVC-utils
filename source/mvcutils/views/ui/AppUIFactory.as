package mvcutils.views.ui {
    import com.thenitro.santaiscomming.enum.TextureEnum;
    import com.thenitro.santaiscomming.managers.FontManager;
    import com.thenitro.santaiscomming.managers.LocalizationManager;
    import mvcutils.views.ui.TButton;
    import com.thenitro.santaiscomming.managers.TextureManager;

    import feathers.controls.Label;
    import feathers.text.BitmapFontTextFormat;

    import mvcutils.scaling.Scaling;

    import starling.textures.Texture;

    public class AppUIFactory {
        [Inject]
        public var scaling:Scaling;

        [Inject]
        public var fonts:FontManager;

        [Inject]
        public var localization:LocalizationManager;

        [Inject]
        public var textures:TextureManager;

        public function AppUIFactory() {
        }

        [PostConstruct]
        public function postConstruct():void {
        }

        [Inline]
        public function createLabel(pTextID:String, pX:int, pY:int, pFontSize:uint, pFontColor:uint):Label {
            var result:Label = new Label();
                result.textRendererProperties.textFormat =
                        new BitmapFontTextFormat(fonts.fontName,
                                scaling.getScaledByY(pFontSize),
                                pFontColor);
                result.text = localization.getField(pTextID) || pTextID;
                result.validate();

                result.x = pX;
                result.y = pY;

            return result;
        }

        [Inline]
        public function createButton(pTextID:String, pTextureID:String = TextureEnum.BUTTON_TEXTURE):TButton {
            return new TButton(pTextID, pTextureID);
        }
    }
}
