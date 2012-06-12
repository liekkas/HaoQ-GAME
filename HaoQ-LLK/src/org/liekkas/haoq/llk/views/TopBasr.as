package org.liekkas.haoq.llk.views
{
	import mx.containers.ApplicationControlBar;
	import mx.controls.Label;
	
	public class TopsBar extends ApplicationControlBar
	{
		protected var scoreLbl:Label;
		
		public function TopBasr()
		{
			super();
			this.dock = true;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			if(!scoreLbl)
			{
				scoreLbl = new Label();
				scoreLbl.text = "得分：";
				this.addChild(scoreLbl);
			}
		}
	}
}