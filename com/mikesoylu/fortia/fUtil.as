////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2008 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////
package com.mikesoylu.fortia {
	import flash.geom.Point;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	
	public class fUtil {
		/** tweens an object from below the screen */
		public static function enterBelow(obj:*, time:Number = 1):Tween {
			var tween:Tween = new Tween(obj, time, Transitions.EASE_OUT);
			var y:Number = obj.y;
			tween.animate("y", y);
			obj.y = fGame.height + obj.height;
			return tween;
		}
		
		/** tweens an object from above the screen */
		public static function enterAbove(obj:*, time:Number = 1):Tween {
			var tween:Tween = new Tween(obj, time, Transitions.EASE_OUT);
			var y:Number = obj.y;
			tween.animate("y", y);
			obj.y = -obj.height;
			return tween;
		}
		
		/** clamps value between low and hi */
		public static function clamp(low:*, hi:*, value:*):* {
			if (value > hi) {
				value = hi;
			} else if (value < low) {
				value = low;
			}
			return value;
		}
		
		/** linear interpolation, delta is between 0..1 */
		public static function lerp(delta:Number, from:Number, to:Number):Number {
			if (delta > 1)
				return to;
			if (delta < 0)
				return from;
			
			return from + (to - from) * delta;
		}
		
		/** returns the sign of a numeric value*/
		public static function sign(value:Number):Number {
			if (value == 0.0) {
				return 0.0;
			}
			return Math.abs(value) / value;
		}
		
		/** returns true if a is almost equal to b Note:threshold is a positive number */
		public static function isClose(a:*, b:*, threshold:*):Boolean {
			return (Math.abs(a - b) < threshold);
		}
		
		/** swaps two objects */
		public static function swap(a:*, b:*):void {
			var tmp:* = a;
			a = b;
			b = tmp;
		}
		
		/**
		 *  Converts an HSB color specified by the parameters to a
		 *  uint RGB color.
		 *  @param hue The hue 0-360.
		 *  @param saturation The saturation 0-1.
		 *  @param brightness The brightness 0-1.
		 *  @return An RGB color.
		 */
		public static function toRGB(hue:Number, saturation:Number, brightness:Number):uint {
			// Conversion taken from Foley, van Dam, et al
			var r:Number, g:Number, b:Number;
			if (saturation == 0) {
				r = g = b = brightness;
			} else {
				var h:Number = (hue % 360) / 60;
				var i:int = int(h);
				var f:Number = h - i;
				var p:Number = brightness * (1 - saturation);
				var q:Number = brightness * (1 - (saturation * f));
				var t:Number = brightness * (1 - (saturation * (1 - f)));
				switch (i) {
					case 0:
						r = brightness;
						g = t;
						b = p;
						break;
					case 1:
						r = q;
						g = brightness;
						b = p;
						break;
					case 2:
						r = p;
						g = brightness;
						b = t;
						break;
					case 3:
						r = p;
						g = q;
						b = brightness;
						break;
					case 4:
						r = t;
						g = p;
						b = brightness;
						break;
					case 5:
						r = brightness;
						g = p;
						b = q;
						break;
				}
			}
			r *= 255;
			g *= 255;
			b *= 255;
			return (r << 16 | g << 8 | b);
		}
		
		/**
		 *  Converts a color from RGB format into an Object with h, s, b fields.
		 *  @param rgb The RGB color.
		 *  @return object representing the RGB color.
		 */
		static public function toHSB(rgb:uint):Object {
			// Conversion taken from Foley, van Dam, et al
			var hue:Number, saturation:Number, brightness:Number;
			var r:Number = ((rgb >> 16) & 0xff) / 255;
			var g:Number = ((rgb >> 8) & 0xff) / 255;
			var b:Number = (rgb & 0xff) / 255;
			var max:Number = Math.max(r, Math.max(g, b));
			var min:Number = Math.min(r, Math.min(g, b));
			var delta:Number = max - min;
			brightness = max;
			if (max != 0)
				saturation = delta / max;
			else
				saturation = 0;
			if (saturation == 0)
				hue = NaN;
			else {
				if (r == max)
					hue = (g - b) / delta;
				else if (g == max)
					hue = 2 + (b - r) / delta
				else if (b == max)
					hue = 4 + (r - g) / delta;
				hue = hue * 60;
				if (hue < 0)
					hue += 360;
			}
			return {"h": hue, "s": saturation, "b": brightness};
		}
		
		/** returns a random bright color, optionally with alpha */
		public static function getRandomColor(alpha:Number = 1):uint {
			return toRGB(Math.random() * 360, Math.random() * 0.5 + 0.25, Math.random() * 0.25 + 0.75) | (0xFF * alpha) << 24;
		}
		
		public static function getRandomLetter(uppercase:Boolean = false):String {
			const rng:Number = ("z".charCodeAt() - "a".charCodeAt() + 1);
			var ret:String = String.fromCharCode("a".charCodeAt() + Math.floor(Math.random() * rng));
			if (uppercase) {
				return ret.toUpperCase();
			}
			return ret;
		}
		
		/** returns the closest distance to angle dst */
		public static function toAngle(src:Number, dst:Number):Number {
			var va:Point = new Point(Math.cos(src), Math.sin(src));
			var vb:Point = new Point(Math.cos(dst), Math.sin(dst));
			
			var sine:Number = va.x * vb.y - va.y * vb.x; // cross
			var cosine:Number = va.x * vb.x + va.y * vb.y; // dot
			
			return Math.atan2(sine, cosine);
		}
	}
}