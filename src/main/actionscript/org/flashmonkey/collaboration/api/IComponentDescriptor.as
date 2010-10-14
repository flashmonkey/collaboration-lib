package org.flashmonkey.collaboration.api
{
	import flash.geom.Rectangle;
	
	import mx.collections.IList;
	import mx.utils.ObjectProxy;
	
	import org.flashmonkey.binding.ISignalBindable;

	[Bindable] public interface IComponentDescriptor
	{
		/**
		 * Database id. 
		 * Not necessarily needed here at the moment but fuck it, why not.
		 */
		function get id():int;
		function set id(value:int):void;
		
		/**
		 * Name used in the timeline and elsewhere for this descriptor.
		 * This name can change during the lifetime of the descriptor.
		 */
		function get displayName():String;
		function set displayName(value:String):void;
		
		/**
		 * Name used by the system to identify this descriptor.
		 * This name will not change during the lifetime of the descriptor.
		 */
		function get instanceName():String;
		function set instanceName(value:String):void;
		
		/**
		 * The IComponentTemplate instance that this descriptor is an instance of.
		 */
		function get template():IComponentTemplate;
		function set template(value:IComponentTemplate):void;
		
		/**
		 * The date the descriptor was created.
		 */
		function get created():String;
		function set created(value:String):void;
				   
		/**
		 * The date the descriptor was last updated.
		 */
		function get updated():String;
		function set updated(value:String):void;
		
		/**
		 * Property/value list to be used for initializing instances of this component.
		 * We use an ObjectProxy because it will dispatch PropertyChangeEvents on any property
		 * change, yet it's dynamic and doesn't constrain us to a fixed set of properties.
		 */
		function get properties():ObjectProxy;
		function set properties(value:ObjectProxy):void;
		
		/**
		 * The list of children that belong to this descriptor.
		 * If this descriptor has children then it's a 'composite' component and 
		 * shouldn't be visible on the screen itself. Composites are just containers.
		 */
		function get children():IList;
		function set children(value:IList):void;
		
		/**
		 * The descriptor this component is a child of (if any).
		 */
		function get parent():IComponentDescriptor;
		function set parent(value:IComponentDescriptor):void;
		
		/**
		 * The data component this descriptor is using to interpret property settings on the component.
		 */
		function get dataComponent():IComponentDescriptor;
		function set dataComponent(value:IComponentDescriptor):void;
		
		/**
		 * The events this descriptor can accomodate.
		 */
		function get events():IList;
		function set events(value:IList):void;
		
		/**
		 * The transitions this descriptor uses to describe its appearance/disappearance from the screen.
		 */
		function get transitions():ObjectProxy;
		function set transitions(value:ObjectProxy):void;
				
		/**
		 * Whether this descriptor is visible on the stage.
		 * This is used in the editor only, doesn't affect the component's performance when published.
		 */
		function get visible():Boolean;
		function set visible(value:Boolean):void;
		
		/**
		 * Whether this descriptor is locked on the stage.
		 * This is used in the editor only, doesn't affect the component's performance when published.
		 */
		function get locked():Boolean;
		function set locked(value:Boolean):void;
		
		/**
		 * Flags whether to keep width/height values proportional when resizing in the editor.
		 */
		function get sizeProportionally():Boolean;
		function set sizeProportionally(value:Boolean):void;
		
		/**
		 * 'true' if this model is part of a user-defined selection in the editor.
		 */
		function get selected():Boolean;
		function set selected(value:Boolean):void;
		
		/**
		 * The 'level' this descriptor is currently at in the editor hierachy.
		 * Basically a count of the number of parents this descriptor has between it and the stage.
		 */
		function get level():int;
		function set level(value:int):void;
		
		/**
		 * The video source object that's currently being edited.
		 * I really don't like this being in here as it 'should' be got 
		 * from the IEditorModel singleton but there are issues with Flex'
		 * item renderers and their re-use that make that a little complex
		 * so, for now, it's here.
		 */
		//function get video():IVideoSource;
		//function set video(value:IVideoSource):void;
		
		/**
		 * Returns the value filtered through the parents of the descriptor.
		 */
		function getNestedPropertyValue(property:String):Number;
		
		/**
		 * Returns the bounds of this descriptor on the stage 
		 * taking into account any children, children's children etc. etc.
		 */
		function measure():Rectangle;
		
		/**
		 * Returns an exact copy of this descriptor.
		 */
		function clone():IComponentDescriptor;
	}
}