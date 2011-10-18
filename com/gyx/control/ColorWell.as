package com.gyx.control
{
    import flash.display.Sprite;
    class ColorWell extends Sprite
    {
        var colorLayer:Sprite;
        static var w:int=30;
        static var h:int=20;
        public function ColorWell()
        {
            
            graphics.beginFill(0xffffff);
			graphics.drawRect(0,0,ColorWell.w,ColorWell.h);
            graphics.endFill();
            
            graphics.beginFill(0xbbbbbb);
			graphics.drawRect(0,0,ColorWell.w/3,ColorWell.h/2);
            graphics.endFill();
            
            graphics.beginFill(0xbbbbbb);
            graphics.drawRect(ColorWell.w/3,ColorWell.h/2,ColorWell.w/3,ColorWell.h/2);
            graphics.endFill();
            
            graphics.beginFill(0xbbbbbb);
            graphics.drawRect(2*ColorWell.w/3,0,ColorWell.w/3,ColorWell.h/2);
            graphics.endFill();
			
            graphics.lineStyle(1);
			graphics.drawRect(0,0,ColorWell.w,ColorWell.h);
			
            colorLayer=new Sprite();
            addChild(colorLayer)
        }
        public function drawColor(color:uint,alpha:Number=1)
        {
            colorLayer.graphics.clear();
            colorLayer.graphics.beginFill(color,alpha);
            colorLayer.graphics.drawRect(0,0,ColorWell.w,ColorWell.h);
            colorLayer.graphics.endFill();
			drawBorder(0);
        }
		public function drawBorder(type:int)
		{
			if(type==0)
				colorLayer.graphics.lineStyle(1);
			else if (type == 1)
				colorLayer.graphics.lineStyle(1,0x44aaff);
			colorLayer.graphics.drawRect(0,0,ColorWell.w,ColorWell.h);
		}
    }
}