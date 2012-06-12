package org.liekkas.haoq.llk.controllers.commands
{
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	import org.liekkas.haoq.llk.models.BrickMapModel;
	import org.liekkas.haoq.llk.models.TopBarModel;
	import org.robotlegs.mvcs.Command;
	
	/*************************************************************\
	 * 游戏过关
	 *
	 * @author liekkas.zeng
	 * @since  2012-5-31 14:08:52
	 \*************************************************************/
	public class GamePassCommand extends Command
	{
		[Inject]
		public var brickmapModel:BrickMapModel;
		[Inject]
		public var topbarModel:TopBarModel;
		
		override public function execute():void
		{
			Alert.okLabel = "~下一关~";
			Alert.cancelLabel = "不玩";
			Alert.show("牛逼！不解释！","恭喜！",Alert.OK,null,closeFunc);
		}
		
		protected function closeFunc(evt:CloseEvent):void
		{
			if(evt.detail == Alert.OK)
			{
				brickmapModel.rows += 2;
				brickmapModel.cols += 2;
				
				brickmapModel.brickWidth = (brickmapModel.brickWidth+10)*(brickmapModel.cols-2)/brickmapModel.cols - 12;
				brickmapModel.brickHeight = (brickmapModel.brickHeight+8)*(brickmapModel.rows-2)/brickmapModel.rows - 10;
				
				brickmapModel.init();
				
				topbarModel.state ++;
			}
			else
			{
				
			}
		}
	}
}