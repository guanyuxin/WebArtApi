package com.gyx.control 
{
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextLine;
	import flash.text.engine.TextElement;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	/**
	 * ...
	 * @author GYX
	 */
	public class ULabel extends Sprite
	{
		public function ULabel(str:String,font:String="SimSun",size:int=12)
		{
			var format:ElementFormat = new ElementFormat(new FontDescription(font));
			format.fontSize = size;
			var textEle:TextElement = new TextElement(str,format);
			var textBlock:TextBlock = new TextBlock();
			textBlock.content = textEle;
			var textLine:TextLine= textBlock.createTextLine();
			textLine.y = textLine.ascent;
			mouseEnabled = false;
			mouseChildren = false;
			addChild(textLine);
		}
		public function setColor(destColor)
		{
			var colorTransform:ColorTransform = new ColorTransform();
			colorTransform.color = destColor;
			transform.colorTransform = colorTransform;
		}
	}

}