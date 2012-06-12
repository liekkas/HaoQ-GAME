package org.liekkas.haoq.llk.controllers.bootstraps
{
	
	import org.liekkas.haoq.llk.controllers.commands.GameOverCommand;
	import org.liekkas.haoq.llk.controllers.commands.GamePassCommand;
	import org.liekkas.haoq.llk.controllers.commands.RemoveTheSameCommand;
	import org.liekkas.haoq.llk.controllers.commands.StartupCompleteCommand;
	import org.liekkas.haoq.llk.controllers.events.GameEvent;
	import org.liekkas.haoq.llk.controllers.events.LLKEvent;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.core.ICommandMap;

	/*************************************************************\
	 * 控制类映射关系
	 *
	 * @author liekkas.zeng
	 * @since  2012-5-31 16:00:13
	\*************************************************************/
	public class BootstrapControllers
	{
		public function BootstrapControllers(commandMap:ICommandMap)
		{
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, StartupCompleteCommand, ContextEvent  , true);
				
			commandMap.mapEvent(LLKEvent.REMOVE_THE_SAME,RemoveTheSameCommand,LLKEvent);
			
			commandMap.mapEvent(GameEvent.GAME_PASS,GamePassCommand,GameEvent);
			commandMap.mapEvent(GameEvent.GAME_OVER,GameOverCommand,GameEvent);
		}
	}
}