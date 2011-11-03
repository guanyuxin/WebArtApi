package com.wat.control
{
	import com.wat.ArtText;
	import flash.filters.GlowFilter;
	import flash.display.Sprite;
	import com.gyx.control.ULinkButton;
	import com.gyx.control.UNumberAdjuster;
	import com.gyx.control.UColorPicker;
	import com.gyx.control.UCheckBox;
	import flash.text.TextField;
	import flash.events.Event;
	import com.gyx.control.UComboBox;
	import com.gyx.layout.UGirdLayout;
	import DefaultStyle;
	public class GlowControl extends Sprite
	{
		var argEditers:Array=new Array();
		var target:ArtText;
		var changeFilters:Function;
		var blurY:UNumberAdjuster,blurX:UNumberAdjuster,strangth:UNumberAdjuster;
		var blurChain:ULinkButton;
		var shadowColor:UColorPicker;
		var knockout:UCheckBox,enable:UCheckBox,inner:UCheckBox;
		var quality:UComboBox;
		var layoutLeft:UGirdLayout,layoutRight:UGirdLayout,layoutOut:UGirdLayout;
		public function GlowControl(target:ArtText,changeFilters:Function)
		{
			this.target = target;
			this.changeFilters = changeFilters;

			layoutLeft = new UGirdLayout(2,DefaultStyle.noPaddingGird);
			layoutRight = new UGirdLayout(2,DefaultStyle.noPaddingGird);
			layoutOut = new UGirdLayout(1,DefaultStyle.gird);
			
			enable=new UCheckBox({label:"启用"});
			layoutLeft.addChild(enable);

			quality=new UComboBox({label:"质量",data:["低","中","高"],tileWidth:30});
			layoutLeft.addChild(quality);
			argEditers.push(quality);

			inner=new UCheckBox({label:"内阴影"});
			layoutLeft.addChild(inner);
			argEditers.push(inner);

			knockout=new UCheckBox({label:"挖空"});
			layoutLeft.addChild(knockout);
			argEditers.push(knockout);

			blurY = new UNumberAdjuster({label:"模糊Y",value:20});
			layoutLeft.addChild(blurY);
			argEditers.push(blurY);

			blurX = new UNumberAdjuster({label:"模糊X",value:20});
			layoutLeft.addChild(blurX);
			argEditers.push(blurX);
			
			layoutOut.addChild(layoutLeft);

			blurChain=new ULinkButton({});
			layoutOut.addChild(blurChain);
			argEditers.push(blurChain);
			
			shadowColor=new UColorPicker({label:"发光色"});
			layoutRight.addChild(shadowColor);
			argEditers.push(shadowColor);
			
			strangth = new UNumberAdjuster({label:"强度",value:10});
			layoutRight.addChild(strangth);
			argEditers.push(strangth);
			
			layoutOut.addChild(layoutRight);
			
			layoutOut.render();
			addChild(layoutOut)
			
			for (i=0; i<argEditers.length; i++)
			{
				argEditers[i].addEventListener(Event.CHANGE,changeHandler);
			}
			if (target.shadow == null)
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
				knockout.selected = target.glow.knockout;
				inner.selected = target.glow.inner;
				quality.selectById(target.glow.quality + 1);
				blurX.value = Math.floor(target.glow.blurX*10);
				blurY.value = Math.floor(target.glow.blurY*10);
				strangth.value = Math.floor(Math.sqrt(target.glow.strength * 100));
				shadowColor.setColor(target.glow.color,target.glow.alpha);
			}
			enable.addEventListener(Event.CHANGE,changeHandler);
		}
		function changeHandler(e:Event)
		{
			if (e.currentTarget == enable)
			{
				for (var i=0; i<argEditers.length; i++)
				{
					argEditers[i].enabled = e.target.selected;
				}
				if (e.target.selected == false)
				{
					changeFilters("glow",null);
					return;
				}
			}
			else if (blurChain.selected && e.currentTarget==blurX && blurY.value!=blurX.value)
			{
				blurY.setValue(blurX.value);
			}
			else if (blurChain.selected && e.currentTarget==blurY && blurY.value!=blurX.value)
			{
				blurX.setValue(blurY.value);
			}
			var glow:GlowFilter = new GlowFilter(
			shadowColor.selectedColor,
			shadowColor.selectedColorAlpha,
			blurX.value*0.1,
			blurY.value*0.1,
			strangth.value*strangth.value*0.01,
			quality.selectedIndex+1,
			inner.selected,
			knockout.selected
			);
			changeFilters("glow",glow);
		}
	}
}