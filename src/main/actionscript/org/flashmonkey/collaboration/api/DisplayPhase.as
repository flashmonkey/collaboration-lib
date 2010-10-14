package org.flashmonkey.collaboration.api
{
	public class DisplayPhase
	{
		public static const BEFORE_TRANSITION_IN_VALUE:String = "BeforeTransitionIn";
		public static const DURING_TRANSITION_IN_VALUE:String = "DuringTransitionIn";
		public static const DISPLAYING_VALUE:String = "Displaying";
		public static const DURING_TRANSITION_OUT_VALUE:String = "DuringTransitionOut";
		public static const AFTER_TRANSITION_OUT_VALUE:String = "AfterTransitionOut"; 
		
		public static const BEFORE_TRANSITION_IN:DisplayPhase = new DisplayPhase(BEFORE_TRANSITION_IN_VALUE);
		public static const DURING_TRANSITION_IN:DisplayPhase = new DisplayPhase(DURING_TRANSITION_IN_VALUE);
		public static const DISPLAYING:DisplayPhase = new DisplayPhase(DISPLAYING_VALUE);
		public static const DURING_TRANSITION_OUT:DisplayPhase = new DisplayPhase(DURING_TRANSITION_OUT_VALUE);
		public static const AFTER_TRANSITION_OUT:DisplayPhase = new DisplayPhase(AFTER_TRANSITION_OUT_VALUE);
		
		private static var _enumCreated:Boolean = false;
		
		{
			_enumCreated = true;
		}
		
		private var _name:String;
		
		public function DisplayPhase(name:String) 
		{
			if (_enumCreated)
			{
				throw new Error("The enum is already created.");
			}
			
			_name = name;
		}
		
		public function getValue():String 
		{
			return _name;
		}
		
		public static function forValue(value:String):DisplayPhase
		{
			switch (value)
			{
				case BEFORE_TRANSITION_IN_VALUE:
					return BEFORE_TRANSITION_IN;
					
				case DURING_TRANSITION_IN_VALUE:
					return DURING_TRANSITION_IN;
					
				case DISPLAYING_VALUE:
					return DISPLAYING;
					
				case DURING_TRANSITION_OUT_VALUE:
					return DURING_TRANSITION_OUT;
					
				case AFTER_TRANSITION_OUT_VALUE:
					return AFTER_TRANSITION_OUT;
					
				default:
					return null;
			}
		}
	}
}