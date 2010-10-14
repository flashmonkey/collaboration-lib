package org.flashmonkey.collaboration.api
{
	import flash.events.IEventDispatcher;	

	public interface IComponent extends IEventDispatcher
	{
		function get instanceName():String;
		function set instanceName(value:String):void;
		
		function get context():IComponentContext;
		function set context(value:IComponentContext):void;
	}
}