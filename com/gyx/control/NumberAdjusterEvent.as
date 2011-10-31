package com.gyx.control 
{
	import flash.events.Event;
	
	public class NumberAdjusterEvent extends Event 
	{
		public static const ADJUST_OVER:String="ADJUST_OVER" 
		public function NumberAdjusterEvent(eventType) 
		{
			super(eventType,true);
		}
		
	}

}