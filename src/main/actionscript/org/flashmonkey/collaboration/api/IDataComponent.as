package org.flashmonkey.collaboration.api
{
	import org.flashmonkey.operations.service.IOperation;

	public interface IDataComponent extends IComponent
	{
		function applyPropertyValue(key:Object, value:*, component:IDisplayComponent):IOperation;
	}
}