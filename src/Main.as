package 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import utils.keyhandler;
	import Managers.windowcontroll;
	import Managers.soundmanager;
	
	
	
	
	
	/**
	 * ...
	 * @author l
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private var barray:Array = new Array();
		var ctransform:uint = 0;
		var img:DisplayObject
		var sound:soundmanager = new soundmanager();
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			// entry point
			sound.Toogletheme();

			keyhandler.instance.keytarget = this.stage;
			windowcontroll.windowlayer = this;
			windowcontroll.instance.addbgbmp();
			windowcontroll.instance.showlevelselectwindow();
		}
		
	
		
	
		
	
		
		
	}
	
	
}