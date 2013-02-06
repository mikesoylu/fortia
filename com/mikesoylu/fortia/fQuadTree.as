package com.mikesoylu.fortia 
{
	import flash.geom.Rectangle;

	public class fQuadTree 
	{
		public static const MAX_DEPTH:int = 8;
		public static const MAX_LEAF_ELEMS:int = 4;
		
		/** these are in counter clockwise order starting from top left */
		private var quadrants:Vector.<fQuadTree> = null;
		
		/** this is used internally */
		private static var _collides:Boolean;
		
		/** leave null for using fGame bounds */
		public static var bounds:Rectangle = null;
		
		/** don't call this directly, call overlaps statically */
		public function fQuadTree(bounds:Rectangle, elementsA:Object, elementsB:Object, callback:Function = null, depth:int = 0)
		{
			var lenA:int = elementsA.length;
			var lenB:int = elementsB.length;
			
			// this probably won't happen here but we still check like good little coders
			if (lenA == 0 || lenB == 0)
			{
				// we don't have any more possible collision
				return;
			}
			
			// are we done yet?
			if (lenA + lenB < MAX_LEAF_ELEMS || depth > MAX_DEPTH)
			{
				// we have potential colls
				for each (var e1:fIBasic in elementsA)
				{
					if (e1 is fIPoolable && false == (e1 as fIPoolable).alive)
					{
						continue
					}
					for each (var e2:fIBasic in elementsB)
					{
						if (e2 is fIPoolable && false == (e2 as fIPoolable).alive)
						{
							continue
						}
						if (e1 != e2 && e1.rect.intersects(e2.rect))
						{
							_collides = true;
							if (null != callback)
							{
								callback(e1, e2);
							}
						}
					}
				}
				
			} else // continue to recurse down the tree
			{
				quadrants = new Vector.<fQuadTree>(4);
				
				var quadRects:Vector.<Rectangle> = new Vector.<Rectangle>();
				quadRects.push(new Rectangle(bounds.left, bounds.top, bounds.width / 2, bounds.height / 2));
				quadRects.push(new Rectangle(bounds.left, bounds.top + bounds.height / 2, bounds.width / 2, bounds.height / 2));
				quadRects.push(new Rectangle(bounds.left + bounds.width / 2, bounds.top + bounds.height / 2, bounds.width / 2, bounds.height / 2));
				quadRects.push(new Rectangle(bounds.left + bounds.width / 2, bounds.top, bounds.width / 2, bounds.height / 2));
				
				for (var i:int = 0; i < 4; ++i)
				{
					var quadElemsA:Vector.<fIBasic> = new Vector.<fIBasic>();
					var quadElemsB:Vector.<fIBasic> = new Vector.<fIBasic>();
					
					// get quadrant A groups
					for (var j:int = 0; j < lenA; ++j)
					{
						if (elementsA[j] is fIPoolable && false == elementsA[j].alive)
						{
							continue;
						}
						if (elementsA[j].rect.intersects(quadRects[i]))
						{
							quadElemsA.push(elementsA[j]);
						}
					}
					
					// get quadrant B groups
					for (j = 0; j < lenB; ++j)
					{
						if (elementsB[j] is fIPoolable && false == elementsB[j].alive)
						{
							continue;
						}
						if (elementsB[j].rect.intersects(quadRects[i]))
						{
							quadElemsB.push(elementsB[j]);
						}
					}
					// recurse if we have candidates
					if (quadElemsA.length > 0 && quadElemsB.length > 0)
					{
						quadrants[i] = new fQuadTree(quadRects[i], quadElemsA, quadElemsB, callback, depth + 1);
					} else
					{
						quadrants[i] = null;
					}
				}
			}
		}
		
		/** Checks if two groups of fIBasic objects are overlapping. Works like flixel's FlxG.overlaps */
		public static function overlaps(groupA:Object, groupB:Object, callback:Function = null):Boolean
		{
			if (null == bounds)
			{
				bounds = new Rectangle(0, 0, fGame.width, fGame.height);
			}
				
			var quadElemsA:Object;
			var quadElemsB:Object;
			
			// groupA
			if (groupA is fIBasic)
			{
				quadElemsA = [groupA];
				
			} else if (groupA is fObjectPool)
			{
				var opA:fObjectPool = groupA as fObjectPool;
				
				quadElemsA = opA.objects;
			} else
			{
				// act like it's some kind of array
				quadElemsA = groupA;
			}
			
			// groupB
			if (groupB is fIBasic)
			{
				quadElemsB = [groupB];
				
			} else if (groupB is fObjectPool)
			{
				var opB:fObjectPool = groupB as fObjectPool;
				
				quadElemsB = opB.objects;
			} else
			{
				// act like it's some kind of array
				quadElemsB = groupB;
			}
	
			_collides = false;

			// generate quad tree
			new fQuadTree(bounds, quadElemsA, quadElemsB, callback);
			
			return _collides;
		}
	}
}