package com.gyx.control
{
	import flash.display.Sprite;
	import flash.events.MouseEvent
	import flash.events.Event;
	public class  Scroll extends Sprite
	{
		var scrollBarHeight:int;
		var scrollBar:Sprite;
		var barWidth:int = 10;
		public var value:int = 0;
		var maxHeigth:int;
		var windowHeight:int;
		var mouseDownY:int;
		var baseY:int;
		var mouseWheelCaptureObject:Sprite;
		public function Scroll(mouseWheelCaptureObject:Sprite,maxHeigth:int,windowHeight:int)
		{
			this.mouseWheelCaptureObject = mouseWheelCaptureObject;
			this.maxHeigth = maxHeigth;
			this.windowHeight = windowHeight;
			scrollBarHeight = Math.floor(windowHeight * windowHeight / maxHeigth);
			scrollBar = new Sprite();
			
			scrollBar.graphics.lineStyle(1);
			scrollBar.graphics.beginFill(0xcccccc);
			scrollBar.graphics.drawRect(0,0,barWidth,scrollBarHeight);
			scrollBar.graphics.endFill();
			
			addChild(scrollBar);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			
			graphics.lineStyle(1);
			graphics.beginFill(0x777777);
			graphics.drawRect(0,0,barWidth,windowHeight);
			graphics.endFill();
			
			mouseWheelCaptureObject.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWhell);
		}
		function mouseDown(e:MouseEvent)
		{
			if(e.target!=scrollBar){
				setH(mouseY-scrollBarHeight/2);
			}
			mouseDownY = this.mouseY;
			baseY = scrollBar.y;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			
		}
		function mouseUp(e:MouseEvent)
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		function mouseMove(e:MouseEvent)
		{
			setH(baseY + this.mouseY - mouseDownY);
		}
		function mouseWhell(e:MouseEvent)
		{
			setH(-e.delta + scrollBar.y);
		}
		function setH(newHeight:int)
		{
			if (newHeight < 0)
				newHeight = 0;
			if (newHeight + scrollBarHeight > windowHeight)
				newHeight = windowHeight - scrollBarHeight;
			if (newHeight != scrollBar.y)
			{
				scrollBar.y = newHeight;
				var newValue = Math.floor(newHeight * maxHeigth / windowHeight);
				if (newValue > maxHeigth - windowHeight)
					newValue = maxHeigth - windowHeight;
				value = newValue;
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
	}
	
}