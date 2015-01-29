package visual.interfacelems
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.display.Shape;
	import flash.text.TextFieldAutoSize;
	import flash.events.MouseEvent;
	import flash.display.Bitmap;
	import visual.imgcls;
	import Managers.soundmanager;
	import utils.*;
	
	
	/**
	 * ...
	 * @author l
	 */
	public class btnsprite  extends Sprite
	{		
		
		
		
		public function btnsprite(aText:String,aFunction:Function,aHeight:uint =36,aWidth:uint=100) 
		 {

			
			norm_pic = imgcls.getbtnframe(aWidth, aHeight,true);
			mo_pic = imgcls.getbtnframe(aWidth, aHeight);
			addChild(mo_pic);
			addChild(norm_pic);
	
			var tfield:TextField = new TextField();
			addChild(tfield);
			textproc.processall(this,12);
			
			tfield.text = aText;
			tfield.y = 11;
			
			tfield.autoSize = TextFieldAutoSize.LEFT
			tfield.x = (aWidth - tfield.width) / 2;
			tfield.mouseEnabled = false;
			
			var moverfunc:Function=function (e:Event) {
			norm_pic.visible = false; };
			var outfunc:Function =  function (e:Event) {
				norm_pic.visible = true; };
			
			addEventListener(MouseEvent.ROLL_OVER,mo , false, 0, true);
			addEventListener(MouseEvent.ROLL_OUT,mout ,false,0,true);
			addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
			

			clickfun = aFunction;
		}
		
		var clickfun:Function = null;
		var norm_pic:Shape;
		var mo_pic:Shape ;
		
		private function mo(e:Event):void
		{
			norm_pic.visible = false;
			
		}
		
		private function mout(e:Event):void
		{
			norm_pic.visible = true;
		}
		
		private function onClick(e:Event):void
		{
			soundmanager.instance.playeffect(soundmanager.CLICK);
			if (clickfun != null)
			{
				clickfun();
			}
			
		}
		
	}

}