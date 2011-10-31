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
        public function ColorSelector(option:Object)
		{
			super(option);
			
			option.selectedColor ||= 0;
			option.selectedColorAlpha ||= 1;
			
			selectedColor = option.selectedColor;
			selectedColorAlpha = option.selectedColorAlpha;
			
			colorWell = new ColorWell();
			comp.addChild(colorWell);
			
			componentFinish();
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
		protected override function mouseOver(e:MouseEvent)
		{
			super.mouseOver(e);
			if (e.buttonDown)
				return;
			colorWell.drawBorder(1);
		}
		protected override function mouseOut(e:MouseEvent)
		{
			super.mouseOut(e);
			colorWell.drawBorder(0);
		}
		public function set enabled(val:Boolean)
		{
			if (val == _enabled)
				return;
			setEnabled(val);
			if (val)
			{
				colorWell.drawColor(selectedColor, selectedColorAlpha);
				colorWell.addEventListener(MouseEvent.CLICK, openPanel);
			}
			else
			{
				colorWell.drawColor(0x666666, 1);
				colorWell.removeEventListener(MouseEvent.CLICK, openPanel);
			}
		}
    }
}