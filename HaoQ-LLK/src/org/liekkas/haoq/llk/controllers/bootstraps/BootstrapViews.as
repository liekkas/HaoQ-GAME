package org.liekkas.haoq.llk.controllers.bootstraps
{
	
	import org.liekkas.haoq.llk.views.Brick;
	import org.liekkas.haoq.llk.views.BrickMap;
	import org.liekkas.haoq.llk.views.TopBar;
	import org.liekkas.haoq.llk.views.mediators.BrickMapMediator;
	import org.liekkas.haoq.llk.views.mediators.BrickMediator;
	import org.liekkas.haoq.llk.views.mediators.TopBarMediator;
	import org.robotlegs.core.IMediatorMap;

	/*************************************************************\
	 * 视图类映射关系
	 *
	 * @author liekkas.zeng
	 * @since  2012-5-31 16:09:58
	 \*************************************************************/
	public class BootstrapViews
	{
		public function BootstrapViews(mediatorMap:IMediatorMap)
		{
			mediatorMap.mapView(Brick,BrickMediator);
			
			mediatorMap.mapView(BrickMap,BrickMapMediator);
			
			/**
			 * 顶部组件
			 * */
			mediatorMap.mapView(TopBar,TopBarMediator);
			
		}
	}
}