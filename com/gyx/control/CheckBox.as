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
		public var selected:Boolean;
		public function CheckBox(option:Object) 
		{
			super(option);
			option.enabled ||= true; 
			option.selected ||= false;
			rect = new Sprite();
			comp.addChild(rect);
			componentFinish();
			selected = option.selected
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
				g.lineStyle(style.getStyleInt("borderWidth"), style.getStyleUint("borderColor"));
			else
			{
				g.lineStyle(style.getStyleInt("borderWidth"), style.getStyleUint("borderColor-disabled"));
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