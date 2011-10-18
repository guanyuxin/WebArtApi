package com.wat.control
{
	import com.wat.ArtText;
	import flash.filters.GlowFilter;
	import flash.display.Sprite;
	import com.gyx.control.LinkButton;
	import com.gyx.control.NumberAdjuster;
	import com.gyx.control.ColorSelector;
	import com.gyx.control.CheckBox;
	import flash.text.TextField;
	import flash.events.Event;
	import com.gyx.control.ComboBox;
	import com.gyx.layout.GirdLayout;
	import DefaultStyle;
	public class GlowControl extends Sprite
	{
		var argEditers:Array=new Array();
		var target:ArtText;
		var changeFilters:Function;
		var blurY:NumberAdjuster,blurX:NumberAdjuster,strangth:NumberAdjuster;
		var blurChain:LinkButton;
		var shadowColor:ColorSelector;
		var knockout:CheckBox,enable:CheckBox,inner:CheckBox;
		var quality:ComboBox;
		var layoutLeft:GirdLayout,layoutRight:GirdLayout,layoutOut:GirdLayout;
		public function GlowControl(target:ArtText,changeFilters:Function)
		{
			this.target = target;
			this.changeFilters = changeFilters;

			layoutLeft = new GirdLayout(2,DefaultStyle.noPaddingGird);
			layoutRight = new GirdLayout(2,DefaultStyle.noPaddingGird);
			layoutOut = new GirdLayout(1,DefaultStyle.gird);
			
			enable=new CheckBox("启用");
			layoutLeft.addChild(enable);

			quality=new ComboBox("质量",["低","中","高"],3,0,30);
			layoutLeft.addChild(quality);
			argEditers.push(quality);

			inner=new CheckBox("内发光");
			layoutLeft.addChild(inner);
			argEditers.push(inner);

			knockout=new CheckBox("挖空");
			layoutLeft.addChild(knockout);
			argEditers.push(knockout);

			blurY = new NumberAdjuster("模糊Y",20,0,100);
			layoutLeft.addChild(blurY);
			argEditers.push(blurY);

			blurX = new NumberAdjuster("模糊X",20,0,100);
			layoutLeft.addChild(blurX);
			argEditers.push(blurX);
			
			layoutOut.addChild(layoutLeft)
			
			blurChain=new LinkButton();
			argEditers.push(blurChain);
			
			layoutOut.addChild(blurChain)

			strangth = new NumberAdjuster("强度",10,0,100);
			layoutRight.addChild(strangth);
			argEditers.push(strangth);

			shadowColor=new ColorSelector("发光色",0xff0000);
			layoutRight.addChild(shadowColor);
			argEditers.push(shadowColor);
			
			layoutOut.addChild(layoutRight)
			
			layoutOut.render();
			addChild(layoutOut);
			
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