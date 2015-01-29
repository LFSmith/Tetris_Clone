package gamecore  
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import visual.imgcls;
	import utils.keyhandler;
	import Managers.windowcontroll;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author l
	 */
	public class field extends Sprite
	{
		
		public static const blocksize:uint = 32;
		public static const bl_width:uint = 10;
		public static const bl_height:uint = 22;
		public static const startspeed:uint = 2;
		public static const speedinr:uint = 1;
		private static const lvlpointmulti:uint = 1;
		private static const lvlspeedmulti:Number = 2;
		private static const maxspeedlvl:uint = 15;
		private static const blockpoint:uint = 10;
		private static const tetrismulti:uint = 2 ;
		private static var basespeed:uint = 15 ;
		public var anilayer:Sprite = new Sprite();
		
		
		public  var _nextblocknr:uint = 0;
		private var currlevel:uint = 0;
		private var acktblock:block ;
		private var _paused:Boolean = false;
		private var ticker:Timer = new Timer(basespeed);
		private var grid:Shape;
		public var soloblocks:Array = new Array();
		public var lastrowdestroyedcount:uint = 0;
		
		
		public var totalrowscleared:uint = 0;
		private var _score:uint = 0;
		private var _level:uint = 0;
		private var _lines:uint=0;
		public var startlevel:uint = 0;;
		
		private var currcount:uint = 0;
		
		private var p_vec:Vector.<Function> = new <Function>[togglepause];
		private var p_svec:Vector.<String> = new <String>["continue"];
		private var continouetime:int = 0;
		private var _isgameover:Boolean = false;
		public var valupdatecallback:Function = function() { };
		public var gameovercallback:Function = function() { };
		
		public function field() 
		{	
			addChild(anilayer);
			_nextblocknr = rnd_bnum;
			acktblock = new block(0, this);
			drawbackground();
			addEventListener(Event.ADDED_TO_STAGE, onadded);
			ticker.addEventListener(TimerEvent.TIMER,onTick);
		}
		
		private function drawbackground():void
		{
			var bgframe:DisplayObject = imgcls.getframe(blocksize * bl_width + 26, blocksize * bl_height + 26);
			bgframe.y = -13;
			bgframe.x = -13;
			addChild(bgframe);
			grid = new Shape();
			grid.graphics.lineStyle(1);
			
			for (var yc:uint = 0; yc <= bl_height; yc++ )
			{
				grid.graphics.moveTo(0,yc*blocksize);
				grid.graphics.lineTo(bl_width*blocksize,yc*blocksize);
			}	
			for (var xc:uint = 0; xc <= bl_width; xc++ )
			{
				grid.graphics.moveTo(xc * blocksize, 0 );	
				grid.graphics.lineTo(xc * blocksize, bl_height * blocksize);
			}
			addChild(grid);
		}
		
		public function start():void
		{
			_paused = false;
			spawnblock(); 
			valupdatecallback();
			ticker.start();
		}
		
		public function stop():void
		{
			ticker.stop();
			stage.removeEventListener(KeyboardEvent.KEY_UP,onkey);
		}
		
		public function reset():void
		{
			for each (var blocky:block in soloblocks)
			{
				if (blocky.parent != null)
				{
					blocky.parent.removeChild(blocky);
				}
			}
			if (acktblock.parent != null)
			{
					acktblock.parent.removeChild(acktblock);
			}
			soloblocks = [];
			lastrowdestroyedcount = 0;
			_isgameover = false;
			
		}
		
		private function onadded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onadded);
			keyhandler.instance.removeclasscallbacks(field);
			keyhandler.instance.addcallback(onkey,field);
		}
		
		private function onkey(aKeycode:uint):void 
		{
			
			if (_paused)
				return;
			switch(aKeycode)
			{
				case 38:
					acktblock.turn();
					break;
				case 37:
					acktblock.moveleft();
					break;
				case 39:
					acktblock.movright();
					break;
				case 40:
					acktblock.movedown();
					break;
				case 80:
					togglepause();
					break;
				
			}
		}
		
		private function togglepause():void 
		{
			_paused = !_paused;
			if (_paused)
			{
				windowcontroll.instance.showoptions(p_vec, p_svec, "Pause", "Pause");
			}
		}
		
		public function addwait(aDuration:int):void
		{
			var targettime:int = getTimer() + aDuration;
			if (targettime > continouetime)
			{
				continouetime = targettime;
			}
			
		}
		public function newround():void
		{
			clearrows();
			spawnblock();
			updatescore();
			valupdatecallback();
		}
		private function get rnd_bnum():uint
		{
			
			return Math.floor(Math.random() * 6)
		}
		public function spawnblock():void 
		{
			acktblock = new block(_nextblocknr, this );
			_nextblocknr = rnd_bnum;
			acktblock.setpos(3, 0);
			addChild(acktblock);
			addChild(anilayer);
		}
		public function clearrows():void
		{
			var rem_row_count:Array = new Array();
			var killrows:Vector.<int> = new Vector.<int>();
			lastrowdestroyedcount = 0;
			for each(var soloblocky:block in soloblocks)
			{
				if (rem_row_count[soloblocky.ypos] == null)
				{
					rem_row_count[soloblocky.ypos] = 1;
				}
				else
				{
					rem_row_count[soloblocky.ypos]++;
					if (rem_row_count[soloblocky.ypos] == bl_width)
						killrows.push(soloblocky.ypos);
				}
			}
			
			for each(var krow:int in killrows)
			{
				
				for (var c:int = soloblocks.length - 1; c >= 0; c-- )
				{
					if (soloblocks[c].ypos == krow)
					{
						soloblocks[c].removeani();
						soloblocks.splice(c, 1);
					}
				}
			}
			
			for each(var krow:int in killrows)
			{
				lastrowdestroyedcount++;
				for (var c:int = soloblocks.length - 1; c >= 0; c-- )
				{
					if (soloblocks[c].ypos <krow)
					{
						soloblocks[c].drop(1); 
					}
				}
			}
			updatescore(killrows.length);
			
		}
		public function get level():uint
		{
			return startlevel+(totalrowscleared / 10);
		}
		public function get lines():uint
		{
			return totalrowscleared;
		}
		public function get score():uint
		{
			return _score;
		}
	
		public function updatescore(aRowscleared:uint = 0):void
		{
			var pointsearned:uint = aRowscleared * blockpoint * bl_width;
			if (aRowscleared > 3)
			{
				pointsearned =Math.ceil( pointsearned * tetrismulti);
			}
			totalrowscleared = totalrowscleared + aRowscleared;
			_score = _score + pointsearned;
		}
		
		public function hascollision(aZeropoint:Point,aArray:Array)
		{
			for each (var pointy:Point in aArray)
			{
				if (pointy.x+aZeropoint.x >= bl_width)
					return true;
				if (pointy.x+aZeropoint.x < 0)
					return  true;
				if ( (pointy.y +aZeropoint.y) >= bl_height)
					return true;
					
					
				for each (var binfo:block in soloblocks)
				{
					if ((pointy.x +aZeropoint.x == binfo.xpos ) && (pointy.y +aZeropoint.y == binfo.ypos ) )
						return true;
				}	
			}
			
			return false;
		}
		
		public function addsoloblocks(aBlock:block):void 
		{
			removeChild(aBlock);
			var newsolos:Array = aBlock.soloblocks();

			for each(var solob:block in newsolos)
			{
				soloblocks.push(solob);
				addChild(solob);
			}
		}
		
		public function gameover():void 
		{
			if (_isgameover)
				return;
			_isgameover = true;
			stop();
			updatescore();
			gameovercallback();
			
		}
		
		private function get halted():Boolean
		{
			if (_paused)
				return true;
			if (getTimer() < continouetime)
				return true;
				
			return false;
		}
		private function onTick(e:TimerEvent):void 
		{
			if (halted)
				return;
				currcount++;
				if(currcount>=maxspeedlvl-level||level>=maxspeedlvl)
				{
					acktblock.movedown(0);
					currcount = 0;
				}
		}
		
		
	}

}