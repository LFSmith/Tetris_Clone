package visual  
{
	import adobe.utils.CustomActions;
	import flash.accessibility.AccessibilityImplementation;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.geom.Matrix;
	import visual.interfacelems.lvlbtn;
	/**
	 * ...
	 * @author l
	 */
	public class imgcls 
	{
		
		public function imgcls() 
		{
			
		}

		//frame
		[Embed(source = "../../lib/imgs/frame/tl.png")]
		public static var fr_tl:Class;
		[Embed(source = "../../lib/imgs/frame/tm.png")]
		public static var fr_tm:Class;
		[Embed(source = "../../lib/imgs/frame/tr.png")]
		public static var fr_tr:Class;
		[Embed(source = "../../lib/imgs/frame/ml.png")]
		public static var fr_ml:Class;
		[Embed(source = "../../lib/imgs/frame/mm.png")]
		public static var fr_mm:Class;
		[Embed(source = "../../lib/imgs/frame/mr.png")]
		public static var fr_mr:Class;
		[Embed(source = "../../lib/imgs/frame/bl.png")]
		public static var fr_bl:Class;
		[Embed(source = "../../lib/imgs/frame/bm.png")]
		public static var fr_bm:Class;
		[Embed(source = "../../lib/imgs/frame/br.png")]
		public static var fr_br:Class;
		
		

		

		[Embed(source = "../../lib/imgs/btn/norm/tl.png")]
		public static var btn_tl:Class;
		[Embed(source = "../../lib/imgs/btn/norm/tm.png")]
		public static var btn_tm:Class;
		[Embed(source = "../../lib/imgs/btn/norm/tr.png")]
		public static var btn_tr:Class;
		[Embed(source = "../../lib/imgs/btn/norm/ml.png")]
		public static var btn_ml:Class;
		[Embed(source = "../../lib/imgs/btn/norm/mm.png")]
		public static var btn_mm:Class;
		[Embed(source = "../../lib/imgs/btn/norm/mr.png")]
		public static var btn_mr:Class;
		[Embed(source = "../../lib/imgs/btn/norm/bl.png")]
		public static var btn_bl:Class;
		[Embed(source = "../../lib/imgs/btn/norm/bm.png")]
		public static var btn_bm:Class;
		[Embed(source = "../../lib/imgs/btn/norm/br.png")]
		public static var btn_br:Class;
		

		public static function getbtnframe(aWidth:Number, aHeight:Number, rotate:Boolean = false ):Shape
		{
			var btnclassvec:Vector.<Class> = Vector.<Class>([btn_tl, btn_tm, btn_tr, btn_ml, btn_mm, btn_mr, btn_bl, btn_bm, btn_br]);
			var retshape:Shape = ninescale(aWidth, aHeight, btnclassvec);
			if (rotate)
			{
				retshape.scaleY *= -1;
				retshape.y += retshape.height;
					retshape.scaleX *= -1;
				retshape.x += retshape.width;
			}
		
			return retshape;
		}
		
		
		
		public static function ninescale(aWidth:Number, aHeight:Number, vec_bmpclasses:Vector.<Class>):Shape
		{
			var retshape:Shape = new Shape;
			
			var bmpd_tl:BitmapData = Bitmap( new vec_bmpclasses[0]).bitmapData;
			var bmpd_tm:BitmapData = Bitmap( new vec_bmpclasses[1]).bitmapData; 
			var bmpd_tr:BitmapData = Bitmap( new vec_bmpclasses[2]).bitmapData;
			
			var bmpd_ml:BitmapData = Bitmap( new vec_bmpclasses[3]).bitmapData;
			var bmpd_mm:BitmapData = Bitmap( new vec_bmpclasses[4]).bitmapData;
			var bmpd_mr:BitmapData = Bitmap( new vec_bmpclasses[5]).bitmapData;
			
			var bmpd_bl:BitmapData = Bitmap( new vec_bmpclasses[6]).bitmapData;
			var bmpd_bm:BitmapData = Bitmap( new vec_bmpclasses[7]).bitmapData;
			var bmpd_br:BitmapData = Bitmap( new vec_bmpclasses[8]).bitmapData;
			
			var bottomoverlap:Number = aHeight-bmpd_bm.height ;
			var rightoverlap:Number = aWidth - bmpd_tr.width;
			
			var mtr:Matrix = new Matrix();
			
			
			//draw top
			retshape.graphics.beginBitmapFill(bmpd_tl);
			retshape.graphics.drawRect(0, 0, bmpd_tl.width, bmpd_tl.height);
			
			retshape.graphics.beginBitmapFill(bmpd_tm);
			retshape.graphics.drawRect(bmpd_tl.width, 0, aWidth-bmpd_tl.width-bmpd_tr.width, bmpd_tl.height);

			mtr.translate(rightoverlap, 0);
			retshape.graphics.beginBitmapFill(bmpd_tr,mtr);
			retshape.graphics.drawRect(aWidth - bmpd_tr.width, 0, bmpd_tr.width, bmpd_tr.height);
			
			//drawmiddle
			retshape.graphics.beginBitmapFill(bmpd_ml);
			retshape.graphics.drawRect(0,bmpd_tl.height, bmpd_ml.width, aHeight- bmpd_tl.height-bmpd_bm.height);
			
			retshape.graphics.beginBitmapFill(bmpd_mm);
			retshape.graphics.drawRect(bmpd_tl.width, bmpd_tl.height, aWidth-bmpd_tl.width-bmpd_tr.width, aHeight- bmpd_tl.height-bmpd_bm.height);

			
			//mtr.translate(rightoverlap, 0);
			retshape.graphics.beginBitmapFill(bmpd_mr,mtr,false);
			retshape.graphics.drawRect(aWidth - bmpd_tr.width, bmpd_tl.height, bmpd_tr.width, aHeight- bmpd_tl.height-bmpd_bm.height);
			
	
			//draw bottom
			mtr = new Matrix();
			mtr.translate(0, bottomoverlap);
			retshape.graphics.beginBitmapFill(bmpd_bl,mtr);
			retshape.graphics.drawRect(0,aHeight - bmpd_bl.height, bmpd_bl.width, bmpd_bl.height)
			
			retshape.graphics.beginBitmapFill(bmpd_bm,mtr);
			retshape.graphics.drawRect(bmpd_bl.width, aHeight-bmpd_bm.height, aWidth-bmpd_tl.width-bmpd_tr.width, bmpd_tl.height);
			
			mtr.translate(rightoverlap,0);
			retshape.graphics.beginBitmapFill(bmpd_br,mtr);
			retshape.graphics.drawRect(aWidth - bmpd_br.width, aHeight - bmpd_br.height, bmpd_br.width, bmpd_br.height);
			
			
			return retshape;
		}
		public static function getframe(aWidth:Number, aHeight:Number):Shape
		{
			
			var tilesize:uint = 32;
			var widthoverlap:Number = aWidth % tilesize;
			var heightoverlap:Number = aHeight % tilesize;
			
			var middleheight:int =aHeight-(2*tilesize) ;
			var middlewidth:int = aWidth -(2 * tilesize) ;
			if (middleheight < 0)
				middleheight = 0;
			if (middlewidth < 0)
				middlewidth = 0;
				
			
			var blmtr:Matrix = new Matrix();
			blmtr.translate(0, aHeight - tilesize);
			var bmtr:Matrix = new Matrix();
			bmtr.translate(widthoverlap, heightoverlap);
			var vermatr:Matrix = new Matrix();
			vermatr.translate(widthoverlap, 0);
			var hmatr:Matrix = new Matrix();
			hmatr.translate(0, heightoverlap);
			
			/*aWidth = scale * aWidth;
			aHeight = scale * aHeight;*/
			
			
			var retshape:Shape = new  Shape();
			
			var use_bitmap:Bitmap = new fr_tl();
			retshape.graphics.beginBitmapFill(use_bitmap.bitmapData,null,false);
			retshape.graphics.drawRect(0, 0, tilesize, tilesize);
		
			use_bitmap = new fr_tm();
			retshape.graphics.beginBitmapFill(use_bitmap.bitmapData);
			retshape.graphics.drawRect(tilesize, 0,middlewidth, tilesize);
		
			use_bitmap = new fr_tr();
			retshape.graphics.beginBitmapFill(use_bitmap.bitmapData,vermatr);
			retshape.graphics.drawRect(aWidth - tilesize, 0, tilesize, tilesize);

			
			use_bitmap = new fr_mm();
			retshape.graphics.beginBitmapFill(use_bitmap.bitmapData,null,false);
			retshape.graphics.drawRect(tilesize, tilesize,middlewidth,middleheight);
			
			use_bitmap = new fr_ml();
			retshape.graphics.beginBitmapFill(use_bitmap.bitmapData,null,false);
			retshape.graphics.drawRect(0, tilesize, tilesize,middleheight);
				
			use_bitmap = new fr_mr();
			retshape.graphics.beginBitmapFill(use_bitmap.bitmapData,vermatr);
			retshape.graphics.drawRect(aWidth - tilesize, tilesize, tilesize, middleheight);
			
			use_bitmap = new fr_bl();
			retshape.graphics.beginBitmapFill(use_bitmap.bitmapData,blmtr,false );
			retshape.graphics.drawRect(0, aHeight - tilesize, tilesize, tilesize);
			
			use_bitmap = new fr_bm();
			retshape.graphics.beginBitmapFill(use_bitmap.bitmapData,hmatr);
			retshape.graphics.drawRect(tilesize, aHeight-tilesize ,middlewidth, tilesize);
			
			use_bitmap = new fr_br();
			retshape.graphics.beginBitmapFill(use_bitmap.bitmapData,bmtr);
			retshape.graphics.drawRect(aWidth - tilesize, aHeight - tilesize, tilesize, tilesize);
			
			return retshape;
			
		}
		

		

	
	}

}