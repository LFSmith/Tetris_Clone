package visual.windows  
{
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import visual.imgcls;
	import gamecore.block;
	import gamecore.field;
	import Managers.windowcontroll;
	import utils.textproc;
	
	
	/**
	 * 
	 * ...
	 * @author l
	 */
	public class gamewindow extends Sprite
	{
		
		public function gamewindow(aStartLevel:uint=0) 
		{

			fieldref.valupdatecallback = showscore;
			fieldref.gameovercallback = gameover;
			fieldref.startlevel = aStartLevel;
			fieldref.y = 13;
			var rline:uint = fieldref.x + fieldref.width + 8;
			var scoreframe:Shape = imgcls.getframe(200, 80);
			var levelframe: Shape = imgcls.getframe(200, 80);
			var lineframe:Shape = imgcls.getframe(200, 80);
			
			addChild(fieldref);
			addChild(lineframe);
			addChild(levelframe);
			addChild(scoreframe);
			
			var ttl_lines:TextField = new TextField();
			var ttl_score:TextField = new TextField();
			var ttl_level:TextField = new TextField();
			
			addChild(tf_score);
			addChild(tf_level);
			addChild(tf_line);
			addChild(ttl_lines);
			addChild(ttl_level);
			addChild(ttl_score);
			textproc.processall(this,20);
			
			ttl_lines.text = "LINES";
			ttl_score.text = "SCORE";
			ttl_level.text = "LEVEL";

			
			ttl_score.x = ttl_lines.x = ttl_level.x = rline + 70;
		
			bg_prev.x = rline;
			bg_prev.y = fieldref.y + fieldref.height - bg_prev.height-13;
			tf_line.x=tf_level.x = tf_score.x = tf_line.x=rline+4;
			
			addChild(bg_prev)
			lineframe.x=scoreframe.x = bg_prev.x = levelframe.x = rline;
			
			
			levelframe.y = scoreframe.y + levelframe.height + 4;
			lineframe.y  = levelframe.y + levelframe.height + 4; 
			
			ttl_level.y = levelframe.y+11;
			ttl_score.y = scoreframe.y+11;
			ttl_lines.y = lineframe.y +11;
			
			tf_score.y = ttl_score.y+30; 
			tf_level.y = ttl_level.y+30 
			tf_line.y  = ttl_lines.y+30;
			
			tf_level.width = 180;
			tf_line.width = 180;
			tf_score.width = 180;
			
			tf_score.autoSize = TextFieldAutoSize.CENTER;
			tf_level.autoSize = TextFieldAutoSize.CENTER;
			tf_line.autoSize = TextFieldAutoSize.CENTER;

			showscore();
			fieldref.start();

		}
		
		private var bg_prev:Shape = imgcls.getframe(200,5*32);
		private var tf_score:TextField = new TextField();
		private var tf_level:TextField = new TextField();
		private var tf_line:TextField = new TextField();
		private var fieldref:field = new field();
		private var govervec:Vector.<Function> = new < Function>[finish];
		private var govervect:Vector.<String> = new < String > ["OK"];
		private var nblock:block = new block(0);
		
		private function gameover():void
		{
			windowcontroll.instance.showoptions(govervec, govervect, "GAMEOVER", "GAMEOVER");
		}
		
		private function finish():void
		{
			windowcontroll.instance.showlevelselectwindow();
		}
		
		private function showscore():void
		{
			tf_score.text = fieldref.score.toString();
			tf_level.text = fieldref.level.toString();
			tf_line.text = fieldref.lines.toString();
			if (nblock.parent != null)
			{
				nblock.parent.removeChild(nblock);
			}
			
			nblock = new block(fieldref._nextblocknr);
			nblock.x = bg_prev.x+ (  (bg_prev.width-nblock.width) )/2;
			nblock.y = bg_prev.y +(  (bg_prev.height-nblock.height) )/2;
			addChild(nblock);
		}
		
	}

}