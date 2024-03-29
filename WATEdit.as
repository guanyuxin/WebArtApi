﻿package 
{
	import com.gyx.control.UMouse;
	import com.gyx.control.UTab;
	import com.wat.ArtText;
	import com.wat.control.*;
	import com.wat.RenderArtText;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	public class WATEdit extends MovieClip
	{
		var artText:ArtText;
		var artTextShowing:RenderArtText;
		var newMouse:UMouse;
		var tabControl:UTab;
		var controlLayer:Sprite;
		public function WATEdit()
		{
			// constructor code
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			controlLayer = new Sprite();
			controlLayer.name = "controlLayer";
			stage.addChild(controlLayer);
			
            UMouse.initMouse(stage);
			
			artText = new ArtText(null);
			artTextShowing = new RenderArtText(artText);
			controlLayer.addChild(artTextShowing);
			tabControl = new UTab(artTextShowing.reRender,changeFilters);
			controlLayer.addChild(tabControl);
			var tabInfo=[
			 {tabText:"文字",control:new TextControl(artText,artTextShowing.reRender)}
			 ,{tabText:"格式",control:new FillControl(artText,artTextShowing.reRender)}
			 ,{tabText:"倒角",control:new BevelControl(artText,changeFilters)}
			 ,{tabText:"边框",control:new BorderControl(artText,changeFilters)}
			 ,{tabText:"发光",control:new GlowControl(artText,changeFilters)}
			 ,{tabText:"阴影",control:new ShadowControl(artText,changeFilters)}
			 ];
			for (var i=0; i<tabInfo.length; i++)
			{
				tabControl.addPanel(tabInfo[i].tabText,tabInfo[i].control);
			}
			tabControl.y = 100;
			tabControl.x = 20;
			root.addEventListener(KeyboardEvent.KEY_DOWN, exp);
		}
		function exp(e:KeyboardEvent)
		{
			if(e.keyCode==48)
			artText.export();
		}
		function changeFilters(type:String,filter)
		{
			if (type=="shadow")
			{
				artText.shadow = filter;
			}
			else if (type=="bevel")
			{
				artText.bevel = filter;
			}
			else if (type=="border")
			{
				artText.border = filter;
			}
			else if (type=="glow")
			{
				artText.glow = filter;
			}
			artTextShowing.reRenderFilter();
		}
	}

}
//reminder mouseOver should check if mouse is down,if mot ,the event should not belong to this 
//be very careful when you cancel mouseDown event form propagation,some components is listening mousedown on stage