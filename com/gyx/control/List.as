package com.gyx.control
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.events.MouseEvent
	public class List extends Sprite
	{
		public var scroll:Scroll;
		var dataCount:int;
		var contentList:Sprite;
		var contentBox:Sprite;
		var tileHeight:int = 20;
		var tileWidth:int = 80;
		var windowHeight:int = 100;
		var elements:Array = new Array();
        var selectedIndex:int=0;

		public function List(dataOrPreview,dataCount,tileWidth=80)
		{
			this.dataCount = dataCount;
			this.tileWidth = tileWidth;
			contentBox = new Sprite();
			contentBox.graphics.beginFill(0xffffff);
			contentBox.graphics.drawRect(0, 0, tileWidth, windowHeight);
			addChild(contentBox);

			contentList = new Sprite();
			contentList.mask = contentBox;
			addChild(contentList);

			var border:Sprite = new Sprite;
			border.graphics.lineStyle(1);
			border.graphics.drawRect(0, 0, tileWidth, dataCount * tileHeight > windowHeight?windowHeight:dataCount * tileHeight);
			addChild(border);
			for (var i = 0; i < dataCount; i++ )
			{
				var dis:ListLabel=new ListLabel(i,dataOrPreview,tileWidth);
				dis.y=i*tileHeight;
				elements.push(dis);
				dis.addEventListener(MouseEvent.MOUSE_DOWN,listMouseDown);
				contentList.addChild(dis);
			}
			elements[selectedIndex].selected=true;
			elements[selectedIndex].drawBack(2);
			if (windowHeight < dataCount * tileHeight)
			{
				scroll = new Scroll(this,dataCount * tileHeight, windowHeight);
				scroll.x = tileWidth-scroll.barWidth;
				scroll.addEventListener(Event.CHANGE, scrolling);
				addChild(scroll)
			}
			this.filters = [new DropShadowFilter(4, 45, 0, 0.5)];
		}
        function listMouseDown(e:MouseEvent)
        {
            if(e.currentTarget.id!=selectedIndex)
            {
                selectByIndex((e.currentTarget as ListLabel).id);    
            }
            dispatchEvent(new Event(Event.CHANGE));
        }
        public function selectByIndex(arg:int)
        {
			elements[selectedIndex].selected=false;
           	elements[selectedIndex].drawBack(0);
            selectedIndex=arg;
			elements[selectedIndex].selected=true;
           	elements[selectedIndex].drawBack(2);
        }
		function scrolling(e:Event)
		{
			contentList.y = -scroll.value;
		}
	}

}