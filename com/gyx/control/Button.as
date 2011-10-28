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
		public var selected:Boolean = false;
		public function Button(option:Object) 
		{
			super(option);
			option.enabled ||= true;
			option.selected ||= false;
			rect = new Sprite();
			addChild(rect);
			
			label.x = (w - label.width) / 2;
			label.y = (h - label.height) / 2;
			addChild(label);
			
			selected = option.selected;
			enabled = option.enabled;
		}
		public function set enabled(val)
		{
			if (val == _enabled)
				return;
			setEnabled(val);
			if (val)
			{
				rect.addEventListener(MouseEvent.CLICK, mouseClick);
			}
			else
			{
				rect.removeEventListener(MouseEvent.CLICK, mouseClick);
			}
			draw();
		}
		function mouseClick(e:Event)
		{
			selected = !selected;
			draw();
			dispatchEvent(new Event(Event.CHANGE));
		}
		public override function draw()
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