package gamecore  
{

	import adobe.utils.CustomActions;
	import flash.accessibility.Accessibility;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.display.Bitmap;
	import Managers.soundmanager;
	import com.greensock.TweenLite;
	import visual.effects.shakeeffect;
	import com.greensock.easing.ExpoIn;
	/**
	 * ...
	 * @author l
	 */
	public class block extends Shape
	{
		
		private static var blockdefs:Array =
		[
		[1, 1, 1, 1,
		0,0,0,0
		 ],
		[ 1, 1, 1,
		  0, 0, 1],
		[ 1, 1, 0,
		  0, 1, 1],
		[ 1, 1, 1,
		  0, 1, 0],
		[1, 1,
		 1, 1 ],
		 [ 0, 1, 1,
		   1, 1, 0],
		 [1]
		];
		
		
		
		
		[Embed(source = "../../lib/imgs/stones32bit/bluestone.png")]
		public static var img_stone_blue:Class;
		
		[Embed(source = "../../lib/imgs/stones32bit/greenstone.png")]
		public static var img_stone_green:Class;
		
		[Embed(source = "../../lib/imgs/stones32bit/magentastone.png")]
		public static var img_stone_magenta:Class;
		
		[Embed(source = "../../lib/imgs/stones32bit/orangestone.png")]
		public static var img_stone_orange:Class;
		
		[Embed(source = "../../lib/imgs/stones32bit/purplestone.png")]
		public static var img_stone_purple:Class;
		

		
		[Embed(source = "../../lib/imgs/stones32bit/redstone.png")]
		public static var img_stone_red:Class;
		
		[Embed(source = "../../lib/imgs/stones32bit/yellowtone.png")]
		public static var img_stone_yellow :Class;
		
		
		
		
		public static var imgclasses:Array = [img_stone_blue,img_stone_green,img_stone_magenta,img_stone_orange,img_stone_red,img_stone_yellow,img_stone_purple];
		private static var colordefs:Array = [0x0000FF,0xFF0000,0x00FF00,0xFFFF00,0x00FFFF,0xFF00FF];
		private var blockindex:uint = 0;
		private static const blocksize = 32;
		private var turnidx:uint = 4;
		private var fieldref:field;
		public var usedblocks:Array = new Array();
		private var _color:uint=0
		private var _coloridx:uint = 0;
		private var _pospoint:Point = new Point();
		
		
		public function get xpos():Number
		{
			return _pospoint.x;
		}
		public function get ypos():Number
		{
			return _pospoint.y;
		}
		public function setpos(aX:Number, aY:Number)
		{
			_pospoint.x = aX;
			_pospoint.y = aY;
			gotopos();
		}
		
		
		
		public function soloblocks():Array
		{
			var retarray:Array = new Array();
			
			for each(var pointy:Point in usedblocks)
			{
				var newblock:block = new block(blockdefs.length-1, fieldref);
				newblock.coloridx = _coloridx;
				
				newblock.setpos(pointy.x + xpos,pointy.y + ypos);
				retarray.push(newblock);
			}
			
			return retarray;
		}
		public function set coloridx(aColor:uint):void
		{
			_coloridx = aColor;
			drawblocks();
		}
		public function turn():void
		{
			if(blockindex!=4)
			turnidx++
			else if (blockindex == 5)
			{
				drawblocks();
				return;
			}
			if (turnidx >3)
				turnidx = 0;

			var xtpos:int ;
			var ytpos:uint ;
			var len:uint = blockdefs[blockindex].length;
			var halflen:uint = len / 2
			var newblockuse:Array = new Array();
			for (var c:uint = 0; c < len; c++)
			{
				if (turnidx==0)
				{
				 xtpos = c % halflen;
				 ytpos = Math.floor( c / halflen);
				}else if(turnidx==1)
				{
					xtpos = (1 - Math.floor(c / halflen));
					ytpos = c % halflen ;

				}else if (turnidx == 2 )
				{
					xtpos = ((halflen - (c % halflen) ) - 1);
					 ytpos = (1 - Math.floor( c / halflen)) ;
				}
				else
				{
					xtpos = Math.floor(c / halflen);
					ytpos = (halflen - (c % halflen) - 1) ;
				}
				
				if (blockdefs[blockindex][c] > 0)
				{
					newblockuse.push(new Point(xtpos,ytpos) );
						
				}
			}
			if (fieldref == null)
			{
				usedblocks = newblockuse;
				drawblocks();
				return;
			}
			else
			{
				if (!fieldref.hascollision(new Point(xpos,ypos), newblockuse))
				{
					usedblocks = newblockuse;
					drawblocks();
				}
				
			}
		}

		
		private function drawblocks():void 
		{
			graphics.clear();
		
			var bmpdata:BitmapData = Bitmap (new imgclasses[_coloridx]() ).bitmapData;
			for each(var pointy:Point in usedblocks)
			{
				graphics.beginFill(0x0);
				graphics.drawRect(pointy.x*blocksize, pointy.y*blocksize, blocksize, blocksize);	
				graphics.beginBitmapFill(bmpdata);
				graphics.drawRect(pointy.x*blocksize, pointy.y*blocksize, blocksize-2, blocksize-2);
			}
		
		}
		
		public function block(aBindex:uint,aField:field=null) 
		{
			fieldref = aField;
			if (aBindex > blockdefs.length - 1)	
				aBindex = 0;
			coloridx = aBindex;
			blockindex = aBindex;
			turn();
			drawblocks();

		}
		
		
		private function gotopos(aDur:uint=0):void
		{
			if (aDur == 0)
			{
				this.x = _pospoint.x * blocksize;
				this.y = _pospoint.y * blocksize;
			}else
			{
			TweenLite.to(this, aDur, { x:_pospoint.x * blocksize,y:_pospoint.y * blocksize} );	
			}
		}

		
		public function removeani():void
		{
			/*var seff:shakeeffect = new shakeeffect();
			seff.applyaniamtion(this, 400, removeself);*/
			fieldref.anilayer.addChild(this);
			var dur:Number = (field.blocksize * field.bl_height) - this.y;
			dur *= 0.02;
			dur -= dur/3;
			
			
			
			TweenLite.to(this,dur , {rotation:Math.random()*180,y:field.bl_height*field.blocksize+150,onComplete:removeself ,ease:ExpoIn} );
			
		}
		
		public function removeself():void
		{
			if (this.parent != null)
			{
				this.parent.removeChild(this);
			}
		}
		
		public function drop(aHeight:int):void
		{
			setpos(_pospoint.x, _pospoint.y + aHeight);
		}
		
		public function moveleft():void 
		{
			if( !fieldref.hascollision(new Point(xpos-1,ypos),usedblocks))
				{
					_pospoint.x-- ;
					gotopos();
				}

		}
		
		public function movright():void 
		{
			if ( !fieldref.hascollision(new Point(xpos+1, ypos), usedblocks))
			{
				_pospoint.x++;
				gotopos();
			}
		}
		
		public function movedown( aDur:uint=0):void
		{
			if (!fieldref.hascollision(new Point(xpos, ypos + 1), usedblocks))
			{
				_pospoint.y++;
				gotopos(aDur);
			}
			else
			{
				if (ypos==0)
				{
					fieldref.gameover();
					
				}else
				{
					fieldref.addsoloblocks(this);
					fieldref.newround(); 
					soundmanager.instance.playeffect(soundmanager.CLUNK);
				}
			}
		}
		
	}

}