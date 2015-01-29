package visual  
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author l
	 */
	public class spinypal extends Sprite
	{
		
		public function spinypal() 
		{
			//addEventListener(Event.ENTER_FRAME, onFrame);
			var foevent:Event = new Event("");
			for (var c:uint = 0; c < 80000; c++ )
			{
			onFrame(foevent);	
			}
			
		}
		
		
		var dotty:Shape = new Shape();
		var curr:Number = 0;
		var dist:Number = 0;
		private function onFrame(e:Event):void 
		{
			
			
			var RED:uint = 0xFF0000*Math.sin(curr+3);
			var GREEN:uint = 0x00;
			var BLUE:uint = 0x0000;
			var col:uint = RED | GREEN | BLUE;
			
			graphics.beginFill(col);
			graphics.drawCircle(Math.sin(curr) * dist, Math.cos(curr) * dist, 1);
		
			curr += 0.003;
			dist += 0.002
			
		}
		
	}

}