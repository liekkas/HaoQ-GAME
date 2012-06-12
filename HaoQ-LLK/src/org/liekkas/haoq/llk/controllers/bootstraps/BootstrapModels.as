package org.liekkas.haoq.llk.controllers.bootstraps
{
	
	import org.liekkas.haoq.llk.models.BrickMapModel;
	import org.liekkas.haoq.llk.models.TopBarModel;
	import org.liekkas.haoq.llk.views.GetPoint;
	import org.robotlegs.core.IInjector;

	/*************************************************************\
	 * 模型类映射关系
	 *
	 * @author liekkas.zeng
	 * @since  2012-5-31 16:06:15
	\*************************************************************/
	public class BootstrapModels
	{
		public function BootstrapModels(inject:IInjector)
		{
			inject.mapSingleton(TopBarModel);
			inject.mapSingleton(BrickMapModel);
			inject.mapSingleton(GetPoint);
		}
	}
}