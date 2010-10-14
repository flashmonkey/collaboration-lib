package org.flashmonkey.collaboration.impl
{
	import flash.events.EventDispatcher;
	
	import org.flashmonkey.collaboration.api.IComponent;
	import org.flashmonkey.collaboration.api.IComponentContext;

	public class AbstractComponent extends EventDispatcher implements IComponent
	{		
		public function set controlLayer(value:*):void 
		{
			
		}
		
		private var _instanceName:String;
		
		public function get instanceName():String
		{
			return _instanceName;
		}
		public function set instanceName(value:String):void
		{
			_instanceName = value;	
		}
		
		private var _context:IComponentContext;
		
		public function get context():IComponentContext
		{
			return _context;
		}
		public function set context(value:IComponentContext):void 
		{
			_context = value;
		}
		
		public function AbstractComponent()
		{
			
		}
	}
}