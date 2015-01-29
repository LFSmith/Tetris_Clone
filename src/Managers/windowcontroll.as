package Managers  
{
	import flash.automation.StageCapture;
	import flash.desktop.Clipboard;
	import flash.display.ActionScriptVersion;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import visual.imgcls;
	import conf.config;
	import gamecore.*
	import utils.*;
	import visual.interfacelems.*;
	import visual.windows.*;
	
	
	/**
	 * ...
	 * @author l
	 */
	public class windowcontroll 
	{
		
		public function windowcontroll() 
		{
			
		}
		
		private var windows:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		private static var _instance:windowcontroll;
		public static var windowlayer:DisplayObjectContainer;
		
		public static function get instance():windowcontroll
		{
			if (_instance == null)
				_instance = new windowcontroll();
			return _instance;
		}
		
		public function closeall():void
		{
			for each (var winnsprite:DisplayObject in windows)
			{
				if (winnsprite.parent)
				{
					winnsprite.parent.removeChild(winnsprite);
			
				}
			}
			
			windows = new Vector.<DisplayObject>();
		}
		public function showlevelselectwindow():void
		{
			closeall();
			var winsprite:Sprite = new Sprite();
			winsprite.addChild(imgcls.getframe(310 + 40, 400));
			var seltxt:TextField = new TextField();
		
			seltxt.y = 12;
			winsprite.addChild(seltxt);
			seltxt.autoSize = TextFieldAutoSize.LEFT;	
			seltxt.text = "select level";
			textproc.proccesstfield(seltxt, 30);
			seltxt.x=(winsprite.width-seltxt.width)/2
			
			
			for (var cx:uint = 0; cx < 3;cx++ )
			{
				for (var cy:uint = 0; cy < 3;cy++)
				{
					var nbtn:invbtn = new invbtn(showplaywindow, (3 * cy) + cx);
					nbtn.x = cx * 105+20;
					nbtn.y = cy * 105+60;
					winsprite.addChild(nbtn);
				}
				
			}
			
			center(winsprite);
			addbg(winsprite);
			showwindow(winsprite);
		}
		
		
		public function addbgbmp():void
		{
			var bg:BitmapData = new BitmapData(config.APP_WIDTH,config.APP_HEIGHT,true,0);
			for (var wc:uint =0; wc < config.APP_WIDTH; wc = wc + 32 )
			{
				for (var hc:uint = 0; hc < config.APP_HEIGHT; hc = hc + 32 )
				{
					var currbmp:Bitmap = new block.imgclasses[Math.floor(Math.random()*block.imgclasses.length)]();
					var curbmpdata:BitmapData = currbmp.bitmapData;
					bg.copyPixels(curbmpdata, new Rectangle(0, 0, 32, 32),new Point(wc,hc) ) ;

				}
			}
			
			var bgbitmap:Bitmap = new Bitmap(bg);
			windowlayer.addChild(bgbitmap);
		}
		public function showplaywindow(aLevel:uint = 0)
		{
			closeall();
			var playwin:gamewindow = new gamewindow(aLevel);
			center(playwin);
			addbg(playwin);
			showwindow(playwin);
			
		}
		
		public function center(aSprite:Sprite):void
		{
			aSprite.x = (config.APP_WIDTH - aSprite.width) / 2
			aSprite.y = (config.APP_HEIGHT - aSprite.height) / 2
		}
		
		public function addbg(aSprite:Sprite,clear:Boolean=true):void
		{
			var bshape:Shape = new Shape();
			bshape.graphics.beginFill(0xFF00FF,(clear)?0.3:0.6); 
			bshape.graphics.drawRect(-1*((config.APP_WIDTH - aSprite.width) / 2),-1*( (config.APP_HEIGHT - aSprite.height) / 2), config.APP_WIDTH,config.APP_HEIGHT);
			aSprite.addChildAt(bshape, 0);
		}
		
		public function showoptions(aFunctions:Vector.<Function>,aNames:Vector.<String>,aTitle:String,aText:String):void
		{
			var retsprite:Sprite = new Sprite();
			var textf:TextField = new TextField();

			textf.text = aText;
			retsprite.addChild(imgcls.getframe(160 * aFunctions.length + 60, 100));
			var btnseg:uint = (retsprite.width-24) / aFunctions.length;
			for (var c:int = 0; c < aFunctions.length; c++ )
			{
				var btntxt:String = "";
	
				if (c < aNames.length)
				{
					btntxt = aNames[c];
				}

				var btnfunc:Function = aFunctions[c];
				var newbtn = new btnsprite(btntxt, function():void {
					removetopwindow();
					btnfunc();
					} );
					newbtn.x = 12+c * btnseg +( (btnseg-newbtn.width)/2 );
					newbtn.y = 50;
				retsprite.addChild( newbtn );
			}
			
			textf.selectable = false;
		
			textf.y = 10;
			textf.multiline = true;
			textf.width = 160 * aFunctions.length;
			textf.autoSize = TextFieldAutoSize.LEFT;
		
			retsprite.addChild(textf);
			
			textproc.processall(retsprite, 18);
			textf.x=(retsprite.width-textf.width)/2
			center(retsprite);
			addbg(retsprite,true);
			showwindow(retsprite);
		}
		
		public function showwindow(aWin:Sprite):void
		{
			windowlayer.addChild(aWin);
			windows.push(aWin);
		}
		public function removetopwindow():void
		{
			if (windows.length > 0)
			{
				var remwindow:DisplayObject = windows.pop();
				if (remwindow.parent != null)
				{
					remwindow.parent.removeChild(remwindow);
				}
			}
		}
	}

}