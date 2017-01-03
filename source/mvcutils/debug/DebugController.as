package mvcutils.debug {
    import flash.desktop.Clipboard;
    import flash.desktop.ClipboardFormats;
    import flash.display.BitmapData;

    import starling.core.Starling;
    import starling.display.Stage;
    import starling.events.EventDispatcher;

    public class DebugController {
        [Dispatcher]
        public var dispatcher:EventDispatcher;

        public function DebugController() {
        }

        public function contextLost():void {
            Starling.context.dispose();
        }

        public function screenshot():void {
            dispatcher.dispatchEventWith(DebugEvent.TOGGLE);

            Starling.current.showStats = false;

            var stage:Stage    = Starling.current.stage;
            var bmp:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight, false, 0x000000);

            stage.drawToBitmapData(bmp, false);

            Clipboard.generalClipboard.setData(ClipboardFormats.BITMAP_FORMAT, bmp);

            Starling.current.showStats = true;

            dispatcher.dispatchEventWith(DebugEvent.TOGGLE);
        }
    }
}
