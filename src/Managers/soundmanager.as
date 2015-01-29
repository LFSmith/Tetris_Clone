package Managers 
{
	import adobe.utils.CustomActions;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.IExternalizable;
	
	/**
	 * ...
	 * @author l
	 */
	public class soundmanager 
	{
		
		public function soundmanager() 
		{
			
		}
		
		public static const CLICK:uint = 0;
		public static const CLUNK:uint = 1;
		
		
		[Embed(source="../../lib/snds/boss.mp3")]
		private var theme:Class;
		[Embed(source = "../../lib/snds/click.mp3")]
		private var click:Class;
		[Embed(source = "../../lib/snds/klunk.mp3")]
		private var klunk:Class;
		private var effectclasses:Array = [click,klunk];
		private var themtrans:SoundTransform = new SoundTransform();
		private var effecttrans:SoundTransform = new SoundTransform();
		private var snd_theme:Sound = new theme();
		private var tply:Boolean = false;
		private var chnl:SoundChannel = new SoundChannel();
		private static var _instance:soundmanager = new soundmanager() ;
		
		public static function get instance():soundmanager
		{
			return _instance;
			
		}
		
		public function set effectvol(aNumber:Number):void
		{
			effecttrans.volume = aNumber;
		}
		
		public function set themevol(aNumber:Number):void
		{
			themtrans.volume = aNumber;
			chnl.soundTransform = themtrans;
		}
		
		public function playeffect(aEffectID:uint)
		{
			if (aEffectID < effectclasses.length)
			{
				var snd_eff:Sound = new  effectclasses[aEffectID]();
				snd_eff.play(0,0,effecttrans);
			}			
		}
		
		public function Toogletheme():void
		{
			if (tply)
			{
				chnl.stop();
				
			}else
			{
				chnl = snd_theme.play(0,0,themtrans);
				chnl.addEventListener(Event.SOUND_COMPLETE, onComplete);
				tply = !tply;
			}
		}
		
		private function onComplete(e:Event):void 
		{
			chnl.removeEventListener(Event.SOUND_COMPLETE, onComplete);
			chnl = snd_theme.play(0,0,themtrans);
			chnl.addEventListener(Event.SOUND_COMPLETE, onComplete, false, 0, true);
		}
		
	}

}