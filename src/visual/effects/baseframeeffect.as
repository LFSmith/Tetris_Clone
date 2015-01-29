package visual.effects 
{
	import flash.display.DisplayObject;
	import flash.utils.getTimer;
	import flash.events.Event;
	/**
	 * ...
	 * @author l
	 */
	public class baseframeeffect implements Ianimator
	{
		
		public function baseframeeffect() 
		{
			
		}
		
		private var _starttime:int = 0;
		protected var anitarg:DisplayObject ;
		private var _duration:int;
		private var completecallback:Function = null;
		private var endtime:int;
		
		public function applyaniamtion(aTarget:DisplayObject, aDuration:uint,aComplettcallback:Function=null):void
		{
			anitarg = aTarget;
			_duration = aDuration;
			_starttime = getTimer();
			endtime =_starttime + aDuration;
			completecallback = aComplettcallback;
			anisetup();
			anitarg.addEventListener(Event.ENTER_FRAME,onFrame);

		}
		
		protected function anisetup():void 
		{
			
		}
		
		private function onFrame(e:Event):void 
		{
			var currtime:int = getTimer();
			var timeleft:int =endtime-currtime ;
			if (currtime >= endtime)
			{
				endanimation();
				if (completecallback != null)
				{
					completecallback();
				}
				
				
			}else
			{
				
				animate( Number((_duration-timeleft)/_duration ));
			}
		}
		
		protected function animate(aPercent:Number):void 
		{
			
		}
		
		protected function endanimation():void 
		{
			
		}
		
	}

}