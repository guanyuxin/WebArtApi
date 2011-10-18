package com.gyx.control 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;

	public class CheckBox extends BaseComponent
	{
		var rect:Sprite;
		var w:int = 15;
		var h:int = 15;
		var hover:Boolean = false;
		public var selected:Boolean = false;
		var _enabled:Boolean = true;
		public function CheckBox(labelStr:String) 
		{
			super(labelStr);
			rect = new Sprite();
			addChild(rect);
			if (label)
				rect.x = label.width;
			enabled = true;
			if(label)
				label.y = (rect.height - label.height) / 2;
		}
		public function set enabled(arg)
		{
			enableChange(arg);
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
				g.lineStyle(style.getStyleInt("borderWidth"), style.getStyleUint("borderColor"));
			else
			{
				g.lineStyle(style.getStyleInt("borderWidth"), style.getStyleUint("borderColor-disable"));
			}
			g.beginFill(0, 0);
			g.drawRect(0, 0, w, h);
			g.endFill();
			if (selected)
			{
				g.moveTo(0, 0);
				g.lineTo(w, h);
				g.moveTo(w, 0);
				g.lineTo(0, h);
			}
			if (hover)
			{
				g.lineStyle(style.getStyleInt("hoverboderWidth"),style.getStyleUint("hoverboderColor"));
				g.drawRect( -1, -1, w + 2, h + 2);
			}
		}
	}

}