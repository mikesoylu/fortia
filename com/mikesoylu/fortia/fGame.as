package com.mikesoylu.fortia 
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import starling.core.Starling;

	public class fGame extends Sprite
	{
		public static var starling:Starling;		
		
		/**
		 * A handy container for a background music object.
		 */
		static public var music:fSound;
		/**
		 * A list of all the sounds being played in the game.
		 */
		static public var sounds:fObjectPool;
		/**
		 * Whether or not the game sounds are muted.
		 */
		static public var mute:Boolean;
		
		/**
		 * Whether or not the game is High Definition.
		 */
		static public var isHighDefinition:Boolean = false;
		/**
		 * Internal volume level, used for global sound control.
		 */
		static protected var _volume:Number;
		
		internal var initialClass:Class;
		internal var AA:int;
		
		public function fGame(initialClass:Class, AA:int = 1)
		{
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			Starling.multitouchEnabled = true;
			Starling.handleLostContext = true;
			
			this.initialClass = initialClass;
			this.AA = AA;
			
			addEventListener(Event.ADDED_TO_STAGE, initGame);
		}
		
		protected function initGame(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initGame);
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			starling = new Starling(initialClass, stage);
			starling.antiAliasing = AA;
			starling.simulateMultitouch = true;
			starling.start();
			
			isHighDefinition = fGame.height > 1024;
			
			trace("<fGame> isHighDefinition:", isHighDefinition);
			trace("<fGame>", fGame.width, "x", fGame.height);
			
			mute = false;
			_volume = 0.5;
			sounds = new fObjectPool();
		}
        
		/**
		 * Set <code>volume</code> to a number between 0 and 1 to change the global volume.
		 * 
		 * @default 0.5
		 */
		 static public function get volume():Number
		 {
			 return _volume;
		 }
		 
		/**
		 * @private
		 */
		static public function set volume(Volume:Number):void
		{
			_volume = Volume;
			if(_volume < 0)
				_volume = 0;
			else if(_volume > 1)
				_volume = 1;
		}
		
		/**
		 * Set up and play a looping background soundtrack.
		 * 
		 * @param	Music		The sound file you want to loop in the background.
		 * @param	Volume		How loud the sound should be, from 0 to 1.
		 */
		static public function playMusic(Music:Class,Volume:Number=1.0):void
		{
			if(music == null)
				music = new fSound();
			else if(music.active)
				music.stop();
			music.loadEmbedded(Music,true);
			music.volume = Volume;
			music.survive = true;
			music.play();
		}
		
		/**
		 * Creates a new sound object.
		 * 
		 * @param	EmbeddedSound	The embedded sound resource you want to play.  To stream, use the optional URL parameter instead.
		 * @param	Volume			How loud to play it (0 to 1).
		 * @param	Looped			Whether to loop this sound.
		 * @param	AutoDestroy		Whether to destroy this sound when it finishes playing.  Leave this value set to "false" if you want to re-use this <code>fSound</code> instance.
		 * @param	AutoPlay		Whether to play the sound.
		 * @param	URL				Load a sound from an external web resource instead.  Only used if EmbeddedSound = null.
		 * 
		 * @return	A <code>fSound</code> object.
		 */
		static public function loadSound(EmbeddedSound:Class=null,Volume:Number=1.0,Looped:Boolean=false,AutoDestroy:Boolean=false,AutoPlay:Boolean=false,URL:String=null):fSound
		{
			if((EmbeddedSound == null) && (URL == null))
			{
				throw new fError("fGame.loadSound() requires either\nan embedded sound or a URL to work.");
				return null;
			}
			var sound:fSound = sounds.getObject() as fSound;
			if (null == sound)
			{
				sound = sounds.addObject(new fSound()) as fSound;
			}
			if(EmbeddedSound != null)
				sound.loadEmbedded(EmbeddedSound,Looped,AutoDestroy);
			else
				sound.loadStream(URL,Looped,AutoDestroy);
			sound.volume = Volume;
			if(AutoPlay)
				sound.play();
			return sound;
		}
		
		/**
		 * Creates a new sound object from an embedded <code>Class</code> object.
		 * NOTE: Just calls FlxG.loadSound() with AutoPlay == true.
		 * 
		 * @param	EmbeddedSound	The sound you want to play.
		 * @param	Volume			How loud to play it (0 to 1).
		 * @param	Looped			Whether to loop this sound.
		 * @param	AutoDestroy		Whether to destroy this sound when it finishes playing.  Leave this value set to "false" if you want to re-use this <code>fSound</code> instance.
		 * 
		 * @return	A <code>fSound</code> object.
		 */
		static public function play(EmbeddedSound:Class,Volume:Number=1.0,Looped:Boolean=false,AutoDestroy:Boolean=true):fSound
		{
			return loadSound(EmbeddedSound,Volume,Looped,AutoDestroy,true);
		}
		
		/**
		 * Creates a new sound object from a URL.
		 * NOTE: Just calls FlxG.loadSound() with AutoPlay == true.
		 * 
		 * @param	URL		The URL of the sound you want to play.
		 * @param	Volume	How loud to play it (0 to 1).
		 * @param	Looped	Whether or not to loop this sound.
		 * @param	AutoDestroy		Whether to destroy this sound when it finishes playing.  Leave this value set to "false" if you want to re-use this <code>fSound</code> instance.
		 * 
		 * @return	A fSound object.
		 */
		static public function stream(URL:String,Volume:Number=1.0,Looped:Boolean=false,AutoDestroy:Boolean=true):fSound
		{
			return loadSound(null,Volume,Looped,AutoDestroy,true,URL);
		}
		
		/**
		 * Called by FlxGame on state changes to stop and destroy sounds.
		 * 
		 * @param	ForceDestroy		Kill sounds even if they're flagged <code>survive</code>.
		 */
		static internal function destroySounds(ForceDestroy:Boolean=false):void
		{
			if((music != null) && (ForceDestroy || !music.survive))
			{
				music.destroy();
				music = null;
			}
			var i:uint = 0;
			var sound:fSound;
			var l:uint = sounds.objects.length;
			while(i < l)
			{
				sound = sounds.objects[i++] as fSound;
				if((sound != null) && (ForceDestroy || !sound.survive))
					sound.destroy();
			}
		}
		
		/**
		 * Called by the game loop to make sure the sounds get updated each frame.
		 */
		static internal function updateSounds(dt:Number):void
		{
			if((music != null) && music.active)
				music.update(dt);
			if (sounds != null)
			{
				var i:int = 0;
				var sound:fSound;
				var l:int = sounds.objects.length;
				while(i < l)
				{
					sound = sounds.objects[i++] as fSound;
					if((sound != null) && sound.active)
						sound.update(dt);
				}
			}
		}
		
		/**
		 * Pause all sounds currently playing.
		 */
		static public function pauseSounds():void
		{
			if((music != null) && music.active)
				music.pause();
			var i:uint = 0;
			var sound:fSound;
			var l:uint = sounds.objects.length;
			while(i < l)
			{
				sound = sounds.objects[i++] as fSound;
				if((sound != null) && sound.active)
					sound.pause();
			}
		}
		
		/**
		 * Resume playing existing sounds.
		 */
		static public function resumeSounds():void
		{
			if(music != null)
				music.play();
			var i:uint = 0;
			var sound:fSound;
			var l:uint = sounds.objects.length;
			while(i < l)
			{
				sound = sounds.objects[i++] as fSound;
				if(sound != null)
					sound.resume();
			}
		}
		
		/**
		 * gets the current fState
		 */
		public static function get state():fState
		{
			return starling.stage.getChildAt(0) as fState;
		}
		
		/**
		 * changes the state and kills the previous
		 */
		public static function set state(rhs:fState):void
		{
			destroySounds();
			
			(starling.stage.getChildAt(0) as fState).destroy();
			starling.stage.removeChildAt(0, true);
			starling.stage.addChildAt(rhs, 0);
		}
		
		public static function get width():int
		{
			return starling.stage.stageWidth;
		}
		
		public static function get height():int
		{
			return starling.stage.stageHeight;
		}
	}
}