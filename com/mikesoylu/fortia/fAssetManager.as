package com.mikesoylu.fortia 
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	// TODO: this will need to be able to manage sounds also
	public class fAssetManager
	{
		private static var instance:fAssetManager;
		
		private var textureAtlasCache:Dictionary;
		private var soundCache:Dictionary;
		
		public function fAssetManager()
		{
			textureAtlasCache = new Dictionary();
			soundCache = new Dictionary();
		}
		
		/**
		 * Adds new texture atlas to cache
		 * @param	atlasName a name for your atlas, doesn't have to be the filename.
		 * @param	AtlasIMG
		 * @param	AtlasXML
		 */
		public static function addTextureAtlas(atlasName:String, AtlasIMG:Class, AtlasXML:Class):void
		{
			if (null == instance)
			{
				instance = new fAssetManager();
			}
			
			//TODO: check if we have a similar atlasName in our cache. So we check for typo's
			if (null == instance.textureAtlasCache[atlasName])
			{
				var bitmap:Bitmap = new AtlasIMG();
				var texture:Texture = Texture.fromBitmap(bitmap);
				var xml:XML = XML(new AtlasXML());
				instance.textureAtlasCache[atlasName] = new TextureAtlas(texture, xml);
			}
		}
		
		/**
		 * Gets a texture from the texture atlas cache
		 * @param	atlasName
		 * @param	textureName
		 * @return	the texture
		 */
		public static function getTexture(atlasName:String, textureName:String):Texture
		{
			if (null == instance)
			{
				instance = new fAssetManager();
			}
			
			if (null == instance.textureAtlasCache[atlasName])
			{
				throw new fError("Atlas does not exist");
			}
			
			return (instance.textureAtlasCache[atlasName] as TextureAtlas).getTexture(textureName);
		}
		
		/**
		 * Removes the specified atlas
		 * @param	atlasName
		 */
		public static function removeTextureAtlas(atlasName:String):void
		{
			if (null == instance.textureAtlasCache[atlasName])
			{
				throw new fError("Atlas does not exist");
			}
			
			(instance.textureAtlasCache[atlasName] as TextureAtlas).dispose();
			instance.textureAtlasCache[atlasName] = null;
		}
	}
}