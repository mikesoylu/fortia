package com.mikesoylu.fortia
{
	import adobe.utils.CustomActions;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	/**
	 * Wrapper for static access of Starling's AssetManager
	 */
	public class fAssetManager
	{
		public static var scaleFactor:Number = 1;
		public static var useMipmaps:Boolean = false;
		
		private static var _instance:AssetManager = null;
		
		/** the starling AssetManager instance */
		public static function get instance():AssetManager
		{
			if (null == _instance)
			{
				_instance = new AssetManager(scaleFactor, useMipmaps);
				_instance.verbose = true;
			}
			return _instance;
		}
		
		/** destroy the asset manager */
		public static function destroy():void
		{
			if (null != _instance)
			{
				_instance.purge();
				_instance = null;
			}
		}
		
		// wrapper functions
		public static function loadQueue(onComplete:Function):void
		{
			instance.loadQueue(function(ratio:Number):void
				{
					trace("<fAssetLoader> Progress:", ratio);
					
					if (ratio == 1.0)
						onComplete();
				});
		}
		
		public static function enqueue(... rawAssets):void
		{
			instance.enqueue(rawAssets);
		}
		
		/** Used to play sounds */
		public static function play(name:String, loops:int = 0, volume:Number = 1, pan:Number = 0):SoundChannel
		{
			return instance.playSound(name, 0, loops, new SoundTransform(volume, pan));
		}
		
		public static function getTexture(name:String):Texture
		{
			return instance.getTexture(name);
		}
		
		public static function getTextures(prefix:String = "", result:Vector.<Texture> = null):Vector.<Texture>
		{
			return instance.getTextures(prefix, result);
		}
		
		public static function removeTexture(name:String):void
		{
			instance.removeTexture(name, true);
		}
		
		public static function removeTextureAtlas(name:String):void
		{
			instance.removeTextureAtlas(name);
		}
		
		public static function removeSound(name:String):void
		{
			instance.removeSound(name);
		}
	}
}