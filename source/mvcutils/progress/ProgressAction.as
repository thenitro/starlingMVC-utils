package mvcutils.progress {
    public class ProgressAction {
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

        protected function generateHeader(pResult:Object):Object {
            pResult['header'] = _id;

            return pResult;
        }
    }
}
