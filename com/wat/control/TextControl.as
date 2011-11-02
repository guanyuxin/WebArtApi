package com.wat.control
{
	import flash.display.Sprite;
	import flash.events.Event;
	import com.wat.ArtText;

	import flash.text.TextField;
	
	public class TextControl extends Sprite
	{
		var argEditers:Array=[];
		var target:ArtText;
		var renderText:Function;	
		
		var textValue:TextField;
		var textValueLable:TextField;
		public function TextControl(target:ArtText,renderText:Function)
		{
			this.target = target;
			this.renderText = renderText;
			
			textValue = new TextField();
			textValue.background = true;
			textValue.type = "input";
			textValue.border = true;
			textValue.height = textValue.textHeight + 2;
			textValue.width = 200;
			textValue.x = 10;
			textValue.y = 0;
			argEditers.push(textValue);
			
			argEditers = [textValue];
			
			textValue.text = target.text;
			for (var i = 0; i < argEditers.length; i++)
			{
				argEditers[i].addEventListener(Event.CHANGE, changeHandler);
				addChild(argEditers[i]);
			}
		}
		function changeHandler(e:Event)
		{
			target.text = textValue.text;
			renderText();
		}
	}
}