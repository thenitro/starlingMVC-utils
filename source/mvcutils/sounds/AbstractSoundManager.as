package mvcutils.sounds {
    import flash.events.Event;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundTransform;
    import flash.utils.Dictionary;

    public class AbstractSoundManager {
        private var _sounds:Dictionary;

        private var _ambientID:String;
        private var _ambientVolume:Number;

        private var _ambientChannel:SoundChannel;

        public function AbstractSoundManager() {
            _sounds = new Dictionary();
        }

        public function playAmbientSound(pSoundID:String, pVolume:Number):void {
            if (_ambientID == pSoundID) {
                return;
            }

            stopAmbient();

            _ambientID = pSoundID;
            _ambientVolume = pVolume;

            var sound:Sound = getSound(pSoundID);

            var channel:SoundChannel = sound.play();
                channel.soundTransform = new SoundTransform(pVolume);
                channel.addEventListener(
                        Event.SOUND_COMPLETE,
                        ambientCompleteEventHandler);

            _ambientChannel = channel;
        }

        public function playSound(pSoundID:String, pVolume:Number):void {
            var sound:Sound = getSound(pSoundID);
                sound.play(0, 0, new SoundTransform(pVolume));
        }

        public function stopAmbient():void {
            if (!_ambientChannel) {
                return;
            }

            _ambientChannel.stop();
            _ambientChannel.removeEventListener(
                    Event.SOUND_COMPLETE,
                    ambientCompleteEventHandler);
            _ambientChannel = null;

            _ambientID = null;
            _ambientVolume = 0.0;
        }

        [Inline]
        protected function addSound(pSoundID:String, pClass:Class):void {
            _sounds[pSoundID] = pClass;
        }

        [Inline]
        private function getSound(pSoundID:String):Sound {
            var newSoundClass:Class = _sounds[pSoundID] as Class;

            return new newSoundClass() as Sound;
        }

        private function ambientCompleteEventHandler(pEvent:Event):void {
            var id:String = _ambientID;
            var volume:Number = _ambientVolume;

            stopAmbient();
            playAmbientSound(id, volume);
        }
    }
}