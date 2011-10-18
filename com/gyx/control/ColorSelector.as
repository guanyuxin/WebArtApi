package com.gyx.control
{
	import com.gyx.control.ColorPanel;
	import com.gyx.control.ColorWell;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
    public class ColorSelector extends BaseComponent
    {
        var colorPanel:ColorPanel;
		var colorWell:ColorWell;
		var panel:ColorPanel;
		public var selectedColor:uint;
		public var selectedColorAlpha:Number;
        public function ColorSelector(labelStr:String="",selectedColor:uint=0,selectedColorAlpha:Number=1)
		{
			super(labelStr);
			this.selectedColor = selectedColor;
			this.selectedColorAlpha = selectedColorAlpha;
			
			colorWell = new ColorWell();
			addChild(colorWell);
			
			if (label){
				colorWell.x = label.width;
				label.y = (colorWell.height - label.height) / 2;
			}
			
			enabled = true;
			
			panel = new ColorPanel(selectedColor,selectedColorAlpha);
			panel.addEventListener(ColorSelectorEvent.COLOR_CHANGE, colorChange);
            panel.addEventListener(ColorSelectorEvent.ALPHA_CHANGE, colorChange);
            panel.addEventListener(ColorSelectorEvent.COLOR_CHANGE, closePanel);
			panel.addEventListener(NumberAdjusterEvent.ADJUST_OVER, closePanel);
		}
		function colorChange(e:ColorSelectorEvent)
		{
			setColor(panel.selectedColor, panel.selectedColorAlpha);
			dispatchEvent(new Event(Event.CHANGE));
		}
		public function setColor(newColor:uint, newAlpha:Number = 1)
		{
			selectedColor = newColor;
			selectedColorAlpha = newAlpha;
			colorWell.drawColor(selectedColor,selectedColorAlpha);
		}
		function openPanel(e:Event)
		{
			var location = new Point();
			location=this.localToGlobal(location);
			panel.x = location.x;
			panel.y = location.y;
            (stage.getChildByName("controlLayer") as Sprite).addChild(panel);
            stage.addEventListener(MouseEvent.MOUSE_DOWN,closePanel);
		}
        function closePanel(e:Event)
        {
            if(!(e is MouseEvent) || !panel.contains(e.target as DisplayObject) && !this.contains(e.target as DisplayObject))
            {
                panel.parent.removeChild(panel);
                stage.removeEventListener(MouseEvent.MOUSE_DOWN,closePanel);
            }
        }
		function mouseOver(e:MouseEvent)
		{
			if (e.buttonDown)
				return;
			colorWell.drawBorder(1);
		}
		function mouseOut(e:MouseEvent)
		{
			colorWell.drawBorder(0);
		}
		public function set enabled(arg:Boolean)
		{
			enableChange(arg);
			if (arg)
			{
				colorWell.drawColor(selectedColor, selectedColorAlpha);
				colorWell.addEventListener(MouseEvent.CLICK, openPanel);
				colorWell.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
				colorWell.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			}
			else
			{
				colorWell.drawColor(0x666666, 1);
				colorWell.removeEventListener(MouseEvent.CLICK, openPanel);
				colorWell.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
				colorWell.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			}
		}
    }
}