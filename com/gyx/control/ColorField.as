package com.gyx.control
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	class ColorField extends Sprite
	{
		static var w:int=14;
		static var h:int=14;
		var selected;
		var color:uint;
		public function ColorField(color){
			this.color=color;
			setStyle(0);
		}
		function setStyle(style:int)
		{
			graphics.clear();
			if(style==0){
				graphics.lineStyle(0,0x000000);
				graphics.beginFill(color);
			}
			else if(style==1){
				graphics.lineStyle(1,0x0099ff);
				graphics.beginFill(color);
			}
			graphics.moveTo(0,0);
			graphics.lineTo(0,ColorField.h);
			graphics.lineTo(ColorField.w,ColorField.h);
			graphics.lineTo(ColorField.w,0);
			graphics.lineTo(0,0);
			graphics.endFill();
		}
	}
}