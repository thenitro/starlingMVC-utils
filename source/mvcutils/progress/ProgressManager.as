package mvcutils.progress {
    import mvcutils.storage.LocalStorage;

    public class ProgressManager {
        public static const ACTIONS_ID:String = 'actions';

        [Inject]
        public var storage:LocalStorage;

        public var progressActions:Object;

        private var _actions:Array;

        public function ProgressManager() {

        }

        [PostConstruct]
        public function postConstruct():void {
            loadActions();
        }

        public function get actions():Array {
            return _actions;
        }

        public function saveAction(pAction:ProgressAction):void {
            var actions:Array = storage.load(ACTIONS_ID, []);
                actions.push(pAction.serialize());

            storage.save(ACTIONS_ID, actions);
        }

        public function loadActions():void {
            _actions = [];

            var savedActions:Array = storage.load(ACTIONS_ID, []);
            for each (var abstractAction:Object in savedActions) {
                _actions.push(deserialize(abstractAction));
            }
        }

        [Inline]
        private function deserialize(pAbstractAction:Object):ProgressAction {
            var NewClass:Class = progressActions[pAbstractAction.header] as Class;
            if (!NewClass) {
                throw ReferenceError('Unknown action with header ' + pAbstractAction.header);
                return null;
            }

            var result:ProgressAction = new NewClass();
                result.deserialize(pAbstractAction);

            return result;
        }
    }
}
