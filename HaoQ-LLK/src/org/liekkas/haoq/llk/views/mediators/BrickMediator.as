package org.liekkas.haoq.llk.views.mediators
{
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	import org.liekkas.haoq.llk.controllers.events.LLKEvent;
	import org.liekkas.haoq.llk.models.BrickMapModel;
	import org.liekkas.haoq.llk.views.Brick;
	import org.robotlegs.mvcs.Mediator;
	
	public class BrickMediator extends Mediator
	{
		[Inject]
		public var view:Brick;
		[Inject]
		public var brickMapModel:BrickMapModel;
		
		override public function onRegister():void
		{
			eventMap.mapListener(view.img,MouseEvent.CLICK,onClick,MouseEvent);
		}
		
		protected function onClick(evt:MouseEvent):void
		{
			view.filters = [new GlowFilter()];
			var p:Point = view.contentToGlobal(new Point(view.mouseX,view.mouseY));
			view.brickVO.x = p.x; 
			view.brickVO.y = p.y;
			brickMapModel.check(view);
		}
	}
}