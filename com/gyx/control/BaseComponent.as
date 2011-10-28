package com.gyx.control
{
	import com.gyx.sytle.BaseStyle;
	import DefaultStyle;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class BaseComponent extends Sprite
	{
		protected var label:Label;
		protected var comp:Sprite;
		var style:BaseStyle;
		var _enabled:Boolean = true;
		var hover:Boolean = false;
		
		public function BaseComponent(option:Object)
		{
			style = option.style || DefaultStyle.componet
			if (option.label)
			{
				label = new Label(option.label);
				addChild(label);
			}
			comp = new Sprite();
			addChild(comp);
		}
		
		protected function componentFinish()
		{
			if (label)
			{
				comp.x = label.width;
				label.y = (comp.height - label.height) / 2;
			}
		}
		
		public function get lableWidth()
		{
			if (label != null)
				return label.width;
			return 0;
		}
		
		public function setEnabled(val:Boolean)
		{
			if (val == _enabled)
				return;
			if (label != null)
			{
				if (val)
				{
					comp.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
					comp.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
					label.setColor(style.getStyleUint("labelColor"));
				}
				else
				{
					comp.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
					comp.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
					label.setColor(style.getStyleUint("labelColor-disabled"));
				}
			}
			_enabled = val;
		}
		
		private function _mouseOver(e:MouseEvent)
		{
			if (!e.buttonDown)
			{
				this.mouseOver(e);
			}
		}
		
		private function _mouseOut(e:MouseEvent)
		{
			if (!e.buttonDown)
			{
				this.mouseOut(e);
			}
		}
		
		protected function mouseOver(e:MouseEvent)
		{
			hover = true;
			draw();
		}
		
		protected function mouseOut(e:MouseEvent)
		{
			hover = false;
			draw();
		}
		
		public function draw()
		{
		}
	}

}