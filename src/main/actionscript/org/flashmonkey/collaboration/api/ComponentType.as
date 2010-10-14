package org.flashmonkey.collaboration.api
{
	public class ComponentType
	{
		public static const COMPONENT_TYPE		:String = "component";
		public static const TRANSITION_TYPE		:String = "transition";
		public static const DATA_TYPE			:String = "data";
		public static const OPERATION_TYPE		:String = "operation";
		
		public static const COMPONENT			:ComponentType = new ComponentType(COMPONENT_TYPE);
		public static const TRANSITION			:ComponentType = new ComponentType(TRANSITION_TYPE);	
		public static const DATA				:ComponentType = new ComponentType(DATA_TYPE);
		public static const OPERATION			:ComponentType = new ComponentType(OPERATION_TYPE);
		
		private static var _enumCreated:Boolean = false;
		
		{
			_enumCreated = true;
		}
		
		private var _name:String;
		
		public function ComponentType(name:String) 
		{
			if (_enumCreated)
				throw new Error("The enum is already created.");
			
			_name = name;
		}
		
		public function get value():String 
		{
			return _name;
		}
		
		public static function forValue(value:String):ComponentType
		{
			switch (value)
			{
				case COMPONENT_TYPE:
					return COMPONENT;
					
				case TRANSITION_TYPE:
					return TRANSITION;
					
				default:
					throw new Error("There is no ComponentType for value supplied - '" + value + "'");
			}
		}
	}
}