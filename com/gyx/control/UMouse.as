package com.gyx.control
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.Stage;
    import flash.filters.DropShadowFilter;
	public class UMouse
	{
		public static const NONE = 0;
		public static const VERTICAL_DOUBLE_POINTER = 1;
		public static const CROSS = 2;
		public static const CROSS_45DEGREE = 3; 
		public static const DOWN_ARROW = 4;
		public static var mouseFollower:Sprite;

		public static function initMouse(thisRoot:Stage)
		{
			mouseFollower = new Sprite();
			thisRoot.addChild(mouseFollower)
			mouseFollower.startDrag(true);
			mouseFollower. filters=[new DropShadowFilter(3,45,0,0.5,2,2,0.4)];
		}
		public static function setFollower(id:int)
		{
			var g:Graphics = mouseFollower.graphics;
			var offsetX;
			var offsetY;
			if (id==UMouse.NONE)
			{
				g.clear();
			}
			else if (id==UMouse.VERTICAL_DOUBLE_POINTER)
			{
				offsetX = 15;
				offsetY = 10;
				g.clear();
				g.lineStyle(3);
				g.moveTo(offsetX+0,offsetY-10);
				g.lineTo(offsetX+0,offsetY+10);
				g.moveTo(offsetX-3,offsetY-6);
				g.lineTo(offsetX+0,offsetY-10);
				g.lineTo(offsetX+3,offsetY-6);
				g.moveTo(offsetX-3,offsetY+6);
				g.lineTo(offsetX+0,offsetY+10);
				g.lineTo(offsetX+3,offsetY+6);
				g.lineStyle(1,0xffffff);
				g.moveTo(offsetX+0,offsetY-10);
				g.lineTo(offsetX+0,offsetY+10);
				g.moveTo(offsetX-3,offsetY-6);
				g.lineTo(offsetX+0,offsetY-10);
				g.lineTo(offsetX+3,offsetY-6);
				g.moveTo(offsetX-3,offsetY+6);
				g.lineTo(offsetX+0,offsetY+10);
				g.lineTo(offsetX+3,offsetY+6);
			}
			else if (id == UMouse.CROSS_45DEGREE)
			{
				offsetX = 15;
				offsetY = 15;
				g.clear();
				g.lineStyle(3);
				g.moveTo(offsetX - 4, offsetY - 4);
				g.lineTo(offsetX + 4, offsetY + 4);
				g.moveTo(offsetX + 4, offsetY - 4);
				g.lineTo(offsetX - 4, offsetY + 4);
				g.lineStyle(1, 0xffffff);
				g.moveTo(offsetX - 4, offsetY - 4);
				g.lineTo(offsetX + 4, offsetY + 4);
				g.moveTo(offsetX + 4, offsetY - 4);
				g.lineTo(offsetX - 4, offsetY + 4);
			}
			else if (id == UMouse.DOWN_ARROW)
			{
				offsetX = 20;
				offsetY = 15;
				g.clear();
				g.lineStyle(1);
				g.beginFill(0xffffff);
				g.moveTo(offsetX - 6, offsetY);
				g.lineTo(offsetX + 6, offsetY);
				g.lineTo(offsetX, offsetY + 6);
				g.lineTo(offsetX - 6, offsetY);
				g.drawRect(offsetX - 6,offsetY-5,12,3);
				g.endFill();
			}
		}
	}

}