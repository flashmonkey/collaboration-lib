package org.flashmonkey.collaboration.api
{
   // import flash.events.IEventDispatcher;
    
    /** Dispatched whenever the active location changes. */    
    [Event(name="activeLocationChange",type="com.infrared5.sitebuilder.events.NavigationEvent")]
    
    /**
     * An IComponentContext abstracts the environment in which a runtime component lives
     * hiding the details of the surrounding engine implementation. 
     */
    public interface IComponentContext// extends IEventDispatcher
    {
        /**
         * The site prefix URL for the site in the editor's design-time environment.  This URL can be stripped
         * from any absolute URLs that are encountered at design time, and replaced at runtime with the real
         * site prefix.
         */
        //function get interactivePrefix():String;       
        
        /**
         * A flag indicating that this component is being instantiated at design time, not runtime.
         */
        function get editing():Boolean;
        
        function get previewing():Boolean;
		
		function get components():Array;
		function set components(value:Array):void;
		
		function get domain():String;
		function set domain(value:String):void;

        /**
         * The currently active location within the site. 
         */
        //[Bindable("activeLocationChange")]
        //function get activeLocation():ILocation;
    }
}