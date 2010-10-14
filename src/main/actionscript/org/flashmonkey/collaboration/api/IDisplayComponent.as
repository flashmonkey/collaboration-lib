package org.flashmonkey.collaboration.api
{
	import flash.events.Event;
	
	import org.flashmonkey.operations.service.IOperation;

    /**
     * An IDisplayComponent implementation is eligible for special treatment by the
     * QTV framework.  It will be explicitly notified when it should update its appearance. 
     */
    public interface IDisplayComponent extends IComponent
    {
		function get id():Number;
		function set id(value:Number):void;
		
        /**
         * Width of this component.
         */        
        function get width():Number;
        function set width(value:Number):void;

        /**
         * Height of this component. 
         */
        function get height():Number;
        function set height(value:Number):void;
        
        /**
         * X position of this component. 
         */
        function get x():Number;
        function set x(value:Number):void;

        /**
         * Y position of this component. 
         */
        function get y():Number;
        function set y(value:Number):void;
		
		function get alpha():Number;
		function set alpha(value:Number):void;
		
		function get visible():Boolean;
		function set visible(value:Boolean):void;
		
		/**
		 * The type of transition to use for this component.
		 */
		function get IN():ITransition;
		function get OUT():ITransition;
		
		/**
		 * The current time of the playhead.
		 */
		function get playheadTime():Number;
		function set playheadTime(value:Number):void;
		
		/**
		 * The duration of the video this component is currently running in.
		 */
		function get duration():Number;
		function set duration(value:Number):void;
		
		/**
		 * The time at which this component needs to be active (any transitions should complete at this point).
		 */
		function get begin():Number;
		function set begin(value:Number):void;
		
		/**
		 * The time at which this component needs to be inactive (any transitions should start at this point).
		 */
		function get end():Number;
		function set end(value:Number):void;
		
		function set componentService(value:IComponentService):void;
		
		function applyPropertyValue(name:Object, value:*):void;
		
		function registerOperation(type:String, operation:IOperation):void;
		
		function handleEvent(e:Event):void;
		
		function get dataComponent():IDataComponent;
		function set dataComponent(value:IDataComponent):void; 
		
		function get includeInLayout():Boolean;
		function set includeInLayout(value:Boolean):void;
		
		function get sizeProportionally():Boolean;
		function set sizeProportionally(value:Boolean):void;
        
        /**
         * Called by the SiteBuilder framework whenever a property other than x or y 
         * is updated; an implementation of IDisplayComponent should completely rebuild itself
         * and any child objects from its current property values when this function is called.
         */
        function updateDisplayPhase():void;
		
		function get displayPhase():DisplayPhase;
    }
}