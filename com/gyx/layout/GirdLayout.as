﻿package com.gyx.layout 
{
	import com.gyx.control.BaseComponent;
	import flash.display.Sprite;
	import com.gyx.sytle.BaseStyle;
	public class GirdLayout extends Sprite
	{
		public var rowCount:int = 1;
		public var columnCount:int;
		var columnWidth:Array;
		var colunmLabelWidth:Array;
		var rowHeight:Array;
		var style:BaseStyle;
		public function GirdLayout(rowCount:int=1,style:BaseStyle=null) 
		{
			this.rowCount = rowCount;
			if (style == null){
				style = new BaseStyle(null)
				style.setStyle("padding", 0);
				style.setStyle("break", 0);
				style.setStyle("borderWidth", "none");
			}
			this.style = style;
		}
		public function render()
		{
			columnCount = Math.ceil(numChildren / rowCount);
			columnWidth=new Array(columnCount);
			colunmLabelWidth = new Array(columnCount);
			rowHeight = new Array(rowCount);
			for (var i:int = 0; i < rowCount; i++ )
				rowHeight[i] = 0;
			for (i = 0; i < columnCount; i++ )
			{
				columnWidth[i] = 0;
				colunmLabelWidth[i]=0;
			}
			for (i = 0; i < numChildren; i++ )
			{
				if (getChildAt(i).visible == false)
					continue;
				if (getChildAt(i) is GirdLayout)
					(getChildAt(i) as GirdLayout).render();
				var currentColumn:int = Math.floor(i / rowCount);
				var currentRow:int = i % rowCount;
				var cw = Math.round(getChildAt(i).width);
				var ch = Math.round(getChildAt(i).height);
				if (columnWidth[currentColumn] < cw)
					columnWidth[currentColumn] = cw;
				if (rowHeight[currentRow] < ch)
					rowHeight[currentRow] = ch;
				if (getChildAt(i) is BaseComponent)
					if (colunmLabelWidth[currentColumn] < (getChildAt(i) as BaseComponent).lableWidth)
						colunmLabelWidth[currentColumn] = (getChildAt(i) as BaseComponent).lableWidth;
			}
			//cacluate size
			var currentX:int = style.getStyleInt("padding-left")+style.getStyleInt("padding-right")+(columnCount-1)*style.getStyleInt("break");
			var currentY:int = style.getStyleInt("padding-top")+style.getStyleInt("padding-bottom")+(rowCount-1)*style.getStyleInt("break");
			for (i = 0; i < rowCount; i++ )
			{
				currentY += rowHeight[i];
			}
			for (i = 0; i < columnCount; i++ )
			{
				currentX += columnWidth[i];
			}
			graphics.clear();
			graphics.beginFill(0, 0);//define size by drawing a transparent rectangle
			graphics.drawRect(0, 0, currentX, currentY);
			graphics.endFill();
			
			currentX = style.getStyleInt("padding-left");
			currentY = style.getStyleInt("padding-top");
			for (i = 0; i < numChildren; i++ )
			{
				if (!getChildAt(i).visible)
					continue;
				currentColumn = Math.floor(i / rowCount);
				currentRow = i % rowCount;
				if (style.getStyleString("borderWidth") != "none")
				{
					graphics.lineStyle(style.getStyleNumber("borderWidth"));
					graphics.drawRect(currentX,currentY,columnWidth[currentColumn],rowHeight[currentRow]);
				}	
				getChildAt(i).x = currentX;
				getChildAt(i).y = currentY;
				if (getChildAt(i) is BaseComponent)
					(getChildAt(i) as BaseComponent).x += colunmLabelWidth[currentColumn] - (getChildAt(i) as BaseComponent).lableWidth;
				getChildAt(i).y += Math.round((rowHeight[currentRow]-getChildAt(i).height)/2);
				if (currentRow != rowCount-1)
					currentY += style.getStyleInt("break") + rowHeight[currentRow];
				else
				{
					currentY = currentY = style.getStyleInt("padding-top");
					currentX += style.getStyleInt("break") + columnWidth[currentColumn];
				}
			}
		}
	}

}