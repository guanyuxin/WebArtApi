package com.wat.control
{
	import com.wat.ArtText;
	import flash.filters.BevelFilter;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterType;
	import com.gyx.control.ULinkButton;
	import com.gyx.control.UNumberAdjuster;
	import com.gyx.control.UColorPicker;
	import com.gyx.control.UCheckBox;
	import flash.text.TextField;
	import com.gyx.control.UComboBox;
	import com.gyx.layout.UGirdLayout;
	import DefaultStyle;
	public class BevelControl extends Sprite
	{
		var argEditers:Array=new Array();
		var target:ArtText;
		var changeFilters:Function;
		var blurY:UNumberAdjuster,blurX:UNumberAdjuster,distance:UNumberAdjuster,angle:UNumberAdjuster,strangth:UNumberAdjuster;
		var blurChain:ULinkButton;
		var highlightColor:UColorPicker,shadowColor:UColorPicker;
		var knockout:UCheckBox,enable:UCheckBox;
		var filterType = [BitmapFilterType.INNER,BitmapFilterType.OUTER,BitmapFilterType.FULL];
		var quality:UComboBox, type:UComboBox;
		var layoutLeft:UGirdLayout,layoutRight:UGirdLayout,layoutOut:UGirdLayout;
		public function BevelControl(target:ArtText,changeFilters:Function)
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

			type=new UComboBox({label:"位置",data:["内部","外部","全部"],tileWidth:40});
			layoutLeft.addChild(type);
			argEditers.push(type);

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

			distance = new UNumberAdjuster({label:"距离",value:20});
			layoutRight.addChild(distance);
			argEditers.push(distance);

			angle = new UNumberAdjuster({label:"角度",value:45,maxValue:360});
			layoutRight.addChild(angle);
			argEditers.push(angle);
			
			shadowColor=new UColorPicker({label:"阴影色"});
			layoutRight.addChild(shadowColor);
			argEditers.push(shadowColor);
			
			highlightColor=new UColorPicker({label:"高光色",selectedColor:0xffffff});
			layoutRight.addChild(highlightColor);
			argEditers.push(highlightColor);
			strangth = new UNumberAdjuster({label:"强度",value:10});
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