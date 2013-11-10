package com.mikesoylu.fortia {
	/**
	 * ...
	 * @author bms
	 */
	public class fLocalize {
		
		public static var language:String = "default";
		private static var _dictionaries:Object = null;
		
		public function fLocalize() {
		}
		
		public static function addDictionary(dict:Object, lang:String = "default"):void {
			dictionaries[lang] = dict;
		}
		
		public static function get(key:String):String {
			var value:String = dictionaries[language][key];
			if (value == null) {
				throw new fError("Localization not found " + key);
				return key;
			}
			return value;
		}
		
		public static function get dictionaries():Object {
			if (_dictionaries == null) {
				_dictionaries = new Object()
			}
			return _dictionaries;
		}
	}
}