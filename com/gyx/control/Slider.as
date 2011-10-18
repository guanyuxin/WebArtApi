package com.gyx.control
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.display.Stage;
	class Slider extends Sprite
	{
		var MAXWidth:int;
		var dragging:Boolean = false;
		var selected:Boolean = false;
		var color:uint;
		var fixed:Boolean;
		var father:GradientControl;
		public function Slider(x:int,color:uint,MAXWidth:int,h:int,fixed:Boolean=false,father:GradientControl=null)
		{
			this.MAXWidth = MAXWidth;
			this.y = h;
			this.x = x;
			this.color = color;
			this.father=father;
			this.fixed=fixed;
			drawMark(false);
			
			addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			addEventListener(MouseEvent.MOUSE_OVER,mouseOver);
			addEventListener(MouseEvent.MOUSE_OUT,mouseOut);
		}
		function drawMark(active:Boolean)
		{
			var backColor:uint;
			if(active)
				backColor=0xeeeeee;
			else
				backColor=0xcccccc;
			this.graphics.clear();
			this.graphics.lineStyle(1);
			this.graphics.beginFill(backColor);
			this.graphics.lineTo(5,5);
			this.graphics.lineTo(5,15);
			this.graphics.lineTo(-5,15);
			this.graphics.lineTo(-5,5);
			this.graphics.endFill();

			this.graphics.beginFill(color);
			this.graphics.lineStyle(1);

			this.graphics.moveTo(-3,7);
			this.graphics.lineTo(3,7);
			this.graphics.lineTo(3,13);
			this.graphics.lineTo(-3,13);
			this.graphics.endFill();
		}
		function mouseOver(e:Event)
		{
			drawMark(true);
		}
		function mouseOut(e:Event)
		{
			if (selected==false)
			{
				drawMark(false);
			}
		}
		function mouseMove(e:Event)
		{
			if (dragging==false)
			{
				return;
			}
			var newX = father.gradBox.mouseX;
			if (newX<0)
			{
				newX = -1;
				MouseFollower.setFollower(MouseFollower.CROSS_45DEGREE);
			}
			else if (newX>=MAXWidth)
			{
				newX = MAXWidth + 1;
				MouseFollower.setFollower(MouseFollower.CROSS_45DEGREE);
			}
			else
			{
				MouseFollower.setFollower(MouseFollower.NONE);
			}
			this.x = newX;
			father.reDraw();
		}
		function mouseDown(e:Event)
		{
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
			father.select(this);
			if (!fixed)
			{
				dragging = true;
			}
		}
		function mouseUp(e:Event)
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
			dragging = false;
			if (x<0 || x>MAXWidth)
			{
				father.del(this);
				MouseFollower.setFollower(MouseFollower.NONE);
			}
		}
		public function select()
		{
			selected = true;
			filters=[new GlowFilter(0xffffff,1,6,6,4)];
		}
		public function unSelect()
		{
			drawMark(false);
			selected = false;
			filters = [];
		}
		public function kill()
		{
			removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			removeEventListener(MouseEvent.MOUSE_OVER,mouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT,mouseOut);
		}
	}

}
