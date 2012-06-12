package org.liekkas.haoq.llk.models
{
	import org.liekkas.haoq.llk.controllers.events.LLKEvent;
	import org.robotlegs.mvcs.Actor;
	
	public class TopBarModel extends Actor
	{
		protected var _score:int;

		public function get score():int
		{
			return _score;
		}

		public function set score(value:int):void
		{
			_score = value;
			dispatch(new LLKEvent(LLKEvent.SCORE_CHANGED));
		}

		protected var _state:int = 1;

		public function get state():int
		{
			return _state;
		}

		public function set state(value:int):void
		{
			_state = value;
			dispatch(new LLKEvent(LLKEvent.NEXT_STATE));
		}

	}
}