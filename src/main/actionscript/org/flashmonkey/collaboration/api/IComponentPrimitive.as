package org.flashmonkey.collaboration.api
{
	public interface IComponentPrimitive
	{
		function get id():int;
		function set id(value:int):void;
		
		function get displayName():String;
		function set displayName(value:String):void;
		
		function get fileTypes():String;
		function set fileTypes(value:String):void;
		
		function get feedback():String;
		function set feedback(value:String):void;
		
		function get qname():String;
		function set qname(value:String):void;
		
		function get inspector():String;
		function set inspector(value:String):void;
		
		function get writer():String;
		function set writer(value:String):void;
		
		function get name():String;
		function set name(value:String):void;
		
		function get templateType():String;
		function set templateType(value:String):void;
		
		function get supportedProperties():Array;
		function set supportedProperties(value:Array):void;
	}
}