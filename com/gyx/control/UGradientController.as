package com.gyx.control
{
	import flash.display.GradientType;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.gyx.control.USlider;
	import com.gyx.control.UColorPicker;
	public class UGradientController extends Sprite
	{
		public var ratioArray:Array;
		public var colorArray:Array;
		var w = 255,h = 10;
		var matrix:Matrix = new Matrix();
		var gradBox:Sprite = new Sprite();
		var gradient_bm:BitmapData;
		var bm:Bitmap;
		var sliders:Array=new Array();
		var colorPicker:UColorPicker;
		var selectedSlider:USlider = null;
		
		public function UGradientController(colorArray:Array,ratioArray:Array)
		{
			this.ratioArray = ratioArray;
			this.colorArray = colorArray;
			matrix.createGradientBox(w,h,0,0,0);
			gradient_bm = new BitmapData(w,h);
			bm = new Bitmap(gradient_bm);
			gradBox.addChild(bm);
			gradBox.addEventListener(MouseEvent.MOUSE_DOWN,addNewSlider);
			addChild(gradBox);
			for (var i=0; i<colorArray.length; i++)
			{
				sliders.push(new USlider(ratioArray[i],colorArray[i],w,h,i<2,this));
				addChild(sliders[i]);
			}
			colorPicker = new UColorPicker({label:"当前色"});
			colorPicker.x = w + 20;
			addChild(colorPicker);
			colorPicker.enabled = false;
			colorPicker.addEventListener(Event.CHANGE, changeColor);

			changeGradient();
			
		}
		public function reDraw()
		{
			colorArray=new Array();
			ratioArray=new Array();
			for (var i=0; i<sliders.length; i++)
			{
				if (sliders[i].x >= 0 && sliders[i].x <= w)
				{
					colorArray.push(sliders[i].color);
					ratioArray.push(sliders[i].x);
				}
			}
			//bubble sort is fine here
			for (i=0; i<colorArray.length; i++)
			{
				var flag = false;
				for (var j=0; j<colorArray.length-i-1; j++)
				{
					if (ratioArray[j] > ratioArray[j + 1])
					{
						var temp = ratioArray[j];
						ratioArray[j] = ratioArray[j + 1];
						ratioArray[j + 1] = temp;
						temp = colorArray[j];
						colorArray[j] = colorArray[j + 1];
						colorArray[j + 1] = temp;
						flag = true;
					}
				}
				if (flag==false)
				{
					break;
				}
			}
			changeGradient();
			dispatchEvent(new Event(Event.CHANGE));
		}
		public function changeColor(e:Event)
		{
			if (selectedSlider)
			{
				selectedSlider.color = e.target.selectedColor;
				selectedSlider.drawMark(true);
				reDraw();
			}
		}
		public function del(target:USlider)
		{
			//remove all pointer
			target.kill();
			removeChild(target);
			sliders.splice(sliders.indexOf(target),1);
			selectedSlider = null;
			colorPicker.enabled = false;
		}
		public function select(target:USlider)
		{
			for (var i=0; i<sliders.length; i++)
			{
				if (sliders[i])
				{
					sliders[i].unSelect();
				}
			}
			target.select();
			setChildIndex(target, numChildren - 1);
			colorPicker.enabled = true;
			colorPicker.setColor(target.color);
			selectedSlider = target;
		}
		function addNewSlider(e:MouseEvent)
		{
			reDraw();
			for (var i=0; i<ratioArray.length; i++)
			{
				if (ratioArray[i] > gradBox.mouseX)
				{
					break;
				}
			}
			//颜色插值
			var r1 =( colorArray[i - 1] >> 16) % 256;
			var g1 =( colorArray[i - 1] >> 8 )% 256;
			var b1 = colorArray[i - 1] % 256;
			var r2 =( colorArray[i] >> 16) % 256;
			var g2 =( colorArray[i] >> 8 )% 256;
			var b2 = colorArray[i] % 256;
			var newR:int=r1+(r2-r1)*(gradBox.mouseX-ratioArray[i-1])/(ratioArray[i]-ratioArray[i-1]);
			var newG:int=g1+(g2-g1)*(gradBox.mouseX-ratioArray[i-1])/(ratioArray[i]-ratioArray[i-1]);
			var newB:int=b1+(b2-b1)*(gradBox.mouseX-ratioArray[i-1])/(ratioArray[i]-ratioArray[i-1]);
			var newSlider = new USlider(gradBox.mouseX,newR * 256 * 256 + newG * 256 + newB,w,h,false,this);
			sliders.push(newSlider);
			addChild(newSlider);
		}
		function changeGradient()
		{
			gradBox.graphics.clear();
			gradBox.graphics.lineStyle(1);
			gradBox.graphics.beginGradientFill(GradientType.LINEAR,colorArray,null,ratioArray,matrix);
			gradBox.graphics.drawRect(0,0,w,h);
			gradBox.graphics.endFill();
			gradient_bm.draw(gradBox);
		}
	}

}