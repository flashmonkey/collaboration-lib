package org.flashmonkey.collaboration.api
{
	public class TransitionDirection
	{
		private static const IN_VALUE:String = "IN";
		private static const OUT_VALUE:String = "OUT";
		
		public static const IN:TransitionDirection = new TransitionDirection(IN_VALUE);
		public static const OUT:TransitionDirection = new TransitionDirection(OUT_VALUE);
		
		private static var _enumCreated:Boolean = false;
		
		{
			_enumCreated = true;
		}
		
		private var _name:String;
		
		public function TransitionDirection(name:String) 
		{
			if (_enumCreated)
			{
				throw new Error("The enum is already created.");
			}
			
			_name = name;
		}
		
		public function get value():String 
		{
			return _name;
		}
		
		/*public function get propertyName():String 
		{
			return (_name == IN_VALUE) ? Constants.TRANSITION_IN_PROPERTY_NAME : Constants.TRANSITION_OUT_PROPERTY_NAME;
		}*/
		
		public static function forValue(value:String):TransitionDirection
		{
			if (value == IN_VALUE)
			{
				return IN;
			}
			else if (value == OUT_VALUE)
			{
				return OUT;
			}
			
			return null;
		}
		
		public function toString():String 
		{
			return value;
		}
	}
}