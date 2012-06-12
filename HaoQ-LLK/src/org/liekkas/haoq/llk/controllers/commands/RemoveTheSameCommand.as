package org.liekkas.haoq.llk.controllers.commands
{
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.managers.PopUpManager;
	
	import org.liekkas.haoq.llk.controllers.events.LLKEvent;
	import org.liekkas.haoq.llk.models.TopBarModel;
	import org.liekkas.haoq.llk.utils.ImageConsts;
	import org.liekkas.haoq.llk.views.Brick;
	import org.liekkas.haoq.llk.views.GetPoint;
	import org.robotlegs.mvcs.Command;
	
	public class RemoveTheSameCommand extends Command
	{
		[Inject]
		public var event:LLKEvent;
		[Inject]
		public var gp:GetPoint;
		[Inject]
		public var topbarModel:TopBarModel;
		
		private var effectTimer:Timer = new Timer(200);
		
		override public function execute():void
		{
			PopUpManager.addPopUp(gp,this.contextView);
			PopUpManager.centerPopUp(gp);
			if(gp.isPopUp)
			{
				effectTimer.addEventListener(TimerEvent.TIMER,onTimer);
				effectTimer.start();	
			}
			if(event.data[1])
				topbarModel.score += 10;
			else
				topbarModel.score -= 5;
		}
		
		
		protected function onTimer(evt:TimerEvent):void
		{
			for each(var brick:Brick in event.data[0])
			{
				brick.filters = null;
			}
			
			PopUpManager.removePopUp(gp);
			effectTimer.removeEventListener(TimerEvent.TIMER,onTimer);
			effectTimer.stop();
		}
	}
}