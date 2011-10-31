package com.gyx.control 
{
	import flash.events.Event;
	
	public class ColorSelectorEvent extends Event 
	{
		public static const COLOR_CHANGE:String="COLOR_CHANGE" 
        public static const ALPHA_CHANGE:String="ALPHA_CHANGE" 
		public function ColorSelectorEvent(eventType) 
		{
			super(eventType,true);
		}	
	}
}