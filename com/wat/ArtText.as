package com.wat
{
	import flash.filters.DropShadowFilter;
	import flash.filters.BevelFilter;
	import flash.filters.GlowFilter;
	public class ArtText
	{
		public var text:String = "Web ArtText网络艺术字";
		public var size:int = 32;
		public var reSize:int =	100;
		public var font:String = "SimHei";
		public var spacing:int = 0;
		public var bold:Boolean = false;
		public var italic:Boolean = false;
		public var color:uint = 0x000000;
		public var fillType:int = 0;
		public var fillGradientColor:Array = [0,0xffffff];
		public var fillGradientRatios:Array = [0,255];
		public var fillGradientVertical:Boolean;
		public var border:GlowFilter = null;
		public var bevel:BevelFilter = null;
		public var glow:GlowFilter = null;
		public var shadow:DropShadowFilter = null;
		public var err:String = "OK";
		public function ArtText(str:String)
		{
			if (str==null)
			{
				return;
			}
			var strs:Array = str.split("\n");
			if (strs[0] != "WebArtText")
			{
				err = "wrong head";
				return;
			}
			if (int(strs[1].split(" ")[1])>1)
			{
				err = "version too high";
				return;
			}
			text = strs[2];
			var txtStr:Array = strs[3].split(",");
			size = parseInt(txtStr[0]);
			bold = txtStr[1] == "true";
			color = uint(txtStr[2]);
			fillType = parseInt(txtStr[3]);
			font = txtStr[4];
			italic = txtStr[5] == "true";
			spacing = parseInt(txtStr[6]);
			if (fillType == 1)
			{
				fillGradientColor = [];
				fillGradientRatios = [];
				txtStr = strs[4].split(",");
				for (var i = 0; i < txtStr.length; i++ )
					fillGradientColor.push(uint(txtStr[i]));
				txtStr = strs[5].split(",");
				for (i = 0; i < txtStr.length; i++ )
					fillGradientRatios.push(int(txtStr[i]));
			}
			if (strs[6] != "null")
			{
				
				txtStr = strs[6].split(",");
				var br1:BevelFilter = new BevelFilter(Number(txtStr[0]),int(txtStr[1]),uint(txtStr[2]),1,uint(txtStr[3]),1,Number(txtStr[4]),Number(txtStr[5]),Number(txtStr[6]),1,txtStr[7],txtStr[8] == "true");
				this.bevel = br1;
			}
			if (strs[7] != "null")
			{
				txtStr = strs[7].split(",");
				var br2:GlowFilter = new GlowFilter(uint(txtStr[0]),1,Number(txtStr[1]),Number(txtStr[1]),Number(txtStr[1]),1,txtStr[2] == "true",txtStr[3] == "true");
				this.border = br2;
			}
			if (strs[8] != "null")
			{
				txtStr = strs[8].split(",");
				var br3:GlowFilter = new GlowFilter(uint(txtStr[0]),1,Number(txtStr[1]),Number(txtStr[2]),Number(txtStr[3]),1,txtStr[4] == "true",txtStr[5] == "true");
				this.glow = br3;
			}
			if (strs[9] != "null")
			{
				txtStr = strs[9].split(",");
				var br4:DropShadowFilter = new DropShadowFilter(Number(txtStr[0]),int(txtStr[1]),uint(txtStr[2]),1,Number(txtStr[3]),Number(txtStr[4]),Number(txtStr[5]),1,txtStr[6] == "true",txtStr[7] == "true");
				this.shadow = br4;
			}
		}
		function addSlashes(str:String)
		{
			var i:int;
			var strRes:String = "";
			for (i=0; i<str.length; i++)
			{
				var ch = str.charAt(i);
				if (ch=="\\" || ch=="\'" || ch=="\"")
				{
					strRes +=  "\\" + ch;
				}
				else
				{
					strRes +=  ch;
				}
			}
			return strRes;
		}
		public function export()
		{
			var str="WebArtText\\n"
			+"version 1\\n"
			+addSlashes(this.text) + "\\n"
			+this.size+","+this.bold+","+this.color+","+this.fillType+","+this.font+","+this.italic+","+this.spacing+"\\n";
				if (this.fillType == 1)
					str += fillGradientColor.join(",");
			str += "\\n";
				if (this.fillType == 1)
					str += fillGradientRatios.join(",");
			str += "\\n";
			
			if (this.bevel)
			{
				str +=  this.bevel.distance + "," + this.bevel.angle + "," + this.bevel.highlightColor + "," + this.bevel.shadowColor + "," + this.bevel.blurX + "," + this.bevel.blurY + "," + this.bevel.strength + "," + this.bevel.type + "," + this.bevel.knockout + "\\n";
			}
			else
			{
				str +=  "null\\n";
			}
			if (this.border)
			{
				str +=  this.border.color + "," + this.border.blurX + "," + this.border.inner + "," + this.border.knockout + "\\n";
			}
			else
			{
				str +=  "null\\n";
			}
			if (this.glow)
			{
				str +=  this.glow.color + "," + this.glow.blurX + "," + this.glow.blurY + "," + this.glow.strength + "," + this.glow.inner + "," + this.glow.knockout + "\\n";
			}
			else
			{
				str +=  "null\\n";
			}
			if (this.shadow)
			{
				str +=  this.shadow.distance + "," + this.shadow.angle + "," + this.shadow.color + "," + this.shadow.blurX + "," + this.shadow.blurY + "," + this.shadow.strength + "," + this.shadow.inner + "," + this.shadow.knockout + "\\n";
			}
			else
			{
				str +=  "null\\n";
			}
			trace(str);
			return str;
		}
	}
}