package com.wat.control
{
	import com.gyx.layout.GirdLayout;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import com.wat.ArtText;
	import com.gyx.control.NumberAdjuster;
	import com.gyx.control.ColorSelector;
	import com.gyx.control.CheckBox;
	import com.gyx.layout.GirdLayout;
	import DefaultStyle;

	public class BorderControl extends Sprite
	{
		var target:ArtText;
		var changeFilters:Function;
		var strangth:NumberAdjuster;
		var enable,inner,knockout:CheckBox;
		var borderColor:ColorSelector;
		var argEditers:Array = [];
		var layoutOut:GirdLayout;
		public function BorderControl(target:ArtText,changeFilters:Function)
		{
			this.target = target;
			this.changeFilters = changeFilters;
			
			layoutOut = new GirdLayout(2, DefaultStyle.gird);

			enable=new CheckBox({label:"启用"});
			layoutOut.addChild(enable);
			
			inner=new CheckBox({label:"内边框"});
			layoutOut.addChild(inner);
			argEditers.push(inner);

			knockout=new CheckBox({label:"挖空"});
			layoutOut.addChild(knockout);
			argEditers.push(knockout);

			borderColor = new ColorSelector({label:"边框颜色",selectedColor:0xffffff});
			layoutOut.addChild(borderColor);
			argEditers.push(borderColor);

			strangth = new NumberAdjuster({label:"强度",value:20});
			layoutOut.addChild(strangth);
			argEditers.push(strangth);
			
			layoutOut.render();
			addChild(layoutOut);
			
			for (i=0; i<argEditers.length; i++)
			{
				argEditers[i].addEventListener(Event.CHANGE,changeHandler);
			}
			if (target.border == null)
			{
				for (var i=0; i<argEditers.length; i++)
				{
					argEditers[i].enabled = false;
				}
			}
			else
			{
				//init code
				enable.selected = true;
				inner.selected = target.border.inner;
				knockout.selected = target.border.knockout;
				borderColor.setColor(target.border.color,target.border.alpha);
				strangth.value = Math.floor(target.border.blurX * 10);
			}
			enable.addEventListener(Event.CHANGE,changeHandler);
		}
		function changeHandler(e:Event)
		{
			if (e && e.currentTarget == enable)
			{
				for (var i=0; i<argEditers.length; i++)
				{
					argEditers[i].enabled = e.currentTarget.selected;
				}
				if (e.currentTarget.selected == false)
				{
					changeFilters("border",null);
					return;
				}
			}
			var border:GlowFilter = new GlowFilter(
			borderColor.selectedColor,
			borderColor.selectedColorAlpha,
			strangth.value*0.1,
			strangth.value*0.1,
			strangth.value*10,
			1,
			inner.selected,
			knockout.selected
			);
			changeFilters("border",border);
		}
	}

}