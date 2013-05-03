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
		private static var _instances:Vector.<AssetManager> = null;
		private static var _names:Object = null;
		private static var _loadCount:int = 0;
		
		/** the starling AssetManager instance */
		public static function get instances():Vector.<AssetManager>
		{
			if (null == _instances)
			{
				_instances = new Vector.<AssetManager>();
			}
			return _instances;
		}
		
		public static function get names():Object
		{
			if (null == _names)
			{
				_names = new Object();
			}
			return _names;
		}
		
		/** destroy the asset manager */
		public static function destroy():void
		{
			if (null != _instances)
			{
				for (var i:int = 0; i < _instances.length; i++)
				{
					_instances[i].purge();
				}
				_instances = null;
			}
			_names = null;
		}
		
		public static function addManager(name:String, scale:Number = 1):void
		{
			instances.push(new AssetManager(scale));
			names[name] = instances.length - 1;
		}
		
		// wrapper functions
		public static function loadQueues(onComplete:Function):void
		{
			_loadCount = instances.length;
			for (var i:int = 0; i < instances.length; i++)
			{
				instances[i].loadQueue(function(ratio:Number):void
				{
					trace("<fAssetLoader> Progress:", ratio);
					
					if (ratio == 1.0)
					{
						_loadCount--;
						if (_loadCount == 0)
						{
							onComplete();
						}
					}
				});
			}
		}
		
		public static function enqueue(name:String, ... rawAssets):void
		{
			if (names[name] != null)
			{
				instances[names[name]].enqueue(rawAssets);
			} else
			{
				throw new fError("Manager name invalid.");
			}
		}
		
		/** Used to play sounds */
		public static function play(name:String, loops:int = 0, volume:Number = 1, pan:Number = 0):SoundChannel
		{
			var instance:AssetManager = null;
			for (var i:int = 0; i < instances.length; i++)
			{
				if (null != instances[i].getSound(name))
				{
					instance = instances[i];
					break;
				}
			}
			if (null == instance)
			{
				return null;
			}
			return instance.playSound(name, 0, loops, new SoundTransform(volume, pan));
		}
		
		public static function getTexture(name:String):Texture
		{
			var tex:Texture = null;
			for (var i:int = 0; i < instances.length; i++)
			{
				tex = instances[i].getTexture(name);
				if (null != tex)
				{
					return tex;
				}
			}
			return null;
		}
		
		public static function getTextures(name:String, prefix:String = "", result:Vector.<Texture> = null):Vector.<Texture>
		{
			if (names[name] != null)
			{
				result = instances[names[name]].getTextures(prefix, result);
				return result;
			}
			result = null;
			return null;
		}
		
		/* TODO: write removers
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
		*/
	}
}