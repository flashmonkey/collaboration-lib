package org.flashmonkey.collaboration.impl
{
	import org.flashmonkey.collaboration.api.IComponentPrimitive;

	public class ComponentPrimitive implements IComponentPrimitive
	{
		private var _id:int;
		
		public function get id():int
		{
			return _id;
		}
		public function set id(value:int):void
		{
			_id = value;
		}
		
		private var _displayName:String;
		
		public function get displayName():String
		{
			return _displayName;
		}
		public function set displayName(value:String):void
		{
			_displayName = value;
		}
		
		private var _fileTypes:String;
		
		public function get fileTypes():String
		{
			return _fileTypes;
		}
		public function set fileTypes(value:String):void
		{
			_fileTypes = value;
		}
		
		private var _feedback:String;
		
		public function get feedback():String
		{
			return _feedback;
		}
		public function set feedback(value:String):void
		{
			_feedback = value;
		}
		
		private var _qname:String;
		
		public function get qname():String
		{
			return _qname;
		}
		public function set qname(value:String):void
		{
			_qname = value;
		}
		
		private var _inspector:String;
		
		public function get inspector():String
		{
			return _inspector;
		}
		public function set inspector(value:String):void
		{
			_inspector = value;
		}
		
		private var _writer:String;
		
		public function get writer():String
		{
			return _writer;	
		}
		public function set writer(value:String):void
		{
			_writer = value;
		}
		
		private var _name:String;
		
		public function get name():String
		{
			return _name;
		}
		public function set name(value:String):void
		{
			_name = value;	
		}
		
		private var _templateType:String;
		
		public function get templateType():String
		{
			return _templateType;
		}
		public function set templateType(value:String):void
		{
			_templateType = value;
		}
		
		private var _supportedProperties:Array;
		
		public function get supportedProperties():Array
		{
			return _supportedProperties;
		}
		public function set supportedProperties(value:Array):void
		{
			_supportedProperties = value;
		}
		
		public function ComponentPrimitive()
		{
		}
	}
}