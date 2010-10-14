package org.flashmonkey.collaboration.impl.service
{
	import org.flashmonkey.operations.service.AbstractOperation;
	
	public class NullComponentOperation extends AbstractOperation
	{
		private var _value:*;
		
		public function NullComponentOperation(value:*)
		{
			super();
			
			_value = value;
		}
		
		public override function execute():void
		{
			dispatchCompleteEvent(_value);
		}
	}
}