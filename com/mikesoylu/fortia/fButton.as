package com.mikesoylu.fortia 
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * Extends the starling.display.Button but we must modify it for this to work(private->protected)
	 * @author bms
	 */
	public class fButton extends Button 
	{
		protected var flipped:Boolean;
		
		public function fButton(upState:Texture, text:String = "", downState:Texture = null) 
		{
			super(upState, text, downState);
			if (mTextField)
			{
				mTextField.fontSize = Math.ceil(height / 2.5);
			}
		}
		
		public function get isFlipped():Boolean
		{
			return flipped;
		}
		
		public function changeImage(tex:Texture):void
		{
			upState = tex;
			
			if (true == flipped)
			{
				mBackground.x = mBackground.width;
				mBackground.scaleX = -1;
			} else
			{
				mBackground.x = 0;
				mBackground.scaleX = 1;
			}
		}
		
		public function set isFlipped(flipped:Boolean):void
		{
			this.flipped = flipped;
			
			if (true == flipped)
			{
				mBackground.x = mBackground.width;
				mBackground.scaleX = -1;
			} else
			{
				mBackground.x = 0;
				mBackground.scaleX = 1;
			}
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