package com.wat.control
{
	import com.gyx.control.UButton;
	import com.gyx.control.UColorPicker;
	import com.gyx.control.UComboBox;
	import com.gyx.control.UGradientController;
	import com.gyx.control.UListItem;
	import com.gyx.control.UNumberAdjuster;
	import com.gyx.layout.UGirdLayout;
	import com.wat.ArtText;
	import DefaultStyle;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class FillControl extends Sprite
	{
		var gradientControl:UGradientController;
		var simpleColorPicker:UColorPicker;
		var typeSelect:UComboBox, textFont:UComboBox;
		var target:ArtText;
		var textSize:UNumberAdjuster, textSpacing:UNumberAdjuster;
		var renderText:Function;
		var italic:UButton, bold:UButton;
		var fontData:Array = [{label: "宋体", data: "SimSun"}, {label: "黑体", data: "SimHei"}, {label: "华文细黑", data: "STXihei"}, {label: "楷体", data: "KaiTi"}, {label: "隶书", data: "LiSu"}, {label: "华文行楷", data: "STXingkai"}, {label: "幼圆", data: "YouYuan"}, {label: "方正舒体", data: "FZShuTi"}, {label: "方正姚体", data: "FZYaoti"}, {label: "华文琥珀", data: "STHupo"}, {label: "华文彩云", data: "STCaiyun"}, {label: "Arial", data: "Arial"}, {label: "Comic Sans MS", data: "Comic Sans MS"}, {label: "Georgia", data: "Georgia"}, {label: "Impact", data: "Impact"}, {label: "Verdana", data: "Verdana"}, {label: "Time News Roman", data: "Time News Roman"}, {label: "Courier New", data: "Courier New"}, {label: "Hei", data: "Hei"}, {label: "Monaco", data: "Monaco"}, {label: "simhei", data: "simhei"}];
		var argEditers:Array = [];
		var layoutUp:UGirdLayout, layoutDown:UGirdLayout, layoutOut:UGirdLayout;
		
		public function FillControl(target:ArtText, renderText:Function)
		{
			this.target = target;
			this.renderText = renderText;
			
			layoutUp = new UGirdLayout(1, DefaultStyle.noPaddingGird);
			layoutDown = new UGirdLayout(1, DefaultStyle.noPaddingGird);
			layoutOut = new UGirdLayout(2, DefaultStyle.gird);
			
			typeSelect = new UComboBox({label:"填充方式",data:["单色填充", "渐变填充"]});
			layoutUp.addChild(typeSelect);
			argEditers.push(typeSelect);
			
			textFont = new UComboBox({label:"字体", render:createFontPreview, data:fontData,tileWidth:100});
			layoutDown.addChild(textFont);
			argEditers.push(textFont);
			
			italic = new UButton({label:"I"});
			layoutDown.addChild(italic);
			argEditers.push(italic);
			
			bold = new UButton({label:"B"});
			layoutDown.addChild(bold);
			argEditers.push(bold);
			
			textSize = new UNumberAdjuster({label:"字号", value:20,minValue:12});
			layoutDown.addChild(textSize);
			argEditers.push(textSize);
			
			textSpacing = new UNumberAdjuster({label:"间距",maxValue:20});
			layoutDown.addChild(textSpacing);
			argEditers.push(textSpacing);
			
			gradientControl = new UGradientController(target.fillGradientColor, target.fillGradientRatios);
			layoutUp.addChild(gradientControl);
			argEditers.push(gradientControl);
			
			simpleColorPicker = new UColorPicker({label:"填充色"});
			layoutUp.addChild(simpleColorPicker);
			argEditers.push(simpleColorPicker);
			
			layoutOut.addChild(layoutUp);
			layoutOut.addChild(layoutDown);
			
			textSize.value = target.size;
			textSpacing.value = target.spacing;
			typeSelect.selectById(target.fillType);
			bold.selected = target.bold;
			italic.selected = target.italic;
			simpleColorPicker.setColor(target.color);
			if (target.fillType == 0)
			{
				simpleColorPicker.visible = true;
				gradientControl.visible = false;
			}
			else
			{
				simpleColorPicker.visible = false;
				gradientControl.visible = true;
			}
			for (var i = 0; i < fontData.length; i++)
			{
				if (fontData[i].data == target.font)
				{
					textFont.selectById(i);
					break;
				}
			}
			
			layoutOut.render();
			addChild(layoutOut);
			for (i = 0; i < argEditers.length; i++)
			{
				argEditers[i].addEventListener(Event.CHANGE, changeHandler);
			}
		}
		
		function changeHandler(e:Event)
		{
			if (e.target == typeSelect)
			{
				if (e.currentTarget.selectedIndex == 0)
				{
					simpleColorPicker.visible = true;
					gradientControl.visible = false;
				}
				else
				{
					simpleColorPicker.visible = false;
					gradientControl.visible = true;
				}
				layoutOut.render();
			}
			target.fillType = typeSelect.selectedIndex;
			target.color = simpleColorPicker.selectedColor;
			target.fillGradientColor = gradientControl.colorArray;
			target.fillGradientRatios = gradientControl.ratioArray;
			target.bold = bold.selected;
			target.italic = italic.selected;
			target.font = fontData[textFont.selectedIndex]["data"];
			target.size = textSize.value;
			target.spacing = textSpacing.value;
			
			renderText();
		}
		
		function createFontPreview(i:int, s:UListItem)
		{
			if (i >= fontData.length)
				return null;
			var font:String = fontData[i]["label"];
			var fontValue:String = fontData[i]["data"];
			var preview:TextField = new TextField();
			var tf:TextFormat = preview.defaultTextFormat;
			tf.font = fontValue;
			preview.defaultTextFormat = tf;
			preview.text = font;
			preview.width = s.w
			preview.height = s.h;
			s.front.addChild(preview);
		}
	}

}
