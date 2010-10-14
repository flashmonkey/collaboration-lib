package org.flashmonkey.collaboration.impl
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import org.as3commons.lang.DictionaryUtils;
	
	import org.flashmonkey.operations.service.IOperation;

	public class Component
	{
		private var _eventDispatcher:IEventDispatcher = new EventDispatcher();
		
		private var _operationsMap:Dictionary = new Dictionary();
		
		public function Component()
		{
		}
		
		public function registerOperation(event:String, operation:IOperation):void 
		{
			if (DictionaryUtils.containsKey(_operationsMap, event))
			{
				_operationsMap[event] = [];
			}
			
			(_operationsMap[event] as Array).push(operation);
			_eventDispatcher.addEventListener(event, triggerOperation);
		}
		
		public function unregisterOperation(event:String, operation:IOperation):void 
		{
			if (DictionaryUtils.containsKey(_operationsMap, event))
			{
				var operations:Array = _operationsMap[event] as Array;
				
				for (var i:int = 0; i < operations.length; i++)
				{
					var o:IOperation = IOperation(operations[i]);
					
					if (o == operation)
					{
						operations.splice(i, 1);
						break;
					}
				}
			}
		}
		
		private function triggerOperation(e:Event):void 
		{
			if (DictionaryUtils.containsKey(_operationsMap, e.type))
			{
				var operations:Array = (_operationsMap[e.type] as Array);
				
				for each (var operation:IOperation in operations)
				{
					operation.execute();
				}
			}
		}
	}
}