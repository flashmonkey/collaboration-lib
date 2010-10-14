package org.flashmonkey.collaboration.impl
{
	import org.flashmonkey.collaboration.api.IPropertyType;

	public class PropertyType implements IPropertyType
	{	
		public static const NUMBER:String = "Number";
		public static const STRING:String = "String";
		
		private var _name:String;
		
		public function get name():String
		{
			return _name;
		}
		
		private var _type:String;
		
		public function get type():String
		{
			return _type;
		}
		
		public function PropertyType(name:String, type:String)
		{
			_name = name;
			_type = type;
		}
		
		public function toString():String
		{
			return "[PropertyType(" + _name + ":" + _type + ")]";
		}
	}
}