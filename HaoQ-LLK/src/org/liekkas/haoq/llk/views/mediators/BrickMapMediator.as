package org.liekkas.haoq.llk.views.mediators
{
	import org.liekkas.haoq.llk.controllers.events.GameEvent;
	import org.liekkas.haoq.llk.controllers.events.LLKEvent;
	import org.liekkas.haoq.llk.models.BrickMapModel;
	import org.liekkas.haoq.llk.views.BrickMap;
	import org.robotlegs.mvcs.Mediator;
	
	public class BrickMapMediator extends Mediator
	{
		[Inject]
		public var model:BrickMapModel;
		[Inject]
		public var view:BrickMap;
		
		override public function onRegister():void
		{
			view.rows = model.rows;
			view.cols = model.cols;
			view.brickHeight = model.brickHeight;
			view.brickWidth = model.brickWidth;
			view.mapData = model.dataProvider;
			
			eventMap.mapListener(eventDispatcher,LLKEvent.MAP_DATA_LOADED,onDataLoaded,LLKEvent);
		}
		
		protected function onDataLoaded(evt:LLKEvent):void
		{
			trace(" >>> onDataLoaded");
			view.rows = model.rows;
			view.cols = model.cols;
			view.brickHeight = model.brickHeight;
			view.brickWidth = model.brickWidth;
			view.mapData = model.dataProvider;
		}
	}
}
