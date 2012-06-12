package org.liekkas.haoq.llk.views
{
	import flash.geom.Point;
	
	import mx.containers.HBox;
	import mx.containers.VBox;
	
	import org.liekkas.haoq.llk.models.vos.BrickVO;
	import org.liekkas.haoq.llk.utils.ImageConsts;
	
	/*************************************************************\
	 * 地图
	 *
	 * @author liekkas.zeng
	 * @since  2012-6-1 9:51:59
	 \*************************************************************/
	public class BrickMap extends VBox
	{
		protected var _mapData:Array;
		
		protected var brickArr:Array;
		
		public var rows:int;
		public var cols:int;
		public var brickWidth:Number = 96;
		public var brickHeight:Number = 72;
		
		protected var dataChanged:Boolean = false;;
		
		public function set mapData(value:Array):void
		{
			_mapData = value;
			dataChanged = true;
			invalidateProperties();
		}
		
		protected function draw():void
		{
			for(var i:int;i<rows;i++)
			{
				var hbox:HBox = new HBox();
				var hArr:Array = [];
				for(var j:int=0;j<cols;j++)
				{
					var brick:Brick = new Brick();
					brick.brickVO.row = i;
					brick.brickVO.col = j;
					brick.brickVO.imgValue = _mapData[i][j];
					brick.image = ImageConsts.convert(_mapData[i][j]);
					if(brick.image)
					{
						brick.width = brickWidth;
						brick.height = brickHeight;
					}
					else
					{
						brick.width = 8;
						brick.height = 6;
					}
					hbox.addChild(brick);
					hArr.push(brick);
				}
				this.addChild(hbox);
				brickArr.push(hArr);
			}
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(dataChanged)
			{
				this.removeAllChildren();
				brickArr = [];
				draw();
				dataChanged = false;
			}
		}
	}
}