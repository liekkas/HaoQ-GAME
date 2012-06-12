package org.liekkas.haoq.llk.views
{
	import flash.text.TextField;
	
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.core.UIComponent;
	
	import org.liekkas.haoq.llk.utils.ImageConsts;
	
	public class GetPoint extends UIComponent
	{
		
		public function GetPoint()
		{
			super();
			
			var img:Image = new Image();
			img.source = ImageConsts.OK;
			this.addChild(img);
			
//			var txt:Label = new Label();
//			txt.text = "+10";
//			txt.setStyle("fontSize",20);
//			txt.setStyle("color",0xffffff);
//			this.addChild(txt);
		}
	}
}