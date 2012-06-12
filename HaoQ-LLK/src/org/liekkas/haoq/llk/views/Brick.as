package org.liekkas.haoq.llk.views
{
	import mx.containers.Canvas;
	import mx.controls.Image;
	
	import org.liekkas.haoq.llk.models.vos.BrickVO;
	import mx.effects.Fade;
	import mx.effects.Resize;
	
	public class Brick extends Canvas
	{
		public var image:Class;
		
		public var img:Image = new Image();
		
		public var brickVO:BrickVO = new BrickVO();
		
		public function Brick()
		{
			super();
			
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			if(image)
			{
//				this.width = 96;
//				this.height = 72;
				
				this.setStyle("borderColor",0x6699dd);
				this.setStyle("borderThickness",1);
				this.setStyle("borderStyle","solid");
				
				img.source = image;
				img.scaleContent="true";
				img.maintainAspectRatio="true";
				img.percentHeight = img.percentWidth = 100;
				img.buttonMode = true;
				var fadeOut:Fade=new Fade();
				fadeOut.duration=500;
				fadeOut.alphaFrom=1.0;
				fadeOut.alphaTo=0.0;
				
				var fadeIn:Fade=new Fade();
				fadeIn.duration=1000;
				fadeIn.alphaFrom=0.0;
				fadeIn.alphaTo=1.0;
				
				img.setStyle("removedEffect",fadeOut);
				img.setStyle("addedEffect",fadeIn);
				
				this.addChild(img);
			}
		}
		
		public function clear():void
		{
			brickVO.imgValue = -1;
			this.removeChild(img);
		}
	}
}