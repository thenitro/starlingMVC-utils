package mvcutils.progress {
    public class ProgressAction {
        public static const HEADER_FIELD:String = 'header';

        private var _id:String;

        public function ProgressAction(pID:String) {
            _id = pID;
        }

        public function serialize():Object {
            throw new ReferenceError('Must be overriden! In ' + this);
            return generateHeader( {} );
        }

        public function deserialize(pObject:Object):void {
            throw new ReferenceError('Must be overriden! In ' + this);
        }

        protected final function generateHeader(pResult:Object):Object {
            pResult[HEADER_FIELD] = _id;

            return pResult;
        }
    }
}
