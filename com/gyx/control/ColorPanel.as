package com.gyx.control
{
	import com.gyx.sytle.BaseStyle;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.filters.DropShadowFilter;
	import flash.display.DisplayObject;
	import com.gyx.layout.GirdLayout;
	import DefaultStyle;
    class ColorPanel extends Sprite
    {
        var col=10;
        var colors:Array=[0,3342336,6684672,10027008,13369344,16711680,16730441,16746889,16760767,16771561,1513239,3348480,6696960,10045440,13393920,16742400,16752457,16761225,16768447,16774121,3026478,3352576,6705152,10057728,13410304,16762880,16767049,16770697,16773823,16776169,4539717,3355392,6710784,10066176,13421568,16776960,16777033,16777097,16777151,16777193,6052956,2503424,5006848,7510272,10013696,12517120,13762377,14811017,15728575,16449513,7566195,13056,26112,39168,52224,65280,4849481,9043849,12582847,15335401,9145227,13107,26214,39321,52428,65535,4849663,9043967,12582911,15335423,10658466,6451,13158,19609,26316,33023,4826623,9028863,12574719,15332607,12171705,51,102,153,204,255,4803071,9013759,12566527,15329791,13684944,1638451,3342438,4980889,6684876,8388863,10832383,12880383,14663679,16050687,15198183,3342387,6684774,10027161,13369548,16711935,16730623,16747007,16760831,16771583,16777215,3342361,6684723,10027084,13369446,16711808,16730533,16746948,16760799,16771572]    
        public var selectedColor:uint;
		public var selectedColorAlpha:Number;
		var colorFields:Array=new Array();
        var colorTxt:TextField;
        var colorAlpha:NumberAdjuster;
        var colorWell:ColorWell;
		var colorSelectRect:Sprite;
		var colorFocusRect:Sprite;
		var rowCount:int;
		var head:GirdLayout, out:GirdLayout;
		var colorFarm:Sprite;
        public function ColorPanel(selectedColor:uint = 0x000000, selectedColorAlpha:Number = 1, rowCount:int = 10 )
        {
            
            this.selectedColor = selectedColor;
			this.selectedColorAlpha = selectedColorAlpha;
			
			head = new GirdLayout(1,DefaultStyle.noPaddingGird);
			out = new GirdLayout(2,DefaultStyle.girdCenter);
			colorFarm = new Sprite();
			
            colorWell=new ColorWell();
			colorWell.drawColor(selectedColor, selectedColorAlpha);
            head.addChild(colorWell);
            
            colorTxt=new TextField;
            colorTxt.x = 40;
			colorTxt.type = "input";
			colorTxt.restrict = "#0-9a-fA-F";
			colorTxt.maxChars = 7;
            colorTxt.background=true;
			colorTxt.border=true;
			var tf = colorTxt.getTextFormat();
			tf.font="SimSun"
			colorTxt.defaultTextFormat=tf;
            colorTxt.text = "#ffffff";
            colorTxt.width = 50;
			colorTxt.height = 20;
            head.addChild(colorTxt);
            
            colorAlpha=new NumberAdjuster({label:"透明度",value:Math.floor(selectedColorAlpha*100)});
            head.addChild(colorAlpha);
			out.addChild(head);
			out.addChild(colorFarm);
			
			for(var i:int=0;i<colors.length;i++)
            {
                colorFields[i]=new ColorField(colors[i]);
                colorFarm.addChild(colorFields[i]);
                colorFields[i].x=(i%rowCount)*(ColorField.w)+2;
                colorFields[i].y=int(i/rowCount)*(ColorField.h)+2;
            }
			colorFarm.graphics.lineStyle(1, 0);
			colorFarm.graphics.beginFill(0xffffff);
			colorFarm.graphics.drawRect(0, 0, colorFarm.width + 4, colorFarm.height + 4);
			colorFarm.graphics.endFill();
			
			colorSelectRect = new Sprite();
			colorFarm.addChild(colorSelectRect);
			colorSelectRect.graphics.lineStyle(2, 0xffffff);
			colorSelectRect.graphics.drawRect(-1, -1, ColorField.w+2, ColorField.h+2);
			colorSelectRect.graphics.lineStyle(1, 0x000000);
			colorSelectRect.graphics.drawRect(0, 0, ColorField.w, ColorField.h);
			colorFocusRect = new Sprite();
			colorFocusRect.graphics.lineStyle(1, 0xcceeff);
			colorFocusRect.graphics.drawRect(0, 0, ColorField.w, ColorField.h);
			colorFarm.addChild(colorFocusRect);
			
			out.render();
			addChild(out);
            drawBackground(out.width,out.height);
			
			addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			addEventListener(MouseEvent.MOUSE_DOWN, fieldMouseDown);
			colorAlpha.addEventListener(Event.CHANGE, alphaChange);
			colorTxt.addEventListener(FocusEvent.FOCUS_OUT, colorInput);
            colorFocusRect.visible = false;
            this.filters=[new DropShadowFilter(4,45,0,0.5)];
        }
        //all the following three methord is for hide this when mouse down elsewhere,maybe there is better solutions

		public function drawBackground(w,h)
        {
            graphics.lineStyle(1);
            graphics.beginFill(0xdddddd);
            graphics.drawRect(0,0,w,h);
            graphics.endFill();
        }

		function mouseOver(e:MouseEvent)
		{
			if (e.target is ColorField && !e.buttonDown)
			{
				colorTxt.text = formatColor(e.target.color);
				colorWell.drawColor(e.target.color, selectedColorAlpha);
				colorFocusRect.visible = true;
				colorFocusRect.x = e.target.x;
				colorFocusRect.y = e.target.y;
			}
		}
		function mouseOut(e:MouseEvent)
		{
			if (e.target is ColorField)
			{
				colorTxt.text = formatColor(selectedColor);
				colorWell.drawColor(selectedColor, selectedColorAlpha);
				colorFocusRect.visible = false;
			}
		}
		function fieldMouseDown(e:MouseEvent)
		{
			if (e.target is ColorField)
			{
				selectField(e.target as ColorField)
			}
		}
		function alphaChange(e:Event)
		{
			selectedColorAlpha = colorAlpha.value * 0.01;
			colorWell.drawColor(selectedColor , selectedColorAlpha);
			dispatchEvent(new ColorSelectorEvent(ColorSelectorEvent.ALPHA_CHANGE));
		}
		function colorInput(e:Event)
		{
			var str:String = colorTxt.text.substr(1);
			if(str.indexOf("#")>0) 
			{
				colorTxt.text = formatColor(selectedColor);
			}
			else
			{
				selectColor(parseInt(str,16));
			}
		}
		function selectField(colorField:ColorField)
		{
			selectedColor = colorField.color;
			colorTxt.text = formatColor(selectedColor);
			colorSelectRect.x = colorField.x;
			colorSelectRect.y = colorField.y;
			dispatchEvent(new ColorSelectorEvent(ColorSelectorEvent.COLOR_CHANGE));
		}
		function selectColor(color:uint)
		{
			var i = colors.indexOf(color);
			if (i < 0)
			{
				selectedColor = color;
				colorSelectRect.graphics.clear();
				dispatchEvent(new ColorSelectorEvent(ColorSelectorEvent.COLOR_CHANGE));
			}
			else {
				selectField(colorFields[i]);
			}
			colorWell.drawColor(selectedColor, selectedColorAlpha);
		}
		static function formatColor(color:uint):String
		{
			var colorCode:String = color.toString(16);
			while (colorCode.length < 6)
				colorCode = "0" + colorCode;
			colorCode = "#" + colorCode;
			return colorCode;
		}
    }
}