package org.liekkas.haoq.llk.controllers.commands
{
	import mx.controls.Alert;
	
	import org.robotlegs.mvcs.Command;
	
	/*************************************************************\
	 * 游戏结束
	 *
	 * @author liekkas.zeng
	 * @since  2012-5-31 14:08:52
	 \*************************************************************/
	public class GameOverCommand extends Command
	{
		override public function execute():void
		{
			Alert.show("完蛋了~~~！");
		}
	}
}