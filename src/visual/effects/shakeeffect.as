package visual.effects 
{
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author l
	 */
	public class shakeeffect extends baseframeeffect
	{
		
		public function shakeeffect() 
		{
			
		}
		
	
		private var xshake:int = 4;
		private var yshake:int = 4;
		private var startX:uint = 0;
		private var startY:uint = 0;
		
		
		override protected function anisetup():void 
		{
			startX = anitarg.x;
			startY = anitarg.y;
			
		} 
		
		override protected function animate(aPercent:Number):void 
		{
			anitarg.x = startX+( Math.random() * xshake )*( (Math.random()>0.5)?1:-1  );
			anitarg.y =  startY+(Math.random() * yshake)*( (Math.random()>0.5)?1:-1  );
		}
		
	}

}