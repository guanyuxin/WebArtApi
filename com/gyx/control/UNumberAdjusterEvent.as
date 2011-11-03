package com.gyx.control 
{
	import flash.events.Event;
	
	public class UNumberAdjusterEvent extends Event 
	{
		public static const ADJUST_OVER:String="ADJUST_OVER" 
		public function UNumberAdjusterEvent(eventType) 
		{
			super(eventType,true);
		}
		
	}

}