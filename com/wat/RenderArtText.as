package com.wat
{
	import com.wat.ArtText;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.text.TextFormat;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.text.TextField;
	import flash.display.GradientType;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.external.ExternalInterface;
	public class RenderArtText extends Sprite
	{
		var target:ArtText;
		public function RenderArtText(target)
		{
			this.target = target;
			reRender();
		}
		public function reRenderFilter()
		{
			var fs:Array = [];
			if (target.bevel)
			{
				fs.push(target.bevel);
			}
			if (target.border)
			{
				fs.push(target.border);
			}
			if (target.glow)
			{
				fs.push(target.glow);
			}
			if (target.shadow)
			{
				fs.push(target.shadow);
			}
			this.filters = fs;
		}
		public function reRender()
		{
			while (this.numChildren)
			{
				this.removeChildAt(0);
			}
			var targetText:TextField=new TextField();
			targetText.text = target.text+" ";
			targetText.textColor = target.color;
			var tf:TextFormat = new TextFormat(target.font,Math.floor(target.size*target.reSize/100));
			tf.letterSpacing = target.spacing;
			tf.bold = target.bold;
			tf.italic = target.italic;
			targetText.setTextFormat(tf);
			targetText.width = 2000;
			targetText.height = 200;
			var w:Number = targetText.textWidth;
			var h:Number = targetText.textHeight;
			var bmd:BitmapData = new BitmapData(w,h,true,0);
			var m:Matrix = new Matrix(1,0,0,1,0,0);
			bmd.draw(targetText,null,null,null,null,true);
			if (target.fillType == 1)
			{
				var matrix:Matrix = new Matrix();
				matrix.createGradientBox(w,h,Math.PI/2,0,0);
				var gradBox:Sprite=new Sprite();
				gradBox.graphics.beginGradientFill(GradientType.LINEAR, 
				                                        target.fillGradientColor,
														null,
														target.fillGradientRatios ,
				                                        matrix);
				gradBox.graphics.drawRect(0,0,w,h);
				var gradient_bm:BitmapData = new BitmapData(w,h);
				gradient_bm.draw(gradBox);
				gradient_bm.copyChannel(bmd,new Rectangle(0,0,w,h),new Point(),BitmapDataChannel.ALPHA,BitmapDataChannel.ALPHA);
				bmd.draw(gradient_bm,null,null,null,null,true);
			}
			var bm:Bitmap = new Bitmap(bmd);
			this.addChild(bm);
			reRenderFilter();
			//this.scaleX=target.reSize*0.01;
			//this.scaleY=target.reSize*0.01;
            ExternalInterface.call("swfResize", width+5,height+5);
		}
	}
}