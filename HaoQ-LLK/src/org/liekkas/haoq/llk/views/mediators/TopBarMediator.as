package org.liekkas.haoq.llk.views.mediators
{
	import flash.events.MouseEvent;
	
	import org.liekkas.haoq.llk.controllers.events.LLKEvent;
	import org.liekkas.haoq.llk.models.BrickMapModel;
	import org.liekkas.haoq.llk.models.TopBarModel;
	import org.liekkas.haoq.llk.views.TopBar;
	import org.robotlegs.mvcs.Mediator;
	
	public class TopBarMediator extends Mediator
	{
		[Inject]
		public var view:TopBar;
		[Inject]
		public var model:TopBarModel;
		[Inject]
		public var brickmapModel:BrickMapModel;
		
		override public function onRegister():void
		{
			eventMap.mapListener(eventDispatcher,LLKEvent.SCORE_CHANGED,onScoreChanged,LLKEvent);
			eventMap.mapListener(eventDispatcher,LLKEvent.NEXT_STATE,onNextState,LLKEvent);
			eventMap.mapListener(view.btn,MouseEvent.CLICK,onClick,MouseEvent);
		}
		
		protected function onScoreChanged(evt:LLKEvent):void
		{
			view.score.text = "得分：" + model.score;
		}
		
		protected function onNextState(evt:LLKEvent):void
		{
			var str:String = model.state > 3 ? "关：好吧，你现初出厨房":"关：还是初出茅庐";
			
			view.curstate.text = "第" + model.state + str;
		}
		
		protected function onClick(evt:MouseEvent):void
		{
			if(view.btn.label == "拥有上帝之手")
			{
				brickmapModel.goodlike = true;
				view.btn.label = "返回正常模式";
			}
			else
			{
				brickmapModel.goodlike = false;
				view.btn.label = "拥有上帝之手"
			}
		}
	}
}