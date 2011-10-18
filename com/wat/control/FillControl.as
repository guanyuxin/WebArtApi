package com.wat.control
{
	import com.gyx.control.ListLabel;
	import com.wat.ArtText;
	import com.gyx.control.GradientControl;
	import com.gyx.control.NumberAdjuster;
	import com.gyx.control.ColorSelector;
	import com.gyx.control.ComboBox;
	import com.gyx.control.Button;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.text.TextFormat;
	import com.gyx.layout.GirdLayout;
	import DefaultStyle;
	
	public class FillControl extends Sprite
	{
		var gradientControl:GradientControl;
		var simpleColorPicker:ColorSelector;
		var typeSelect:ComboBox,textFont:ComboBox;
		var target:ArtText;
		var textSize:NumberAdjuster,textSpacing:NumberAdjuster;
		var renderText:Function;
		var italic:Button,bold:Button;
		var fontData:Array = [{label:"宋体",data:"SimSun"},{label:"黑体",data:"SimHei"},{label:"华文细黑",data:"STXihei"},{label:"楷体",data:"KaiTi"},{label:"隶书",data:"LiSu"},{label:"华文行楷",data:"STXingkai"},{label:"幼圆",data:"YouYuan"},{label:"方正舒体",data:"FZShuTi"},{label:"方正姚体",data:"FZYaoti"},{label:"华文琥珀",data:"STHupo"},{label:"华文彩云",data:"STCaiyun"},{label:"Arial",data:"Arial"},{label:"Comic Sans MS",data:"Comic Sans MS"},{label:"Georgia",data:"Georgia"},{label:"Impact",data:"Impact"},{label:"Verdana",data:"Verdana"},{label:"Time News Roman",data:"Time News Roman"},{label:"Courier New",data:"Courier New"},{label:"Hei",data:"Hei"},{label:"Monaco",data:"Monaco"},{label:"simhei",data:"simhei"}];
		var argEditers:Array=[];
		var layoutUp:GirdLayout,layoutDown:GirdLayout,layoutOut:GirdLayout;
		public function FillControl(target:ArtText,renderText:Function)
		{
			this.target = target;
			this.renderText = renderText;
			
			layoutUp = new GirdLayout(1,DefaultStyle.noPaddingGird);
			layoutDown = new GirdLayout(1,DefaultStyle.noPaddingGird);
			layoutOut = new GirdLayout(2,DefaultStyle.gird);
			
			typeSelect=new ComboBox("填充方式",["单色填充","渐变填充"],2,0,55);
			layoutUp.addChild(typeSelect);
			argEditers.push(typeSelect);
			
			textFont=new ComboBox("字体",createFontPreview,fontData.length,0,100);
			layoutDown.addChild(textFont);
			argEditers.push(textFont);
			
			italic=new Button("I");
			layoutDown.addChild(italic);
			argEditers.push(italic);
			
			bold=new Button("B");
			layoutDown.addChild(bold);
			argEditers.push(bold);
			
			textSize = new NumberAdjuster("字号",32);
			layoutDown.addChild(textSize);
			argEditers.push(textSize);
			
			textSpacing = new NumberAdjuster("间距",0,0,20);
			layoutDown.addChild(textSpacing);
			argEditers.push(textSpacing);
			
			gradientControl = new GradientControl(target.fillGradientColor,target.fillGradientRatios);
			layoutUp.addChild(gradientControl);
			argEditers.push(gradientControl);
			
			simpleColorPicker=new ColorSelector("填充色");
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
			for (var i=0; i<fontData.length; i++)
			{
				if (fontData[i].data == target.font)
				{
					textFont.selectById(i);
					break;
				}
			}
			
			layoutOut.render();
			addChild(layoutOut);
			for (i=0; i<argEditers.length; i++)
			{
				argEditers[i].addEventListener(Event.CHANGE,changeHandler);
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
		function createFontPreview(i:int,s:ListLabel)
		{
			if(i>=fontData.length)
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
