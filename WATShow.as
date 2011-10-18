package  {
	import com.wat.ArtText;
	import com.wat.RenderArtText;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	public class WATShow extends MovieClip
	{
		var artText:ArtText;
		var artTextShowing:RenderArtText;
		public function WATShow() {
			// constructor code
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			artText = new ArtText("WebArtText\nversion 1\n艺术字\n68,false,0,1,LiSu,false,0\n12582847,0\n0,255\n2,45,16777215,0,2,2,1,inner,false\n16777215,7.2,false,false\n9013759,10,10,2.25,false,false\n6.5,45,0,2,2,2.55859375,false,false\n");
			artTextShowing = new RenderArtText(artText);
			addChild(artTextShowing);
			[SWF(width="200", height="600")]
		}

	}
	
}
