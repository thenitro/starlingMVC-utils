package mvcutils.fonts {
    import com.emibap.textureAtlas.DynamicAtlas;

    import flash.text.Font;

    import mvcutils.scaling.Scaling;

    public class DynamicFontManager {
        [Inject]
        public var scaling:Scaling;

        public function DynamicFontManager() {
        }

        public function addFont(pFontClass:Class, pMaxFontSize:int):void {
            var chars2Add:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".toUpperCase();
                chars2Add += chars2Add.toLowerCase() + ",.-_!?1234567890: ";

            var chars2Add2:String = 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ'.toUpperCase();
                chars2Add2 += chars2Add2.toLowerCase();

            var chars2Add3:String = 'абвгґдеєжзиіїйклмнопрстуфхцчшщьюя'.toUpperCase();
                chars2Add3 += chars2Add3.toLowerCase();

            chars2Add += chars2Add2;
            chars2Add += chars2Add3;

            var font:Font = new pFontClass();

            DynamicAtlas.bitmapFontFromString(chars2Add, font.fontName,
                                              pMaxFontSize * scaling.textureScale,
                                              false, false, -2);
        }
    }
}
