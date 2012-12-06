package com.mikesoylu.fortia 
{
	import starling.display.Button;
	import starling.textures.Texture;
	
	/**
	 * Extends the starling.display.Button but we must modify it for this to work(private->protected)
	 * @author bms
	 */
	public class fTintedButton extends Button 
	{
		public function fTintedButton(upState:Texture, text:String, downState:Texture = null) 
		{
			super(upState, text, downState);
		}
		
		public function set color(c:uint):void
		{
			mBackground.color = c;
		}
		
		public function get color():uint
		{
			return mBackground.color;
		}
	}
}