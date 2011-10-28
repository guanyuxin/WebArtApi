package com.gyx.sytle 
{
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author GYX
	 */
	public class BaseStyle 
	{
		var parent:BaseStyle;
		var nodes = { };
		public function BaseStyle(parent) 
		{
			this.parent=parent
		}
		public function getStyleInt(styleName:String):int
		{
			return (int)(_getStyle(styleName).value);
		}
		public function getStyleUint(styleName:String):int
		{
			return (uint)(_getStyle(styleName).value);
		}
		public function getStyleNumber(styleName:String):int
		{
			return (Number)(_getStyle(styleName).value);
		}
		public function getStyleString(styleName:String):String
		{
			return _getStyle(styleName).value.toString();
		}
		public function getStyleTextFormat(styleName:String):TextFormat
		{
			return _getStyle(styleName) as TextFormat;
		}
		public function getStyle(styleName:String):Object
		{
			return _getStyle(styleName).value;
		}
		function _getStyle(styleName:String):StyleNode
		{
			var log:Boolean = false;
			//if (styleName == "borderColor-disabled")
			//	log = true;
			var node:StyleNode=nodes[styleName];		//if (log)	trace(styleName+"  "+node);
			if (node)//if the node exists(defined of cache)
				return node;
			if (styleName.indexOf("-") >= 0)//if style has a short name
			{
				var tempStyleName:String = styleName.concat();
				while (tempStyleName.indexOf("-") >= 0)
				{
					tempStyleName = tempStyleName.substring(0, tempStyleName.lastIndexOf("-"));
					node = nodes[tempStyleName];
					if (node && node.cache==false)
						break;
					else
						node = null;
				}
			}
			if (!node && parent)//get inhert style
				node = parent._getStyle(styleName);
			if (!node)
				trace("style ["+styleName+"] not Fond")
			nodes[styleName] = new StyleNode(node.value,true);
			return node;
		}
		public function setStyle(styleName:String, value:Object)
		{
			nodes[styleName] = new StyleNode(value, false);
		}
	}

}