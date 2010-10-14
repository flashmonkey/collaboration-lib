package org.flashmonkey.collaboration.api
{        
    /**
     * The ITransition interface is implemented by the transition effect class.
     */
    public interface ITransition
    {        		
		function get direction():TransitionDirection;
		function set direction(value:TransitionDirection):void;
		
		function get duration():Number;
		function set duration(value:Number):void;
		
		function resolve(target:IDisplayComponent, begin:Number, end:Number, duration:Number, playhead:Number):void;
    }
}