package com.gyx.control 
{
	import com.gyx.sytle.BaseStyle;
	import flash.display.Sprite;
	import DefaultStyle;
	public class BaseComponent extends Sprite
	{
		protected var label:Label;
		var style:BaseStyle;
		public function BaseComponent(labelTxt:String,style:BaseStyle=null)
		{
			if(style==null)
				style=DefaultStyle.componet
			this.style = style;
			if (labelTxt == "")
				return;
			label = new Label(labelTxt);
			addChild(label);
		}
		public function get lableWidth()
		{
			if (label != null)
				return label.width;
			return 0;
		}
		public function enableChange(val:Boolean)
		{
			if (label != null)
			{
				if(val)
					label.setColor(style.getStyleUint("labelColor"));
				else
					label.setColor(style.getStyleUint("labelColor-disable"));
			}
		}
	}

}