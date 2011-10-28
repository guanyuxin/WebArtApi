package com.wat.control
{
	import com.wat.ArtText;
	import flash.filters.BevelFilter;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterType;
	import com.gyx.control.LinkButton;
	import com.gyx.control.NumberAdjuster;
	import com.gyx.control.ColorSelector;
	import com.gyx.control.CheckBox;
	import flash.text.TextField;
	import com.gyx.control.ComboBox;
	import com.gyx.layout.GirdLayout;
	import DefaultStyle;
	public class BevelControl extends Sprite
	{
		var argEditers:Array=new Array();
		var target:ArtText;
		var changeFilters:Function;
		var blurY:NumberAdjuster,blurX:NumberAdjuster,distance:NumberAdjuster,angle:NumberAdjuster,strangth:NumberAdjuster;
		var blurChain:LinkButton;
		var highlightColor:ColorSelector,shadowColor:ColorSelector;
		var knockout:CheckBox,enable:CheckBox;
		var filterType = [BitmapFilterType.INNER,BitmapFilterType.OUTER,BitmapFilterType.FULL];
		var quality:ComboBox, type:ComboBox;
		var layoutLeft:GirdLayout,layoutRight:GirdLayout,layoutOut:GirdLayout;
		public function BevelControl(target:ArtText,changeFilters:Function)
		{
			this.target = target;
			this.changeFilters = changeFilters;
			
			layoutLeft = new GirdLayout(2,DefaultStyle.noPaddingGird);
			layoutRight = new GirdLayout(2,DefaultStyle.noPaddingGird);
			layoutOut = new GirdLayout(1,DefaultStyle.gird);

			enable=new CheckBox({label:"启用"});
			layoutLeft.addChild(enable);

			quality=new ComboBox({label:"质量",data:["低","中","高"],tileWidth:30});
			layoutLeft.addChild(quality);
			argEditers.push(quality);

			type=new ComboBox({label:"位置",data:["内部","外部","全部"],tileWidth:40});
			layoutLeft.addChild(type);
			argEditers.push(type);

			knockout=new CheckBox({label:"挖空"});
			layoutLeft.addChild(knockout);
			argEditers.push(knockout);

			blurY = new NumberAdjuster({label:"模糊Y",value:20});
			layoutLeft.addChild(blurY);
			argEditers.push(blurY);

			blurX = new NumberAdjuster({label:"模糊X",value:20});
			layoutLeft.addChild(blurX);
			argEditers.push(blurX);
			
			layoutOut.addChild(layoutLeft);

			blurChain=new LinkButton({});
			layoutOut.addChild(blurChain);
			argEditers.push(blurChain);

			distance = new NumberAdjuster({label:"距离",value:20});
			layoutRight.addChild(distance);
			argEditers.push(distance);

			angle = new NumberAdjuster({label:"角度",value:45,maxValue:360});
			layoutRight.addChild(angle);
			argEditers.push(angle);
			
			shadowColor=new ColorSelector({label:"阴影色"});
			layoutRight.addChild(shadowColor);
			argEditers.push(shadowColor);
			
			highlightColor=new ColorSelector({label:"高光色",selectedColor:0xffffff});
			layoutRight.addChild(highlightColor);
			argEditers.push(highlightColor);
			strangth = new NumberAdjuster({label:"强度",value:10});
			layoutRight.addChild(strangth);
			argEditers.push(strangth);

			layoutOut.addChild(layoutRight);
			
			layoutOut.render();
			addChild(layoutOut);
			for (i=0; i<argEditers.length; i++)
			{
				argEditers[i].addEventListener(Event.CHANGE,changeHandler);
			}
			if (target.bevel == null)
			{
				for (var i = 0; i < argEditers.length; i++)
				{
					argEditers[i].enabled = false;
				}
			}
			else
			{
				enable.selected = true;
				if (target.bevel.type == filterType[0])
				{
					type.selectById(0);
				}
				else if (target.bevel.type == filterType[1])
				{
					type.selectById(1);
				}
				else if (target.bevel.type == filterType[2])
				{
					type.selectById(2);
				}
				knockout.selected = target.bevel.knockout;
				quality.selectById(target.bevel.quality-1);
				blurX.value = Math.floor(target.bevel.blurX*10);
				blurY.value = Math.floor(target.bevel.blurY*10);
				angle.value = target.bevel.angle;
				distance.value = Math.floor(target.bevel.distance*10);
				strangth.value = Math.floor(Math.sqrt(target.bevel.strength * 100));
				highlightColor.setColor(target.bevel.highlightColor,target.bevel.highlightAlpha);
				shadowColor.setColor(target.bevel.shadowColor,target.bevel.shadowAlpha);
			}
			enable.addEventListener(Event.CHANGE,changeHandler);
		}
		function changeHandler(e:Event)
		{
			if (e.currentTarget == enable)
			{
				for (var i = 0; i < argEditers.length; i++)
				{
					
					argEditers[i].enabled = e.target.selected;
				}
				if (e.target.selected == false)
				{
					changeFilters("bevel",null);
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
			var dropShadow:BevelFilter = new BevelFilter(
				distance.value*0.1,
				angle.value,
				highlightColor.selectedColor,
				highlightColor.selectedColorAlpha,
				shadowColor.selectedColor,
				shadowColor.selectedColorAlpha,
				blurX.value*0.1,
				blurY.value*0.1,
				strangth.value*strangth.value*0.01,
				quality.selectedIndex + 1,
				filterType[type.selectedIndex],
				knockout.selected);
			changeFilters("bevel",dropShadow);
		}
	}
}