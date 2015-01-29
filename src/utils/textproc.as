package utils  
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.external.ExternalInterface;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author l
	 */
	public class textproc 
	{
		

		[Embed(source = "../../lib/fonts/8bit.[fontvir.us].ttf",
        fontName = "bitfont",
        mimeType = "application/x-font",
        advancedAntiAliasing="true",
        embedAsCFF="false")]
		private var bitfont:Class;
		public function textproc() 
		{
			
		}
		
		public static function processall(aDPC:DisplayObjectContainer,aSize:uint=0)
		{
			for (var c = aDPC.numChildren; c > 0;c--)
			{
				
				var dis:DisplayObject = aDPC.getChildAt(c - 1);
				if (dis is TextField)
				{
					proccesstfield(TextField(dis),aSize);
				}
			}
		}
		
		public static function proccesstfield(aTfield:TextField, aSize:uint = 0 ):void
		{
			var prevtext:String = aTfield.text;
			var textField: TextField = aTfield
		
			if (aSize < 1)
			{
				aSize = uint(textField.getTextFormat().size);
			}
				
			//tformat.font = "bitfont";
		
			textField.defaultTextFormat = new TextFormat("bitfont", aSize);
			textField.embedFonts = true;
			aTfield.text = prevtext;
			aTfield.selectable = false;
				

				
		}
		
	}

}