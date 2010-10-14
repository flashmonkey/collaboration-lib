package org.flashmonkey.collaboration.impl
{
	import org.flashmonkey.collaboration.api.DisplayPhase;
	import org.flashmonkey.collaboration.api.IDisplayComponent;
	
	public class NullTransition extends AbstractTransition
	{
		public override function set duration(value:Number):void
		{
			
		}
		
		public function NullTransition()
		{
		}
		
		public override function resolve(target:IDisplayComponent, begin:Number, end:Number, duration:Number, playhead:Number):void
		{			
			if (target.displayPhase == DisplayPhase.DISPLAYING)
			{
				target.alpha = 1;
			}
			else
			{
				target.alpha = 0;
			}
		}
	}
}