package com.gyx.control
{
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	
	public class ListLabel extends Sprite
	{
		public var front:Sprite;
		var back:Sprite;
		public var id:int;
		var preview:Function;
		var data:Array;
		public var w:int=80;
		public var h:int=20;
		public var selected:Boolean=false;
		public function ListLabel(id:int,previewOrStr,w:int=80)
		{
			this.id = id;
			this.w = w;
			if(previewOrStr is Function){
				this.preview = previewOrStr;
			}else {
				this.data = previewOrStr;
				this.preview = defaultPreview;
			}
			back = new Sprite();
			front=new Sprite();
			reDraw(id);
			addChild(back);
			addChild(front);

			back.addEventListener(MouseEvent.MOUSE_OVER,mouseOver);
            back.addEventListener(MouseEvent.MOUSE_OUT,mouseOut);
		}
		public function reDraw(id)
		{
			this.id = id;
			while(front.numChildren>0)
				front.removeChild(front.getChildAt(0));
			drawBack();
			preview(id,this);
			//stop preView from being interactive
			front.tabEnabled = false;
			front.mouseEnabled = false;
			front.mouseChildren = false;
			front.tabChildren = false;

			addChild(front);
		}
		public function defaultPreview(id:int,target:ListLabel)
		{
			var label:Label = new Label(data[id]);
			label.x=(w-label.width)/2;
			label.y=(h-label.height)/2;
			front.addChild(label);
		}
		public function drawBack(type:int=0)
		{
			back.graphics.clear();
			back.graphics.lineStyle(1);
			if (selected==true)
			{
				back.graphics.beginFill(0xaaccff);
			}
			else if (type==0)
			{
				back.graphics.beginFill(0xffffff);
			}
			else if (type==1)
			{
				back.graphics.beginFill(0xcceeff);
			}
            else if(type==2)
            {
                back.graphics.beginFill(0xaaaaaa);
            }
			back.graphics.drawRect(0, 0, w, h);
			back.graphics.endFill();
		}
		function mouseOver(e:MouseEvent)
        {
            drawBack(1);
        }
        function mouseOut(e:MouseEvent)
        {
         	drawBack(0);
        }
	}

}