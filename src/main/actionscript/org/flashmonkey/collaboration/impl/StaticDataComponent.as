package org.flashmonkey.collaboration.impl
{
	import org.flashmonkey.collaboration.api.IDisplayComponent;
	import org.flashmonkey.collaboration.impl.service.NullComponentOperation;
	import org.flashmonkey.operations.service.IOperation;
	
	public class StaticDataComponent extends DataComponent
	{
		public function StaticDataComponent()
		{
		}
		
		public function set dataSource(value:*):void
		{
		}
		
		public override function applyPropertyValue(key:Object, value:*, component:IDisplayComponent):IOperation
		{
			return new NullComponentOperation(value);
		}
	}
}