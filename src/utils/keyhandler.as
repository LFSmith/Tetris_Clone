package utils  
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import utils.keyhandler;
	
	/**
	 * ...
	 * @author l
	 */
	public class keyhandler 
	{
		
		public function keyhandler() 
		{
		
			
		}
		
	
		
		private function keytriigerd():void 
		{
			for each (var kinfo:keyhandlerinfo in callbackarray)
			{
				for each (var pkey:uint in pressedkeys)
				{
					kinfo.Callback(pkey);
				}
			}
		}
		
		private static var _instance:keyhandler ;
		private var _haslistners:Boolean = false;
		public static function get instance():keyhandler
		{
			if (_instance != null)
			{
				return _instance;
			}
			_instance = new keyhandler();
			return _instance;
		}
		

		private var pressedkeys:Array = [];
		private var callbackarray:Array = [];
		private var callbackid:Array
		private var currcharcode:uint = 0;
	
	
		public function addcallback(aCallback:Function,aClass:Class):void
		{
			callbackarray.push(new keyhandlerinfo(aClass,aCallback) );	
		}
		
		public function removeclasscallbacks(aClass:Class)
		{
			for (var c:int = callbackarray.length - 1; c >= 0; c-- )
				{
					if (callbackarray[c].Classref == aClass)
					{
						callbackarray.splice(c, 1);
					}
				}
		}
		
		public function set keytarget(aTarget:Stage):void
		{
			aTarget.addEventListener(KeyboardEvent.KEY_UP, keyuphandler);
			aTarget.addEventListener(KeyboardEvent.KEY_DOWN,keydownhandler);
		}
		
		private function keydownhandler(e:KeyboardEvent):void
		{
			for each (var kinfo:keyhandlerinfo in callbackarray)
			{
			
				kinfo.Callback(e.keyCode);
				
			}
		}
		

		
		private function keyuphandler(e:KeyboardEvent):void
		{
			
		
		
		}
		
		
	}

}