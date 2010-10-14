package org.flashmonkey.collaboration.impl
{
	import org.flashmonkey.collaboration.api.IDisplayComponent;
	import org.flashmonkey.collaboration.api.ITransition;
	import org.flashmonkey.collaboration.api.TransitionDirection;
	
	public class AbstractTransition extends AbstractComponent implements ITransition
	{
		protected var _direction:TransitionDirection
		
		public function get direction():TransitionDirection
		{
			return _direction;
		}
		
		public function set direction(value:TransitionDirection):void 
		{
			_direction = value;
		}
		
		protected var _duration:Number = 0.0;

		public function get duration():Number 
		{
			return _duration;
		}
		
		public function set duration(value:Number):void
		{
			_duration = value;
		}
		
		public function AbstractTransition()
		{
			super();
		}
		
		public function resolve(target:IDisplayComponent, begin:Number, end:Number, duration:Number, playhead:Number):void
		{
		}
	}
}