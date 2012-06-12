package org.liekkas.haoq.llk.controllers.events
{
	import flash.events.Event;
	
	public class LLKEvent extends Event
	{
		public static const MAP_DATA_LOADED:String = "LLKEvent.MAP_DATA_LOADED";
		
		public static const REMOVE_THE_SAME:String = "LLKEvent.REMOVE_THE_SAME";
		
		public static const SCORE_CHANGED:String = "LLKEvent.SCORE_CHANGED";
		
		public static const NEXT_STATE:String = "LLKEvent.NEXT_STATE";
		
		public var data:*;
		
		public function LLKEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new LLKEvent(type,bubbles,cancelable);
		}
	}
}