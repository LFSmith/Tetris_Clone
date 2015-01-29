package  utils
{
	/**
	 * ...
	 * @author l
	 */
	public class keyhandlerinfo 
	{
		
		public function keyhandlerinfo(aClass:Class,aCallback:Function) 
		{
			Classref = aClass;
			Callback=aCallback;
		}
		
		public var Classref:Class;
		public var Callback:Function;
		
	}

}