package org.flashmonkey.collaboration.api
{
	public interface IComponentWriter
	{
		function writeDescriptor(xml:XML, parent:IComponentDescriptor, descriptor:IComponentDescriptor, configuration:IConfiguration):XML
	}
}