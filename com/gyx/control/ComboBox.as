package com.gyx.control
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.events.MouseEvent
	import flash.geom.ColorTransform;
	public class ComboBox extends BaseComponent
	{
		var demo:ListLabel;
        var tileHeight:int = 20;
		var tileWidth:int = 80;
        var list:List;
        public var selectedIndex:int;
		var dataCount:int;
		var colorTransform:ColorTransform = new ColorTransform();
		public function ComboBox(labelStr,dataOrPreview,dataCount,selectedIndex=0,tileWidth=80)
		{
			super(labelStr);
			this.dataCount = dataCount;
			this.tileWidth = tileWidth;
          	demo=new ListLabel(0,dataOrPreview,tileWidth);
            addChild(demo);
			selectById(selectedIndex);
            list=new List(dataOrPreview,dataCount,tileWidth);
			enabled=true;
			if (label)
			{
				demo.x = label.width;
				label.y = (demo.height - label.height) / 2;
			}
			
			list.addEventListener(Event.CHANGE, changeSelected);
		}
        function changeSelected(e:Event)
        {
            selectById(list.selectedIndex)
			closeList();
        }
        function openList(e:Event)
        {
			var location:Point = new Point(label.width,0);
			location = localToGlobal(location);
			list.x = location.x;
			list.y = location.y;
            (stage.getChildByName("controlLayer") as Sprite).addChild(list);
            stage.addEventListener(MouseEvent.MOUSE_DOWN,testClose);
        }
        // if mouse closed outside the list,close current list
        function testClose(e:MouseEvent)
        {
            if(!list.contains(e.target as DisplayObject) && !this.contains(e.target as DisplayObject))
                closeList();
        }
        function closeList()
        {
            list.parent.removeChild(list);
            stage.removeEventListener(MouseEvent.MOUSE_DOWN,testClose);
        }
		function mouseOver(e:MouseEvent)
		{
			MouseFollower.setFollower(MouseFollower.DOWN_ARROW);
		}
		function mouseOut(e:MouseEvent)
		{
			MouseFollower.setFollower(MouseFollower.NONE);
		}
        public function selectById(argId)
        {
            selectedIndex=argId;
            demo.reDraw(argId);
            dispatchEvent(new Event(Event.CHANGE));
        }
        public function set enabled(arg)
        {
			enableChange(arg);
            if(arg)
            {
                mouseChildren=true;
                tabChildren = true;
				colorTransform = new ColorTransform();
                demo.drawBack(0);
                demo.addEventListener(MouseEvent.MOUSE_DOWN,openList);
                demo.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
                demo.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
            }
            else
            {
                mouseChildren=false;
                tabChildren = false;
				colorTransform.color = 0x666666;
                demo.drawBack(2);
                demo.removeEventListener(MouseEvent.MOUSE_DOWN,openList);
                demo.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
                demo.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
            }
			demo.front.transform.colorTransform=colorTransform;
        }
	}
	
}