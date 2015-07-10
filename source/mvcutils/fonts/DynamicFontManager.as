package mvcutils.fonts {
    import com.emibap.textureAtlas.DynamicAtlas;

    import flash.text.Font;

    import mvcutils.scaling.Scaling;

    public class DynamicFontManager {
        [Inject]
        public var scaling:Scaling;

        public function DynamicFontManager() {
        }

        public function addFont(pFontClass:Class):void {
            var chars2Add:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                chars2Add += chars2Add.toLowerCase() + ",.-_!?1234567890: ";

            var chars2Add2:String = 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ';
                chars2Add2 += chars2Add2.toLowerCase();

            chars2Add += chars2Add2;

            var font:Font = new pFontClass();

            DynamicAtlas.bitmapFontFromString(chars2Add, font.fontName,
                                              70 * scaling.textureScale,
                                              false, false, -2);
        }
    }
}
