package com.wat.control
{
	import com.wat.ArtText;

	import flash.filters.DropShadowFilter;
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
	public class ShadowControl extends Sprite
	{
		var argEditers:Array=new Array();
		var target:ArtText;
		var changeFilters:Function;
		var blurY:NumberAdjuster,blurX:NumberAdjuster,distance:NumberAdjuster,angle:NumberAdjuster,strangth:NumberAdjuster;
		var blurChain:LinkButton;
		var shadowColor:ColorSelector;
		var knockout:CheckBox,enable:CheckBox,inner:CheckBox;
		var quality:ComboBox;
		var layoutLeft:GirdLayout,layoutRight:GirdLayout,layoutOut:GirdLayout;
		public function ShadowControl(target:ArtText,changeFilters:Function)
		{
			this.target = target;
			this.changeFilters = changeFilters;

			layoutLeft = new GirdLayout(2,DefaultStyle.noPaddingGird);
			layoutRight = new GirdLayout(2,DefaultStyle.noPaddingGird);
			layoutOut = new GirdLayout(1,DefaultStyle.gird);
			
			enable=new CheckBox("启用");
			layoutLeft.addChild(enable);

			quality=new ComboBox("质量",["低","中","高"],3,0,30);
			argEditers.push(quality);
			layoutLeft.addChild(quality);

			inner=new CheckBox("内阴影");
			argEditers.push(inner);
			layoutLeft.addChild(inner);

			knockout=new CheckBox("挖空");
			argEditers.push(knockout);
			layoutLeft.addChild(knockout);

			blurY = new NumberAdjuster("模糊Y",20,0,100);
			argEditers.push(blurY);
			layoutLeft.addChild(blurY);

			blurX = new NumberAdjuster("模糊X",20,0,100);
			argEditers.push(blurX);
			layoutLeft.addChild(blurX);
			
			layoutOut.addChild(layoutLeft)
			
			blurChain=new LinkButton();
			argEditers.push(blurChain);
			layoutOut.addChild(blurChain)

			distance = new NumberAdjuster("距离",20,0,100);
			argEditers.push(distance);
			layoutRight.addChild(distance);

			angle = new NumberAdjuster("角度",45,0,360);
			argEditers.push(angle);
			layoutRight.addChild(angle);

			strangth = new NumberAdjuster("强度",10,0,100);
			argEditers.push(strangth);
			layoutRight.addChild(strangth);

			shadowColor=new ColorSelector("阴影色");
			argEditers.push(shadowColor);
			layoutRight.addChild(shadowColor);
			
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
				knockout.selected = target.shadow.knockout;
				inner.selected = target.shadow.inner;
				quality.selectById(target.glow.quality + 1);
				blurX.value = Math.floor(target.shadow.blurX*10);
				blurY.value = Math.floor(target.shadow.blurY*10);
				angle.value = target.shadow.angle;
				distance.value =  Math.floor(target.shadow.distance*10);
				strangth.value = Math.floor(Math.sqrt(target.shadow.strength * 100));
				shadowColor.setColor(target.shadow.color,target.shadow.alpha);
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
					changeFilters("shadow",null);
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
			var dropShadow:DropShadowFilter = new DropShadowFilter(
			distance.value*0.1,
			angle.value,
			shadowColor.selectedColor,
			shadowColor.selectedColorAlpha,
			blurX.value*0.1,
			blurY.value*0.1,
			strangth.value*strangth.value*0.01,
			quality.selectedIndex+1,
			inner.selected,
			knockout.selected
			);
			changeFilters("shadow",dropShadow);
		}
	}
}