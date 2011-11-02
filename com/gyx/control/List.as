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
		var contentListMask:Sprite;
		var tileHeight:int = 20;
		var tileWidth:int = 80;
		var windowHeight:int = 100;
		var elements:Array = new Array();
        var selectedIndex:int=0;

		public function List(option)
		{
			option.tileWidth ||= 80;
			option.selectedIndex ||= 0;
			option.data ||= [];
			
			tileWidth = option.tileWidth;
			contentListMask = new Sprite();
			contentListMask.graphics.beginFill(0xffffff);
			contentListMask.graphics.drawRect(0, 0, tileWidth, windowHeight);
			addChild(contentListMask);

			contentList = new Sprite();
			contentList.mask = contentListMask;
			addChild(contentList);
			
			var border:Sprite = new Sprite();
			border.graphics.lineStyle(1);
			border.graphics.drawRect(0, 0, tileWidth, Math.min(option.data.length * tileHeight , windowHeight));
			addChild(border);
			
			for (var i = 0; i < option.data.length; i++ )
			{
				option.id=i;
				var dis:ListLabel=new ListLabel(option);
				dis.y=i*tileHeight;
				elements.push(dis);
				dis.addEventListener(MouseEvent.MOUSE_DOWN,listMouseDown);
				contentList.addChild(dis);
			}
			elements[option.selectedIndex].selected=true;
			elements[option.selectedIndex].drawBack(2);
			if (windowHeight < option.data.length * tileHeight)
			{
				scroll = new Scroll(this,option.data.length * tileHeight, windowHeight);
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