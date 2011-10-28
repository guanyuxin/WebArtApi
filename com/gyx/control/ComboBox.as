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
		public function ComboBox(option)
		{
			super(option);
			option.selectedIndex ||= 0;
			option.tileWidth ||= 80;
			this.tileWidth = option.tileWidth;
			
          	demo=new ListLabel(option);
            comp.addChild(demo);
			componentFinish();
			
			selectById(option.selectedIndex);
            list=new List(option);
			enabled=true;
			
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
		protected override function mouseOver(e:MouseEvent)
		{
			super.mouseOver(e);
			MouseFollower.setFollower(MouseFollower.DOWN_ARROW);
		}
		protected override function mouseOut(e:MouseEvent)
		{
			super.mouseOut(e)
			MouseFollower.setFollower(MouseFollower.NONE);
		}
        public function selectById(argId)
        {
            selectedIndex=argId;
            demo.reDraw(argId);
            dispatchEvent(new Event(Event.CHANGE));
        }
        public function set enabled(val:Boolean)
        {
			if (val == _enabled)
				return;
			setEnabled(val);
            if(val)
            {
                mouseChildren=true;
                tabChildren = true;
				colorTransform = new ColorTransform();
                demo.drawBack(0);
                demo.addEventListener(MouseEvent.MOUSE_DOWN,openList);
            }
            else
            {
                mouseChildren=false;
                tabChildren = false;
				colorTransform.color = 0x666666;
                demo.drawBack(2);
                demo.removeEventListener(MouseEvent.MOUSE_DOWN,openList);
            }
			demo.front.transform.colorTransform=colorTransform;
        }
	}
	
}