package com.gyx.control
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class LinkButton extends BaseComponent
	{
		var button:CheckBox;
		public var selected:Boolean;
        var w:int;
		var h:int;
		var _enabled:Boolean;
		public function LinkButton(checked:Boolean=true,w:int=5,h:int=6)
		{
			super("");
			this.w = w;
			this.h = h;
			button = new CheckBox("");
			button.selected = checked;
			button.x = w;
			button.y = h;
            selected = true;
			button.draw();
			this.enabled=true;
			addChild(button);
		}
		public function setValue(selected:Boolean)
		{
			button.selected = selected;
			this.selected=selected;
			dispatchEvent(new Event(Event.CHANGE));
		}
		function buttonPressEvent(e:Event)
		{
			this.setValue(button.selected);
		}
		public function set enabled(enable:Boolean)
		{
			if (enable)
			{
				_enabled = true;
				button.enabled=true;
				button.addEventListener(Event.CHANGE,buttonPressEvent);
			}
			else
			{
				_enabled = false;
				button.enabled=false;
				button.removeEventListener(Event.CHANGE,buttonPressEvent);
			}
			draw();
		}
		public function draw()
		{
			var g:Graphics = graphics;
			g.clear();
			if (_enabled)
				g.lineStyle(style.getStyleInt("borderWidth"), style.getStyleUint("borderColor"));
			else
				g.lineStyle(style.getStyleInt("borderWidth"), style.getStyleUint("borderColor-disable"));
			g.moveTo(0,0);
			g.lineTo(button.width/2+w,0);
			g.lineTo(button.width/2+w,h);
			g.moveTo(0,button.height+h*2);
			g.lineTo(button.width/2+w,button.height+h*2);
			g.lineTo(button.width/2+w,button.height+h);
		}
	}

}