package mvcutils.storage {
	import flash.events.NetStatusEvent;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;

	public final class LocalStorage {
		private var _storage:SharedObject;
		private var _inited:Boolean;
		
		public function LocalStorage() {
		};
		
		public function get inited():Boolean {
			return _inited;
		};
		
		public function init(pAppID:String):void {
			_storage = SharedObject.getLocal(pAppID);
			_inited  = true;
		};
		
		public function load(pID:String, pDefaultValue:Object = null):* {
			if (!_inited) {
				return null;
			}

            var result:* = _storage.data[pID];
            if (result == undefined) {
                return pDefaultValue;
            }
			
			return result;
		};
	
		public function save(pID:String, pData:Object):void {
			if (!_inited) {
				return;
			}
			
			_storage.data[pID] = pData;
			
			var flushStatus:String;
			
			try {
				flushStatus = _storage.flush(10000);
			} catch (error:Error) {
				switch(flushStatus) {
					case SharedObjectFlushStatus.PENDING: {
						_storage.addEventListener(NetStatusEvent.NET_STATUS,
												  storageNetStatusEventHandler);
						break;
					}
						
					case SharedObjectFlushStatus.FLUSHED: {
						break;
					}
						
					default: {
						break;
					}
				}
			}
		};

        public function clear():void {
            _storage.clear();
        }
		
		private function storageNetStatusEventHandler(pEvent:NetStatusEvent):void {
			switch(pEvent.info.code) {
				case 'SharedObject.Flush.Success': {
					break;
				}
					
				case 'SharedObject.Flush.Failed': {
					trace('LocalStorage.storageNetStatusEventHandler: FAIL!');
					break;
				}
					
				default: {
					break;
				}
			}
			
			_storage.removeEventListener(NetStatusEvent.NET_STATUS,
				storageNetStatusEventHandler);
		};
	};
}