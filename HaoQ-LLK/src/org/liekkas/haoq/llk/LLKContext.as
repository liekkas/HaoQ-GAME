package org.liekkas.haoq.llk
{
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	import org.liekkas.haoq.llk.controllers.bootstraps.BootstrapModels;
	import org.liekkas.haoq.llk.controllers.bootstraps.BootstrapControllers;
	import org.liekkas.haoq.llk.controllers.bootstraps.BootstrapViews;
	import org.liekkas.haoq.llk.controllers.bootstraps.BootstrapConfigs;
	import org.liekkas.haoq.llk.controllers.bootstraps.BootstrapServices;
	
	/*************************************************************\
	 * llk框架上下文环境
	 *
	 * @author liekkas.zeng
	 * @since  2012-5-30 15:58:36
	 \*************************************************************/
	public class LLKContext extends Context
	{
		override public function startup():void
		{
			new BootstrapModels(injector);
			new BootstrapServices(injector);
			new BootstrapControllers(commandMap);
			new BootstrapViews(mediatorMap);
			new BootstrapConfigs(injector);
			
			super.startup();
		}
	}
}