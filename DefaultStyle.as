package  
{
	import com.gyx.sytle.BaseStyle;
	import flash.text.TextFormat;
	public class DefaultStyle 
	{
		public static var common:BaseStyle = new BaseStyle(null);
		common.setStyle("backgroundColor", 0xcccccc);
		common.setStyle("backgroundColor-inactive", 0xaaaaaa);
		common.setStyle("backgroundColor-inactive-shadow", 0x888888);
		common.setStyle("controlColor", 0xdddddd);
		common.setStyle("borderWidth", 1);
		common.setStyle("borderColor", 0x000000);
		common.setStyle("borderColor-disable", 0x666666);
		common.setStyle("padding", 0);
		common.setStyle("margin", 0);
		common.setStyle("textFormat", new TextFormat());
		
		public static var girdLayout:BaseStyle = new BaseStyle(common);
		common.setStyle("borderWidth", "none");
		
		public static var noPaddingGird:BaseStyle = new BaseStyle(girdLayout);
		noPaddingGird.setStyle("break", 6);
		
		public static var gird:BaseStyle = new BaseStyle(girdLayout);
		gird.setStyle("break", 2);
		gird.setStyle("padding", 2);
		
		public static var tabPage:BaseStyle = new BaseStyle(common);
		tabPage.setStyle("tabWidth", 50);
		tabPage.setStyle("tabHeight", 18);
		tabPage.setStyle("tabSlopeWidth", 8);
		tabPage.setStyle("corner", 1);
		tabPage.setStyle("pageWidth", 500);
		tabPage.setStyle("pageHeight", 60);
		
		public static var componet:BaseStyle = new BaseStyle(common);
		componet.setStyle("labelColor", 0x000000);
		componet.setStyle("backgroundColor", 0xaaaaaa)
		componet.setStyle("backgroundColor-selected", 0xcccccc);
		componet.setStyle("borderColor-selected", 0xffee66);
		componet.setStyle("labelColor-disable", 0x666666);
		componet.setStyle("hoverboderColor", 0x44aaff);
		componet.setStyle("hoverboderWidth", 1);
	}

}