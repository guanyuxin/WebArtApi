package com.gyx.control 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.filters.BevelFilter;
	import flash.display.Graphics;

	public class Button extends BaseComponent
	{
		var w=20;
		var h=20;
		var rect:Sprite;
		var hover:Boolean = false;
		public var selected:Boolean = false;
		var _enabled:Boolean = true;
		public function Button(labelStr:String) 
		{
			super(labelStr);
			
			rect = new Sprite();
			addChild(rect);
			
			label.x = (w - label.width) / 2;
			label.y = (h - label.height) / 2;
			addChild(label);
			
			enabled = true;
		}
		public function set enabled(arg)
		{
			if (arg)
			{
				_enabled = true;
				rect.addEventListener(MouseEvent.CLICK, mouseClick);
				rect.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
				rect.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			}
			else
			{
				_enabled = false;
				rect.removeEventListener(MouseEvent.CLICK, mouseClick);
				rect.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
				rect.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			}
			enableChange(_enabled);
			draw();
		}
		function mouseClick(e:Event)
		{
			selected = !selected;
			draw();
			dispatchEvent(new Event(Event.CHANGE));
		}
		function mouseOver(e:Event)
		{
			hover = true;
			draw();
		}
		function mouseOut(e:Event)
		{
			hover = false;
			draw();
		}
		public function draw()
		{
			var g:Graphics = rect.graphics;
			g.clear();
			if (_enabled)
			{
				if (!selected)
				{
					g.lineStyle(style.getStyleInt("borderWidth"), style.getStyleUint("borderColor"));
					g.beginFill(style.getStyleUint("backgroundColor"));
				}
				else
				{
					g.lineStyle(style.getStyleInt("borderWidth"), style.getStyleUint("borderColor-selected"));
					g.beginFill(style.getStyleUint("backgroundColor-selected"));
				}
			}
			else
			{
				g.lineStyle(style.getStyleInt("borderWidth"), style.getStyleUint("borderColor-disable"));
				g.beginFill(style.getStyleUint("backgroundColor-disabled"));
			}
			g.drawRect(0,0,w,h);
			g.endFill();
			if (hover)
			{
				g.lineStyle(style.getStyleInt("hoverboderWidth"),style.getStyleUint("hoverboderColor"));
				g.drawRect( -1, -1, w + 2, h + 2);
			}
		}
	}

}