package com.gyx.control
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	import com.gyx.sytle.BaseStyle;
	import DefaultStyle;
	public class TabPage extends Sprite
	{
		var controll:Sprite;
		var tabName:String;
		var id:int;
		var callback:Function;
		var label:Label;
		var style:BaseStyle;
		var tabWidth:int;
		var tabHeight:int;
		var tabSlopeWidth:int;
		var corner:int;
		var pageWidth:int;
		var pageHeight:int;
		public function TabPage(id:int, tabName:String, controll:Sprite, callback:Function, styleArg:BaseStyle = null)
		{
			if (styleArg == null)
			{
				style=DefaultStyle.tabPage;
			}
			else
			{
				style = styleArg;
			}
			tabWidth=style.getStyleInt("tabWidth");
			tabHeight=style.getStyleInt("tabHeight");
			tabSlopeWidth=style.getStyleInt("tabSlopeWidth");
			corner=style.getStyleInt("corner");
			pageWidth=style.getStyleInt("pageWidth");
			pageHeight = style.getStyleInt("pageHeight");
			
			this.tabName = tabName;
			this.controll = controll;
			controll.y = tabHeight+5;
			this.id = id;
			this.callback = callback;
			this.addChild(controll);

			label = new Label(tabName);
			label.x = id * (tabWidth + tabSlopeWidth) + 10 + tabSlopeWidth + (tabWidth - label.width) / 2;
			label.y = (tabHeight - label.height) / 2;
			addChild(label);

			addEventListener(MouseEvent.MOUSE_DOWN,tabDown);

			this.filters = [new DropShadowFilter(0)];

			draw(false);
		}
		public function active()
		{
			draw(true);
		}
		public function deActive()
		{
			draw(false);
		}
		function tabDown(e:Event)
		{
			callback(this.id);
		}
		function draw(active:Boolean)
		{
			var y0:int = tabHeight;
			var y1:int = tabHeight - 2 * corner;
			var y2:int = 2 * corner;
			var y3:int = 0;
			
			var x0:int = 0;
			var x1:int = tabSlopeWidth;
			var x2:int = tabSlopeWidth + tabWidth;
			var x3:int = tabSlopeWidth * 2 + tabWidth;
			
			var x0m:int = x0 - corner * 3;
			var x0p:int = x0 + corner;
			
			var x1m:int = x1 - corner;
			var x1p:int = x1 + corner * 3;
			
			var x2m:int = x2 - corner * 3;
			var x2p:int = x2 + corner;
			
			var x3m:int = x3 - corner;
			var x3p:int = x3 + corner * 3;
			
			var currentX = id * (tabWidth+tabSlopeWidth) + 10;
			graphics.clear();
			graphics.lineStyle(1, 0x000000);
			if (active)
			{
				graphics.beginFill(style.getStyleUint("backgroundColor"));
				graphics.drawRect(0, tabHeight, pageWidth, pageHeight);
				graphics.endFill();
				graphics.beginFill(style.getStyleUint("backgroundColor"));
			}
			else
			{
				var matrix:Matrix = new Matrix();
				matrix.createGradientBox(1, tabHeight, Math.PI / 2, 0, 0);
				graphics.beginGradientFill(GradientType.LINEAR,[style.getStyleUint("backgroundColor-inactive"),style.getStyleUint("backgroundColor-inactive-shadow")],null,[0,255],matrix);
			}
			graphics.moveTo(currentX + x0m, y0);
			graphics.curveTo(currentX + x0, y0, currentX + x0p, y1);
			graphics.lineTo(currentX + x1m, y2);
			graphics.curveTo(currentX + x1,y3, currentX + x1p, y3);
			graphics.lineTo(currentX +x2m, y3);
			graphics.curveTo(currentX + x2, y3, currentX + x2p, y2);
			graphics.lineTo(currentX +x3m, y1);
			graphics.curveTo(currentX+x3, y0, currentX+x3p, y0);
			graphics.lineStyle(NaN);
			graphics.lineTo(currentX+x3p, y0+2);
			graphics.lineTo(currentX+x0m, y0+2);
			graphics.endFill();
		}
	}

}