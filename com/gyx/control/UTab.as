package com.gyx.control
{
	import flash.display.Sprite;

	public class UTab extends Sprite
	{
		var reRender:Function;
		var reFilter:Function;
		var tabs:Array = new Array();
		
        var tabCount:int=0;
		public function UTab(reRender:Function,reFilter:Function)
		{
			this.reRender = reRender;
			this.reFilter = reFilter;
			
		}
        public function addPanel(name:String,controll:Sprite)
        {
            var tp=new UTabPage(tabCount,name,controll,tabDown);
            tabs.push(tp);
            addChild(tp);
            tabCount++;
			tabDown(0);
        }
		function tabDown(index:int)
		{
			for (var i:int=0; i<tabs.length; i++)
			{
				tabs[i].deActive();
				setChildIndex(tabs[i],0);
			}
			tabs[index].active();
			setChildIndex(tabs[index],this.numChildren-1);
		}
	}

}