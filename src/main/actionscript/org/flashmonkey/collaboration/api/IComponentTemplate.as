package org.flashmonkey.collaboration.api
{
	import mx.collections.IList;
	import mx.utils.ObjectProxy;

	[Bindable] public interface IComponentTemplate
	{
		function get id():int;
		function set id(value:int):void;
		
		function get authoringLibraryId():int;
		function set authoringLibraryId(value:int):void;
		
		function get custom():Boolean;
		function set custom(value:Boolean):void;
		
		function get displayName():String;
		function set displayName(value:String):void;
		
		function get events():IList;
		function set events(value:IList):void;
		
		function get templateName():String;
		function set templateName(value:String):void;
		
		function get children():IList;
		function set children(value:IList):void;
		
		function get parent():IComponentTemplate;
		function set parent(value:IComponentTemplate):void;
		
		function get primitive():IComponentPrimitive;
		function set primitive(value:IComponentPrimitive):void;
		
		function get showInDefaultDisplay():Boolean;
		function set showInDefaultDisplay(value:Boolean):void;
		
		function get writer():IComponentWriter;
		
		function get properties():ObjectProxy;
		
		function get propertyTypes():Array;
		
		function get descriptor():IComponentDescriptor;
		function set descriptor(value:IComponentDescriptor):void;
		
		function createDescriptor(level:int = 0):IComponentDescriptor;
		
		function newInstance():*;
		
		function newInspector():Object;
		
		function get feedbackClass():Class;
	}
}