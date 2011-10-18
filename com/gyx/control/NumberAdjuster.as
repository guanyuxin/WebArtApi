package com.gyx.control
{
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.events.TextEvent;
	public class NumberAdjuster extends BaseComponent
	{
		public var value:int;
		var background:Sprite;
		var dragging:Boolean;
		var textShow:TextField;
		var mouseDownValue;
		var minValue:int;
		var maxValue:int;
		var inputing:Boolean = false;
		var oneClick:Boolean;
		var newMouse:MouseFollower;
		public function NumberAdjuster(labelStr:String,value:int=0,minValue:int=0,maxValue:int=100)
		{
			super(labelStr);
			value = Math.max(value, minValue);
			value = Math.min(value, maxValue);
			this.minValue = minValue;
			this.maxValue = maxValue;
			
			background = new Sprite();
			addChild(background);
			
			textShow=new TextField();
			textShow.restrict = "0-9";
			textShow.multiline = false;
			textShow.selectable = false;
			textShow.text = "0";
			textShow.height = textShow.textHeight + 4;
			textShow.width = 23;
			addChild(textShow);

			textShow.addEventListener(Event.CHANGE, change);

			enabled = true;
			if (label)
			{
				textShow.x = label.width;
				background.x = label.width;
				label.y = (background.height - label.height) / 2;
			}
			setValue(value);
		}
		public function setValue(v:int)
		{
			v = Math.max(v, minValue);
			v = Math.min(v, maxValue);
            if(v==value)
                return;
			value = v;
			textShow.text = v+"";
			dispatchEvent(new Event(Event.CHANGE));
		}
		//enable
		public function set enabled(value:Boolean)
		{
			enableChange(value);
			if (value)
			{
				textShow.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
				textShow.addEventListener(MouseEvent.MOUSE_OUT,mouseOut);
				textShow.addEventListener(MouseEvent.MOUSE_OVER,mouseOver);
				draw(0);
			}
			else
			{
				textShow.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
				textShow.removeEventListener(MouseEvent.MOUSE_OUT,mouseOut);
				textShow.removeEventListener(MouseEvent.MOUSE_OVER,mouseOver);
				draw(3);
			}
		}
		function mouseMove(e:Event)
		{
			if (inputing)
			{
				return;
			}
			var disp = 0;
			if (mouseY<0)
			{
				disp = mouseY;
			}
			else if (mouseY>textShow.height)
			{
				disp = mouseY - textShow.height;
			}
			disp *=  -0.5;
			var newValue = mouseDownValue + disp;
			if (newValue!=value)
			{
				oneClick = false;
				setValue(newValue);
			}
		}
		function change(e:Event)
		{
			var v:int = parseInt(textShow.text);
			setValue(v);
			e.stopPropagation();
		}
		function draw(type:int)
		{
			var g:Graphics = background.graphics;
			g.clear();
			if (type==0)
			{
				textShow.textColor = 0x000000;
				g.lineStyle(1,0x555555);
				g.beginFill(0xdddddd,0.8);
			}
			else if (type==1)
			{
				textShow.textColor = 0x000000;
				g.lineStyle(1,0x000000);
				g.beginFill(0xffffff,0.8);
			}
			else if (type==2)
			{
				textShow.textColor = 0x000000;
				g.lineStyle(1,0x44aaff);
				g.beginFill(0xdddddd,0.8);
			}
			else if (type==3)
			{
				textShow.textColor = 0x666666;
				g.lineStyle(1,0x666666);
				g.beginFill(0xe2e2e2,0.8);
			}
			g.lineTo(textShow.width,0);
			g.lineTo(textShow.width,textShow.height);
			g.lineTo(0,textShow.height);
			g.lineTo(0,0);
		}
		function mouseDown(e:Event)
		{
			if (inputing)
			{
				if (e.target != textShow)
				{
					draw(0);
					textShow.selectable = false;
					textShow.type = TextFieldType.DYNAMIC;
					textShow.setSelection(0,0);
					stage.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
					inputing = false;
				}
				return;
			}
			dragging = true;
			oneClick = true;
			mouseDownValue = value;
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
		}
		function mouseUp(e:Event)
		{
			if (!inputing)
			{
				dragging = false;
				MouseFollower.setFollower(MouseFollower.NONE);
				if (e.target != textShow || ! oneClick)//finish adjust
				{
					stage.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
					dispatchEvent(new NumberAdjusterEvent(NumberAdjusterEvent.ADJUST_OVER));
				}
				else//cilck,start input
				{
					draw(1);
					textShow.selectable = true;
					textShow.type = TextFieldType.INPUT;
					inputing = true;
					stage.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
				}
			}
			e.stopPropagation();
		}
		function mouseOver(e:Event)
		{
			if (! inputing)
			{
				MouseFollower.setFollower(MouseFollower.VERTICAL_DOUBLE_POINTER);
				draw(2);
			}
		}
		function mouseOut(e:Event)
		{
			if (inputing)
			{
				draw(1);
			}
			else
			{
				draw(0);
			}
			if (! dragging)
			{
				MouseFollower.setFollower(MouseFollower.NONE);
			}
		}
	}

}