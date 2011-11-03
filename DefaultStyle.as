package  
{
	import com.gyx.sytle.UStyle;
	import flash.text.TextFormat;
	public class DefaultStyle 
	{
		public static var common:UStyle = new UStyle(null);
		common.setStyle("backgroundColor", 0xcccccc);
		common.setStyle("backgroundColor-inactive", 0xaaaaaa);
		common.setStyle("backgroundColor-inactive-shadow", 0x888888);
		common.setStyle("controlColor", 0xdddddd);
		common.setStyle("borderWidth", 1);
		common.setStyle("borderColor", 0x000000);
		common.setStyle("padding", 0);
		common.setStyle("margin", 0);
		common.setStyle("textFormat", new TextFormat());
		
		public static var girdLayout:UStyle = new UStyle(common);
		common.setStyle("borderWidth", "none");
		common.setStyle("alien", "left")
		
		public static var noPaddingGird:UStyle = new UStyle(girdLayout);
		noPaddingGird.setStyle("break", 4);
		
		public static var gird:UStyle = new UStyle(girdLayout);
		gird.setStyle("break", 2);
		gird.setStyle("padding", 2);
		
		public static var girdCenter:UStyle = new UStyle(gird);
		girdCenter.setStyle("alien", "center");
		
		public static var tabPage:UStyle = new UStyle(common);
		tabPage.setStyle("tabWidth", 50);
		tabPage.setStyle("tabHeight", 18);
		tabPage.setStyle("tabSlopeWidth", 8);
		tabPage.setStyle("corner", 1);
		tabPage.setStyle("pageWidth", 500);
		tabPage.setStyle("pageHeight", 60);
		
		public static var componet:UStyle = new UStyle(common);
		componet.setStyle("labelColor", 0x000000);
		componet.setStyle("backgroundColor", 0xbbbbbb);
		componet.setStyle("backgroundColor-disabled", 0xcccccc);
		componet.setStyle("backgroundColor-selected", 0xcdddddd);
		componet.setStyle("borderColor-disabled", 0x666666);
		componet.setStyle("borderColor-selected", 0xffee66);
		componet.setStyle("labelColor-disabled", 0x666666);
		componet.setStyle("hoverboderColor", 0x44aaff);
		componet.setStyle("hoverboderWidth", 1);
	}

}