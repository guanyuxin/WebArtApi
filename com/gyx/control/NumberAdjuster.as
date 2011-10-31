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
		public function NumberAdjuster(option:Object)
		{
			super(option);
			option.value ||= 0;
			option.minValue ||= 0;
			option.maxValue ||= 100;
			
			value = Math.max(option.value, option.minValue);
			value = Math.min(option.value, option.maxValue);
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
			enabled = true;
			setValue(option.value);
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
				if (this.status == NumberAdjuster.STATUS_INPUTING) {
					textShow.backgroundColor = style.getStyleUint("backgroundColor-selected");
				}
				else{
					textShow.backgroundColor = style.getStyleUint("backgroundColor");
				}
				graphics.clear();
				if (hover)
				{
					graphics.lineStyle(style.getStyleInt("hoverboderWidth"),style.getStyleUint("hoverboderColor"));
					graphics.drawRect( textShow.x-1, textShow.y-1, textShow.width + 2, textShow.height + 2);
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
				status=NumberAdjuster.STATUS_ADJUSTING;
				setValue(newValue);
			}
		}
		function mouseDown(e:Event)
		{
			if (status == NumberAdjuster.STATUS_NORMAL) {
				dragging = true;
				status = NumberAdjuster.STATUS_BEFORE_ADJUSTING;
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
					status = NumberAdjuster.STATUS_NORMAL;
					draw()
				}
		}
		function mouseUp(e:Event)
		{
			dragging = false;
			MouseFollower.setFollower(MouseFollower.NONE);
			if (status==NumberAdjuster.STATUS_ADJUSTING)//finish adjust
			{
				dispatchEvent(new NumberAdjusterEvent(NumberAdjusterEvent.ADJUST_OVER));
				status = NumberAdjuster.STATUS_NORMAL;
			}
			else//cilck,start input
			{
				textShow.selectable = true;
				textShow.type = TextFieldType.INPUT;
				status = NumberAdjuster.STATUS_INPUTING;
				stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownOut)
			}
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			draw();
		}
		protected override function mouseOver(e:MouseEvent)
		{
			if (status!=NumberAdjuster.STATUS_INPUTING)
			{
				MouseFollower.setFollower(MouseFollower.VERTICAL_DOUBLE_POINTER);
			}
			super.mouseOver(e);
		}
		protected override function mouseOut(e:MouseEvent)
		{
			if (status!=NumberAdjuster.STATUS_INPUTING && dragging==false)
			{
				MouseFollower.setFollower(MouseFollower.NONE);
			}
			super.mouseOut(e);
		}
	}

}