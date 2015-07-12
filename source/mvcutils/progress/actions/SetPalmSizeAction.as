package mvcutils.progress.actions {
    import mvcutils.progress.ProgressAction;

    public class SetPalmSizeAction extends ProgressAction {
        public static const ID:String = 'set_palm_size';

        private static const SIZE_ID:String = 'size';

        public var size:uint;

        public function SetPalmSizeAction() {
            super(ID);
        }

        override public function serialize():Object {
            var result:Object  = generateHeader( {} );
                result[SIZE_ID] = size;

            return result;
        }

        override public function deserialize(pObject:Object):void {
            size = pObject[SIZE_ID];
        }
    }
}
