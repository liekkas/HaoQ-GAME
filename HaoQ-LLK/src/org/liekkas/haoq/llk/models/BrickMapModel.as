package org.liekkas.haoq.llk.models
{
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.core.Application;
	import mx.managers.PopUpManager;
	
	import org.liekkas.haoq.llk.controllers.events.GameEvent;
	import org.liekkas.haoq.llk.controllers.events.LLKEvent;
	import org.liekkas.haoq.llk.models.vos.BrickVO;
	import org.liekkas.haoq.llk.views.Brick;
	import org.liekkas.haoq.llk.views.GetPoint;
	import org.robotlegs.mvcs.Actor;
	
	/*********************************************
	 * 地图数据模型
	 * 
	 * @author liekkas.zeng 
	 * @since  2012-5-30 15:07:57
	 *********************************************/
	public class BrickMapModel extends Actor
	{
		protected var _dataProvider:Array;
		
		public var goodlike:Boolean = false;
		
		/**
		 * 行数
		 * */
		public var rows:int = 8; 
		 
		/**
		 * 列数
		 * */
		public var cols:int = 12;
		
		public var brickWidth:Number = 96;
		public var brickHeight:Number = 72;
		
		/**
		 * 图片数
		 * */
		public var imageNum:int = 10;
		
		/**
		 * 数据源
		 * */
		public function get dataProvider():Array
		{
			return _dataProvider;
		}

		/**
		 * 初始化数据源
		 *	 - 游戏进来时生成
		 *   - 过关了生成
		 * */
		public function init():void
		{
			_dataProvider = [];
			var tempArr:Array = [];
			//总共多少对数 --这些要成对出现的
			var totalPairs:int = (rows-2)*(cols-2)*0.5;
			for(var i:int = 0;i < totalPairs;i ++)
			{
				var r:int = Math.round(Math.random()*imageNum);
				tempArr.push(r,r);
			}
			tempArr.sort(randomSort);
			
			var zeroArr:Array = [];
			for(i = 0;i < cols;i ++)
			{
				zeroArr.push(-1);
			}
			_dataProvider.push(zeroArr);
			for(i = 0;i < rows-2;i++)
			{
				var arr:Array = [];
				arr.push(-1);
				for(var j:int = 0;j < cols-2;j++)
				{
					arr.push(tempArr[i*(cols-2)+j]);
				}
				arr.push(-1);
				_dataProvider.push(arr);
			}
			_dataProvider.push(zeroArr);
			dispatch(new LLKEvent(LLKEvent.MAP_DATA_LOADED));
		}
		
		//数组随机排序帮助函数
		public function randomSort(a:Object,b:Object):Number
		{
			return Math.pow(-1,Math.floor(Math.random()*2));
		}

		/**
		 * 用于比较的数组
		 * */
		protected var compareArr:Array = [];
		
		/**
		 * 检查，只有比较数组有两个对象了才进行比较
		 * */
		public function check(value:Brick):void
		{
			if(value.brickVO.imgValue == -1) //由于点击过快，选中了不该选中的地方
			{
				value.filters = null;
				return;
			}
			
			compareArr.push(value);
			
			if(compareArr.length == 2)
			{
				compare(compareArr[0],compareArr[1]);
			}
		}
		
		public function compare(lastBrick:Brick,now:Brick):void
		{
			var success:Boolean = false;

			if(goodlike)
			{
				if(!(lastBrick.brickVO.row==now.brickVO.row
					&& lastBrick.brickVO.col == now.brickVO.col))
				{
//					if(_dataProvider[lastBrick.brickVO.row][lastBrick.brickVO.col]
//						== _dataProvider[now.brickVO.row][now.brickVO.col])
//					{
						_dataProvider[lastBrick.brickVO.row][lastBrick.brickVO.col] = -1;
						_dataProvider[now.brickVO.row][now.brickVO.col] = -1;
						lastBrick.clear();
						now.clear();
						success = true;	
						
						if(gameFinish())
						{
							dispatch(new GameEvent(GameEvent.GAME_PASS));
						}	
//					}
				}
			}
			else
			{
				if(findShortestPath(lastBrick.brickVO.row,lastBrick.brickVO.col,
					now.brickVO.row,now.brickVO.col))
				{
					_dataProvider[lastBrick.brickVO.row][lastBrick.brickVO.col] = -1;
					_dataProvider[now.brickVO.row][now.brickVO.col] = -1;
					lastBrick.clear();
					now.clear();
					success = true;	
					
					if(gameFinish())
					{
						dispatch(new GameEvent(GameEvent.GAME_PASS));
					}	
				}
			}
					
			var llk:LLKEvent = new LLKEvent(LLKEvent.REMOVE_THE_SAME);
			llk.data = [compareArr,success];
			dispatch(llk);
			compareArr = [];
		}
		
		/**
		 * 直线检测
		 * */
		public function lineCheck(r1:int,c1:int,r2:int,c2:int):Boolean
		{
			var flag:Boolean = false;
			
			if(r1 == r2 && c1 == c2)
				return false;
			
			if(r1 == r2) //同一行
			{
				if(c1 > c2) //确保小的在前面
				{
					var t:int = c1;
					c1 = c2;
					c2 = t;
				}
				
				if(c1+1 == c2) //相邻情况
					return true;
				
				for(var i:int = c1+1;i<c2;i++)
				{
					if(_dataProvider[r1][i]>-1)
						return false;
				}
				
				return true;
			}
			else if(c1 == c2) //同一列
			{
				if(r1 > r2) //确保小的在前面
				{
					var t:int = r1;
					r1 = r2;
					r2 = t;
				}
				
				if(r1+1 == r2) //相邻情况
					return true;
				
				for(var i:int = r1+1;i<r2;i++)
				{
					if(_dataProvider[i][c1]>-1)
						return false;
				}
				
				return true;
			}
			
			return false; //不在同一条线
		}
		
		/**
		 * 判断是否结束
		 * 只要_dataProvider里面全是-1就说明过关了
		 * */
		public function gameFinish():Boolean
		{
			for each(var row:Array in _dataProvider)
			{
				for each(var value:int in row)
				{
					if(value != -1)
						return false;
				}
			}
			
			return true;
		}
		
		/**
		 * 寻找最短路径，并记录下来
		 * */
		protected function findShortestPath(r1:int,c1:int,r2:int,c2:int):Boolean
		{
			/**
			 * 两点内容不同
			 * */
			if(_dataProvider[r1][c1] != _dataProvider[r2][c2])
				return false;
			
			/**
			 * 两点重复
			 * */
			if(r1 == r2 && c1 == c2)
				return false;
			
			var i:int;
			
			var result:Boolean;
			
			/**
			 * 两点处于同一行
			 * */
			if(r1 == r2)
			{
				if(lineCheck(r1,c1,r2,c2)) //直线最短
				{
					addRoadPoint(r1,c1,r1,c1+1,r1,c2-1,r1,c2);
					return true;
				}
				
				for(i = 0;i < rows;i++)
				{
					if(_dataProvider[i][c1]== -1 && _dataProvider[i][c2]== -1)
					{
						if(lineCheck(r1,c1,i,c1) && lineCheck(i,c1,i,c2) && lineCheck(i,c2,r2,c2))
						{
							result = true;                        
							roadPointCount(r1,c1,i,c1,i,c2,r2,c2);
						}
					}
				}

			}
			else if(c1 == c2)
			{
				if(lineCheck(r1,c1,r2,c2)) //直线最短
				{
					addRoadPoint(r1,c1,r1,c1+1,r1,c2-1,r1,c2);
					return true;
				}
				
				for(i = 0;i < cols;i++)
				{
					if(_dataProvider[r1][i]== -1 && _dataProvider[r2][i]== -1)
					{
						if(lineCheck(r1,c1,r1,i) && lineCheck(r1,i,r2,i) && lineCheck(r2,i,r2,c2))
						{
							result = true;                        
							roadPointCount(r1,c1,i,c1,i,c2,r2,c2);
						}
					}
				}
			}
			else
			{
				if(c1>c2) //确保列小的在前面
				{
					var t:int = c1;
					c1 = c2;
					c2 = t;
					
					var w:int = r1;
					r1 = r2;
					r2 = w;
				}
				
				/**
				 *   -1 -1 -1 -1 -1 -1
				 *   -1 -1  0 -1 -1 -1
				 *   -1 -1 -1 -1  0 -1
				 *   -1 -1 -1 -1 -1 -1
				 * */
				/**
				 * 判断水平向
				 * */
				for(i = 0;i < rows;i ++)
				{   
					if(_dataProvider[i][c1] == -1 && _dataProvider[i][c2] == -1)
					{
						if(i == r1 && _dataProvider[r1][c2]== -1) //只有一个拐角右上
						{
							if(lineCheck(r1,c1,r1,c2) && lineCheck(r1,c2,r2,c2))
							{
								result = true;
								roadPointCount(r1,c1,r1,c2,r1,c2,r2,c2);
							}
						}
						else if(i == r2 && _dataProvider[r2][c1] == -1) //只有一个拐角左下
						{
							if(lineCheck(r1,c1,r2,c1) && lineCheck(r2,c1,r2,c2))
							{
								result = true;
								roadPointCount(r1,c1,r2,c1,r2,c1,r2,c2);
							}
						}
						else if(lineCheck(r1,c1,i,c1) && lineCheck(i,c1,i,c2) && lineCheck(i,c2,r2,c2))
						{
							result = true;                        
							roadPointCount(r1,c1,i,c1,i,c2,r2,c2);
						}
					}
				}                
				
				/**
				 *   -1 -1 -1 -1 -1 -1
				 *   -1 -1  0 -1 -1 -1
				 *   -1 -1 -1 -1  0 -1
				 *   -1 -1 -1 -1 -1 -1
				 * */
				/**
				 * 判断垂直向
				 * */
				for(i = 0;i < cols;i++)
				{
					if(i == c1 && _dataProvider[r2][i] == -1)
					{	
						if(lineCheck(r1,c1,r2,c1) && lineCheck(r2,c1,r2,c2))//只有一个拐角
						{
							result = true;
							roadPointCount(r1,c1,r2,c1,r2,c1,r2,c2);
						}
					}
					else if(i == c2 && _dataProvider[r1][i] == -1)
					{	
						if(lineCheck(r1,c1,r1,c2) && lineCheck(r1,c2,r2,c2))//只有一个拐角
						{
							result = true;
							roadPointCount(r1,c1,r1,c2,r1,c2,r2,c2);
						}
					}
					else if(_dataProvider[r1][i] == -1 && _dataProvider[r2][i]== -1)
					{
						if(lineCheck(r1,c1,r1,i) && lineCheck(r1,i,r2,i) && lineCheck(r2,i,r2,c2))
						{
							result = true;
							roadPointCount(r1,c1,r1,i,r2,i,r2,c2);
						}
					}
				}                
			}
			return result;
		}
		
		//记录路径数组
		private var roadPoint:Array = [-1,-1,-1,-1,-1,-1,-1,-1];
		
		/**
		 * 记录路径的四个点
		 * */
		private function addRoadPoint(r1:int,c1:int,r2:int,c2:int,r3:int,c3:int,r4:int,c4:int):void
		{
			roadPoint[0] = r1;
			roadPoint[1] = c1;
			roadPoint[2] = r2;
			roadPoint[3] = c2;
			roadPoint[4] = r3;
			roadPoint[5] = c3;
			roadPoint[6] = r4;
			roadPoint[7] = c4;            
		}

		private var minRoadPoint:uint = 10000;//当前最短路径格数

		//始终记录最短的路线的路径点
		private function roadPointCount(r1:int,c1:int,r2:int,c2:int,r3:int,c3:int,r4:int,c4:int):void
		{
			var count:uint = 0;
			count = Math.abs(c2-c1) + Math.abs(c3-c2) + Math.abs(c4-c3) + Math.abs(r2-r1) + Math.abs(r3-r2) + Math.abs(r4-r3);
			if(count < minRoadPoint){
				addRoadPoint(r1,c1,r2,c2,r3,c3,r4,c4);
				minRoadPoint = count;
			}
		}

	}
}