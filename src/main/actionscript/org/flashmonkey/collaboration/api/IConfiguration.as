package org.flashmonkey.collaboration.api
{
	import mx.collections.IList;
	
	import org.flashmonkey.binding.ISignalBindable;

	public interface IConfiguration extends ISignalBindable
	{		
		function get componentTemplates():IList;
		function set componentTemplates(value:IList):void;
		
		function get primitives():IList;
		function set primitives(value:IList):void;
				
		function get authoringLibraries():IList;
		function set authoringLibraries(value:IList):void;
		
		function get propertyTypes():Array;
		function set propertyTypes(value:Array):void;
		
		function get sampleDescriptor():XML;
		function set sampleDescriptor(value:XML):void;
		
		function getPropertyTypeByName(name:String):IPropertyType;
		
		function getTemplatesByType(type:ComponentType):IList;
		
		function getTemplateByPrimitiveName(name:String):IComponentTemplate;
		function getTemplateByPrimitiveId(id:int):IComponentTemplate;
		function getTemplateById(id:int):IComponentTemplate;
		function getTemplateForExtension(extension:String):IComponentTemplate;
		function getTemplateForInstance(instance:*):IComponentTemplate;
		
		function getPrimitiveById(id:int):IComponentPrimitive;
		function getPrimitiveForClassName(className:String):IComponentPrimitive;
				
		function getCompositeTemplate():IComponentTemplate;
		function getNullTransitionTemplate():IComponentTemplate;
	}
}