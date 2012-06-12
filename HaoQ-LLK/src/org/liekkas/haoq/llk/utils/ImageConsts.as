package org.liekkas.haoq.llk.utils
{
	public class ImageConsts
	{
		[Embed(source="assets/images/小2.jpg")]
		public static var NUM_1:Class;
		
		[Embed(source="assets/images/小3.jpg")]
		public static var NUM_2:Class;
		
		[Embed(source="assets/images/小4.jpg")]
		public static var NUM_3:Class;
		
		[Embed(source="assets/images/小5.jpg")]
		public static var NUM_4:Class;
		
		[Embed(source="assets/images/小6.jpg")]
		public static var NUM_5:Class;
		
		[Embed(source="assets/images/小7.jpg")]
		public static var NUM_6:Class;
		
		[Embed(source="assets/images/小8.jpg")]
		public static var NUM_7:Class;
		
		[Embed(source="assets/images/小9.jpg")]
		public static var NUM_8:Class;
		
		[Embed(source="assets/images/小10.jpg")]
		public static var NUM_9:Class;
		
		[Embed(source="assets/images/小0.jpg")]
		public static var NUM_0:Class;
		
		[Embed(source="assets/images/my.jpg")]
		public static var NUM_10:Class;
		
		[Embed(source="assets/images/mr0.jpg")]
		public static var NUM_11:Class;
		
		[Embed(source="assets/images/小1.jpg")]
		public static var NUM_12:Class;
		
		[Embed(source="assets/images/ok.png")]
		public static var OK:Class;
		
		[Embed(source="assets/images/fail.png")]
		public static var FAIL:Class;
		
		
		public static function convert(value:int):Class
		{
			switch(value)
			{
				case 0:
					return NUM_0;
					break;
				case 1:
					return NUM_1;
					break;
				case 2:
					return NUM_2;
					break;
				case 3:
					return NUM_3;
					break;
				case 4:
					return NUM_4;
					break;
				case 5:
					return NUM_5;
					break;
				case 6:
					return NUM_6;
					break;
				case 7:
					return NUM_7;
					break;
				case 8:
					return NUM_8;
					break;
				case 9:
					return NUM_9;
					break;
				case 10:
					return NUM_12;
					break;
			}
			return null;
		}
	}
}