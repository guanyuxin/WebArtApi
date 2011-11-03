package com.gyx.control
{
	import com.gyx.sytle.UStyle;
	import DefaultStyle;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class UComponent extends Sprite
	{
		protected var label:ULabel;
		protected var comp:Sprite;
		var style:UStyle;
		var _enabled:Boolean;
		var hover:Boolean = false;
		/**
		 * 
		 * @param	option style(UStyle):Default;	label(Lable):null
		 */
		public function UComponent(option:Object)
		{
			style = option.style || DefaultStyle.componet
			if (option.label)
			{
				label = new ULabel(option.label);
				addChild(label);
			}
			comp = new Sprite();
			addChild(comp);
		}
		
		protected function componentFinish()
		{
			if (!label)
				return
			comp.x = label.width;
			label.y = (comp.height - label.height) / 2;
		}
		
		public function get lableWidth()
		{
			return label?label.width:0;
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
		//to be overrided
		protected function mouseOver(e:MouseEvent)
		{
			hover = true;
			draw();
		}
		//to be overrided
		protected function mouseOut(e:MouseEvent)
		{
			hover = false;
			draw();
		}
		//to be overrided
		public function draw()
		{
		}
	}

}