package org.liekkas.haoq.llk.controllers.commands
{
	import org.liekkas.haoq.llk.models.BrickMapModel;
	import org.robotlegs.mvcs.Command;
	
	public class StartupCompleteCommand extends Command
	{
		[Inject]
		public var brickmapModel:BrickMapModel;
		
		override public function execute():void
		{
			brickmapModel.init();
		}
	}
}