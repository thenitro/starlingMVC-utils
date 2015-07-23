package mvcutils.localization {
    import flash.system.Capabilities;
    import flash.utils.Dictionary;

    import starling.events.EventDispatcher;

    public class Localization extends EventDispatcher {
        public static const CHANGE_LANGUAGE:String = 'change_language_event';

        private var _languages:Dictionary;

        private var _currentLanguageID:String;
        private var _currentLanguage:Language;

        public function Localization() {
            initialize();
        };

        public function get currentLanguageID():String {
            return _currentLanguageID;
        };

        public function parse(pData:Object):void {
            for (var key:String in pData) {
                var item:Object = pData[key];

                for (var languageID:String in item) {
                    addField(languageID, key, item[languageID] as String);
                }
            }

            loadDefaultLanguage();
        };

        public function getField(pFieldID:String):String {
            return _currentLanguage.getField(pFieldID);
        };

        public function setLanguage(pLangID:String):void {
            if (!pLangID || !hasLanguage(pLangID)) {
                return;
            }

            _currentLanguageID = pLangID;
            _currentLanguage = getLanguage(pLangID);

            dispatchEventWith(CHANGE_LANGUAGE);
        };

        private function initialize():void {
            _languages = new Dictionary();
        };

        private function loadDefaultLanguage():void {
            var id:String = Capabilities.language;

            if (hasLanguage(id)) {
                setLanguage(id);
                return;
            }

            CONFIG::MOBILE {
                for each (id in Capabilities.languages) {
                    var modifiedID:String = id.split('-')[0];

                    if (hasLanguage(modifiedID)) {
                        setLanguage(modifiedID);

                        return;
                    }
                }
            }
        };

        private function addField(pLanguageID:String,
                                  pKeyID:String, pField:String):void {
            var language:Language = getLanguage(pLanguageID);
            if (!language) {
                language = addLanguage(new Language(pLanguageID));
            }

            language.addField(pKeyID, pField);
        };

        private function hasLanguage(pID:String):Boolean {
            return Boolean(_languages[pID]);
        };

        private function addLanguage(pLanguage:Language):Language {
            if (hasLanguage(pLanguage.id)) {
                return null;
            }

            _languages[pLanguage.id] = pLanguage;

            return pLanguage;
        };

        private function getLanguage(pID:String):Language {
            return _languages[pID] as Language;
        }
    }
}