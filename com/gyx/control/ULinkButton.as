package com.gyx.control
{
	import flash.display.Graphics;
	import flash.events.Event;
	
	public class ULinkButton extends UComponent
	{
		var button:UCheckBox;
		public var selected:Boolean;
		var w:int;
		var h:int;
		
		/**
		 * @param checked
		 * Boolean=truedfdf
		 */
		public function ULinkButton(option:Object)
		{
			super(option);
			
			option.checked ||= true;
			option.enabled ||= true;
			option.w ||= 5;
			option.h ||= 6;
			
			this.w = option.w;
			this.h = option.h;
			button = new UCheckBox({selected:option.checked,enabled:option.enabled});
			button.x = this.w;
			button.y = this.h;
			addChild(button);
			selected = option.checked;
			this.enabled = option.enabled;
			button.draw();
		}
		
		public function setValue(selected:Boolean)
		{
			button.selected = selected;
			this.selected = selected;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		function buttonPressEvent(e:Event)
		{
			this.setValue(button.selected);
		}
		
		public function set enabled(val:Boolean)
		{
			if (val == _enabled)
				return;
			setEnabled(val);
			if (val)
			{
				button.enabled = true;
				button.addEventListener(Event.CHANGE, buttonPressEvent);
			}
			else
			{
				button.enabled = false;
				button.removeEventListener(Event.CHANGE, buttonPressEvent);
			}
			draw();
		}
		
		public override function draw()
		{
			var g:Graphics = graphics;
			g.clear();
			if (_enabled)
				g.lineStyle(style.getStyleInt("borderWidth"), style.getStyleUint("borderColor"));
			else
				g.lineStyle(style.getStyleInt("borderWidth"), style.getStyleUint("borderColor-disabled"));
			g.moveTo(0, 0);
			g.lineTo(button.width / 2 + w, 0);
			g.lineTo(button.width / 2 + w, h);
			g.moveTo(0, button.height + h * 2);
			g.lineTo(button.width / 2 + w, button.height + h * 2);
			g.lineTo(button.width / 2 + w, button.height + h);
		}
	}

}