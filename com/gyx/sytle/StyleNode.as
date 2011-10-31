package com.gyx.sytle 
{
	/**
	 * ...
	 * @author GYX
	 */
	class StyleNode 
	{
		//public var closed:Boolean;
		public var value:Object;
		public var cache:Boolean;
		public function StyleNode(value:Object,cache:Boolean) 
		{
			this.value = value;
			this.cache = cache;
		}
		
	}

}