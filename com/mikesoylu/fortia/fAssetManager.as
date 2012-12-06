package com.mikesoylu.fortia 
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	// TODO: this will need to be able to manage sounds also
	public class fAssetManager 
	{
		private static var _instance:fAssetManager;
		
		private var textureAtlasCache:Dictionary;
		
		public function fAssetManager()
		{
			textureAtlasCache = new Dictionary();
		}
		
		public static function get instance():fAssetManager
		{
			if (null == _instance)
			{
				_instance = new fAssetManager();
			}
			return _instance;
		}
		
		/**
		 * Adds new texture atlas to cache
		 * @param	atlasName
		 * @param	AtlasIMG
		 * @param	AtlasXML
		 */
		public function addTextureAtlas(atlasName:String, AtlasIMG:Class, AtlasXML:Class):void
		{
			//TODO: check if we have a similar atlasName in our cache. So we check for typo's
			if (null == instance.textureAtlasCache[atlasName])
			{
				var bitmap:Bitmap = new AtlasIMG();
				var texture:Texture = Texture.fromBitmap(bitmap);
				var xml:XML = XML(new AtlasXML());
				_instance.textureAtlasCache[atlasName] = new TextureAtlas(texture, xml);
			}
		}
		
		/**
		 * Gets a texture from the texture atlas cache
		 * @param	atlasName
		 * @param	textureName
		 * @return	the texture
		 */
		public function getTexture(atlasName:String, textureName:String):Texture
		{
			return (_instance.textureAtlasCache[atlasName] as TextureAtlas).getTexture(textureName);
		}
	}
}