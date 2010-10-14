package org.flashmonkey.collaboration.impl
{
	import org.flashmonkey.collaboration.api.IComponent;
	import org.flashmonkey.collaboration.api.IComponentContext;

	public class ComponentContext implements IComponentContext
	{
		private var _editing:Boolean;
		
		public function get editing():Boolean
		{
			return _editing;
		}
		
		private var _previewing:Boolean;
		
		public function get previewing():Boolean
		{
			return _previewing;
		}
		
		private var _components:Array = [];
		
		public function get components():Array 
		{
			return _components;
		}
		
		public function set components(value:Array):void 
		{
			_components = value;
		}
		
		private var _domain:String;
		
		public function get domain():String 
		{
			return _domain;
		}
		public function set domain(value:String):void 
		{
			_domain = value;
		}
		
		public function ComponentContext(editing:Boolean, previewing:Boolean, components:Array, domain:String)
		{
			_editing = editing;
			_previewing = previewing;
			_components = components;
			_domain = domain;
		}
		
		public function getComponentById():IComponent
		{
			return null;
		}
	}
}