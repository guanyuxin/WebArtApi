﻿package com.gyx.control
{
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.events.TextEvent;
	public class UNumberAdjuster extends UComponent
	{
		public var value:int;
		var textShow:TextField;
		var mouseDownValue:int;
		var minValue:int;
		var maxValue:int;
		static const STATUS_NORMAL = 0;
		static const STATUS_BEFORE_ADJUSTING = 1;
		static const STATUS_ADJUSTING = 2;
		static const STATUS_INPUTING = 3;
		var dragging:Boolean=false;
		var status:int = STATUS_NORMAL;
		public function UNumberAdjuster(option:Object)
		{
			super(option);
			option.value ||= 0;
			option.minValue ||= 0;
			option.maxValue ||= 100;
			
			this.minValue = option.minValue;
			this.maxValue = option.maxValue;
						
			textShow=new TextField();
			textShow.restrict = "0-9";
			textShow.multiline = false;
			textShow.selectable = false;
			textShow.text = "0";
			textShow.height = 20;
			textShow.width = 23;
			textShow.border = true;
			textShow.background = true;
			
			comp.addChild(textShow);
			componentFinish();
			textShow.addEventListener(Event.CHANGE, change);
			setValue(option.value);
			enabled = true;
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
		public function set enabled(val:Boolean)
		{
			if (_enabled == val)
				return;
			setEnabled(val);
			if (val)
			{
				textShow.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			}
			else
			{
				textShow.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			}
			draw();
		}

		function change(e:Event)
		{
			var v:int = parseInt(textShow.text);
			setValue(v);
			e.stopPropagation();
		}
		public override function draw()
		{
			if (!_enabled) {
				textShow.textColor = style.getStyleUint("labelColor-disabled");
				textShow.borderColor = style.getStyleUint("borderColor-disabled");
				textShow.backgroundColor = style.getStyleUint("backgroundColor-disabled");
			}
			else {
				textShow.textColor = style.getStyleUint("labelColor");
				textShow.borderColor = style.getStyleUint("borderColor");;
				if (this.status == UNumberAdjuster.STATUS_INPUTING) {
					textShow.backgroundColor = style.getStyleUint("backgroundColor-selected");
				}
				else{
					textShow.backgroundColor = style.getStyleUint("backgroundColor");
				}
				comp.graphics.clear();
				if (hover)
				{
					comp.graphics.lineStyle(style.getStyleInt("hoverboderWidth"),style.getStyleUint("hoverboderColor"));
					comp.graphics.drawRect( -1, -1, comp.width + 2, comp.height + 2);
				}
			}
		}
		function mouseMove(e:Event)
		{
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
				status=UNumberAdjuster.STATUS_ADJUSTING;
				setValue(newValue);
			}
		}
		function mouseDown(e:Event)
		{
			if (status == UNumberAdjuster.STATUS_NORMAL) {
				dragging = true;
				status = UNumberAdjuster.STATUS_BEFORE_ADJUSTING;
				mouseDownValue = value;
				stage.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			}
		}
		function mouseDownOut(e:MouseEvent) {
			if (hover==false)
				{
					draw();
					textShow.selectable = false;
					textShow.type = TextFieldType.DYNAMIC;
					textShow.setSelection(0,0);
					stage.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownOut);
					status = UNumberAdjuster.STATUS_NORMAL;
					draw()
				}
		}
		function mouseUp(e:Event)
		{
			dragging = false;
			UMouse.setFollower(UMouse.NONE);
			if (status==UNumberAdjuster.STATUS_ADJUSTING)//finish adjust
			{
				dispatchEvent(new UNumberAdjusterEvent(UNumberAdjusterEvent.ADJUST_OVER));
				status = UNumberAdjuster.STATUS_NORMAL;
			}
			else//cilck,start input
			{
				textShow.selectable = true;
				textShow.type = TextFieldType.INPUT;
				status = UNumberAdjuster.STATUS_INPUTING;
				stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownOut)
			}
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			draw();
		}
		protected override function mouseOver(e:MouseEvent)
		{
			if (status!=UNumberAdjuster.STATUS_INPUTING)
			{
				UMouse.setFollower(UMouse.VERTICAL_DOUBLE_POINTER);
			}
			super.mouseOver(e);
		}
		protected override function mouseOut(e:MouseEvent)
		{
			if (status!=UNumberAdjuster.STATUS_INPUTING && dragging==false)
			{
				UMouse.setFollower(UMouse.NONE);
			}
			super.mouseOut(e);
		}
	}

}