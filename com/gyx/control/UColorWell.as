package com.gyx.control
{
	import com.gyx.sytle.UStyle;
    import flash.display.Sprite;
    class UColorWell extends Sprite
    {
        var colorLayer:Sprite;
		var style:UStyle;
        static var w:int=30;
        static var h:int=20;
        public function UColorWell(style=null)
        {
            this.style = style || DefaultStyle.common;
            graphics.beginFill(0xffffff);
			graphics.drawRect(0,0,UColorWell.w,UColorWell.h);
            graphics.endFill();
            
            graphics.beginFill(0xbbbbbb);
			graphics.drawRect(0,0,UColorWell.w/3,UColorWell.h/2);
            graphics.endFill();
            
            graphics.beginFill(0xbbbbbb);
            graphics.drawRect(UColorWell.w/3,UColorWell.h/2,UColorWell.w/3,UColorWell.h/2);
            graphics.endFill();
            
            graphics.beginFill(0xbbbbbb);
            graphics.drawRect(2*UColorWell.w/3,0,UColorWell.w/3,UColorWell.h/2);
            graphics.endFill();
			
            graphics.lineStyle(1);
			graphics.drawRect(0,0,UColorWell.w,UColorWell.h);
			
            colorLayer=new Sprite();
            addChild(colorLayer)
        }
        public function drawColor(color:uint,alpha:Number=1)
        {
            colorLayer.graphics.clear();
            colorLayer.graphics.beginFill(color,alpha);
            colorLayer.graphics.drawRect(0,0,UColorWell.w,UColorWell.h);
            colorLayer.graphics.endFill();
			drawBorder(0);
        }
		public function drawBorder(type:int)
		{
			if(type==0)
				colorLayer.graphics.lineStyle(1);
			else if (type == 1)
				colorLayer.graphics.lineStyle(1,0x44aaff);
			colorLayer.graphics.drawRect(0,0,UColorWell.w,UColorWell.h);
		}
    }
}