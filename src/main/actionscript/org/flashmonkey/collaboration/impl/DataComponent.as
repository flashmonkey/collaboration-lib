package org.flashmonkey.collaboration.impl
{
	import org.flashmonkey.collaboration.api.IDataComponent;
	import org.flashmonkey.collaboration.api.IDisplayComponent;
	import org.flashmonkey.operations.service.IOperation;

	public class DataComponent extends AbstractComponent implements IDataComponent
	{		
		public function DataComponent()
		{
		}
		
		public function applyPropertyValue(key:Object, value:*, component:IDisplayComponent):IOperation
		{
			return null;
		}
	}
}