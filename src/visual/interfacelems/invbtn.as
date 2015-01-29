package visual.interfacelems  
{
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.text.TextField;
	import visual.imgcls;
	import utils.textproc;
	/**
	 * ...
	 * @author l
	 */
	public class invbtn extends Sprite
	{
		
		
		public function invbtn(aCallback:Function,aLevel:uint) 
		{
			_level = aLevel;
			cback = aCallback;
			mo = imgcls.getbtnframe(100, 100);
			norm = imgcls.getbtnframe(100, 100, true);
			addChild(mo);
			addChild(norm);
			var lvltxt:TextField = new TextField();
			lvltxt.text = aLevel.toString();
			textproc.proccesstfield(lvltxt, 58);
			lvltxt.x = 33;
			lvltxt.y = 20;
			addChild(lvltxt);
			
			addEventListener(MouseEvent.ROLL_OVER, mof , false, 0, true);
			addEventListener(MouseEvent.ROLL_OUT,mout ,false,0,true);
			addEventListener(MouseEvent.CLICK, onClick, false, 0, true);

		}
		
		private var norm:Shape;
		private var mo:Shape
		private var _level:uint = 0;
		private var cback:Function;
		public function get level():uint
		{
			return _level;
		}
		
		
		private function mof(e:Event):void
		{
			norm.visible = false;
			
		}
		
		private function mout(e:Event):void
		{
			norm.visible = true;
		}
		
		private function onClick(e:Event):void
		{
			if (cback != null)
			{
				cback(level);
			}
			
		}
		
	}

}