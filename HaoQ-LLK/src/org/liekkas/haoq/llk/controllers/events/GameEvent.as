package org.liekkas.haoq.llk.controllers.events
{
	import flash.events.Event;
	
	/*************************************************************\
	 * 游戏通用事件
	 *
	 * @author liekkas.zeng
	 * @since  2012-5-31 16:16:41
	 \*************************************************************/
	public class GameEvent extends Event
	{
		/**
		 * 闯关成功
		 * */
		public static const GAME_PASS:String = "GameEvent.GAME_PASS";
		
		/**
		 * 游戏结束
		 * */
		public static const GAME_OVER:String = "GameEvent.GAME_OVER";
		
		public function GameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new GameEvent(type,bubbles,cancelable);
		}
	}
}