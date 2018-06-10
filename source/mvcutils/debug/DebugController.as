package mvcutils.debug {
    import flash.desktop.Clipboard;
    import flash.desktop.ClipboardFormats;
    import flash.display.BitmapData;

    import mvcutils.scaling.Scaling;

    import starling.core.Starling;
    import starling.display.Stage;
    import starling.events.EventDispatcher;
import starling.utils.Align;

    public class DebugController {
        [Dispatcher]
        public var dispatcher:EventDispatcher;

        [Inject]
        public var scaling:Scaling;

        [Inject(source="DebugSettings")]
        public var settings:IDebugSettings;

        public function DebugController() {
        }

        [PostConstruct]
        public function postConstruct():void {
            var starling:Starling = Starling.current;

            starling.showStats = true;
            starling.showStatsAt(
                    settings.alignHorizontal, settings.alignVertical,
                    settings.scale * scaling.textureScale);

            starling.enableErrorChecking = true;
        }

        public function contextLost():void {
            Starling.context.dispose();
        }

        public function screenshot():void {
            dispatcher.dispatchEventWith(DebugEvent.TOGGLE);

            Starling.current.showStats = false;

            var stage:Stage    = Starling.current.stage;
            var bmp:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight, false, 0x000000);

            stage.drawToBitmapData(bmp);

            Clipboard.generalClipboard.setData(ClipboardFormats.BITMAP_FORMAT, bmp);

            Starling.current.showStats = true;

            dispatcher.dispatchEventWith(DebugEvent.TOGGLE);
        }
    }
}
