package org.flashmonkey.collaboration.impl
{    
    import mx.collections.ArrayCollection;
    import mx.collections.IList;
    import mx.logging.ILogger;
    import mx.utils.ObjectProxy;
    import mx.utils.ObjectUtil;
    
    import org.as3commons.lang.ClassUtils;
    import org.flashmonkey.collaboration.api.ComponentType;
    import org.flashmonkey.collaboration.api.IComponent;
    import org.flashmonkey.collaboration.api.IComponentContext;
    import org.flashmonkey.collaboration.api.IComponentDescriptor;
    import org.flashmonkey.collaboration.api.IComponentPrimitive;
    import org.flashmonkey.collaboration.api.IComponentTemplate;
    import org.flashmonkey.collaboration.api.IComponentWriter;
    import org.flashmonkey.utils.Logger;
    import org.flashmonkey.utils.Properties;
    
	public class ComponentTemplate implements IComponentTemplate
    {		
		CONFIG::debug
		{
			/**
			 * Logger instance.
			 */
			private static const log:ILogger = Logger.getLogger(ComponentTemplate);
		}
		
		private var _id:int;
		
		public function get id():int
		{
			return _id;
		}
		public function set id(value:int):void
		{
			_id = value;
		}
		
		private var _authoringLibraryId:int;
		
		public function get authoringLibraryId():int
		{
			return _authoringLibraryId;
		}
		public function set authoringLibraryId(value:int):void
		{
			_authoringLibraryId = value;
		}
		
		private var _custom:Boolean;
		
		public function get custom():Boolean
		{
			return _custom;
		}
		public function set custom(value:Boolean):void
		{
			_custom = value;
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
		
		private var _events:IList = new ArrayCollection();
		
		public function get events():IList
		{
			return _events;
		}
		public function set events(value:IList):void
		{
			_events = value;
		}
		
		private var _templateName:String;
		
		public function get templateName():String
		{
			return _templateName;
		}
		public function set templateName(value:String):void
		{
			_templateName = value;
		}
		
		private var _children:IList = new ArrayCollection();
		
		public function get children():IList
		{
			return _children;
		}
		public function set children(value:IList):void
		{
			_children = value;
		}
		
		private var _parent:IComponentTemplate;
		
		public function get parent():IComponentTemplate
		{
			return _parent;
		}
		public function set parent(value:IComponentTemplate):void
		{
			_parent = value;
		}
		
		private var _primitive:IComponentPrimitive;
		
		public function get primitive():IComponentPrimitive
		{
			return _primitive;
		}
		public function set primitive(value:IComponentPrimitive):void
		{
			_primitive = value;
		}
		
		private var _showInDefaultDisplay:Boolean;
		
		public function get showInDefaultDisplay():Boolean
		{
			return _showInDefaultDisplay;
		}
		public function set showInDefaultDisplay(value:Boolean):void
		{
			_showInDefaultDisplay = value;
		}
		
		/**
		 * @private
		 * 
		 * The cached instance of the writer for this type of component.
		 */
		private var _writer:IComponentWriter;
		
		/**
		 * Returns the cached instance of the IComponentWriter implementation
		 * designed to write the xml for this template's component.
		 * If one doesn't exist it's created and cached.
		 */
		public function get writer():IComponentWriter
		{	
			return _writer = (_writer == null) ? _writer = ClassUtils.newInstance(ClassUtils.forName(primitive.writer)) : _writer;
		}
		
		private var _properties:ObjectProxy = new ObjectProxy();
		
		public function get properties():ObjectProxy
		{
			return _properties;
		}
		
		public var definition:Class;
		
		public var inspector:*;
		
		private var _propertyTypes:Array = [];
		
		public function get propertyTypes():Array
		{
			return _propertyTypes;
		}
        
        /**
         * ComponentDescriptor that can be used to instantiate this template as a component. 
         */
        private var _descriptor:IComponentDescriptor;
		
		public function get descriptor():IComponentDescriptor
		{
			return _descriptor;
		}
		public function set descriptor(value:IComponentDescriptor):void
		{
			_descriptor = value;	
		}
		
		/**
		 * @private 
		 * 
		 * Context injected into all components built from their template.
		 * The context ensures that components know they're in the editor.
		 */
		private var _context:IComponentContext = new ComponentContext(true, false, null, "");
		
		public function ComponentTemplate()
		{
			
		}
        
        /**
         * Create a new copy of a ComponentDescriptor for a component generated from this template. 
         */        
        public function createDescriptor(level:int = 0):IComponentDescriptor
        {				
            var desc:IComponentDescriptor = _descriptor.clone();
			desc.template = this;
			desc.level = level;
			
			desc.properties = ObjectProxy(ObjectUtil.copy(properties));
			
			for each (var child:ComponentTemplate in children)
			{
				var childDescriptor:IComponentDescriptor = child.createDescriptor(level + 1);
				
				switch (child.primitive.templateType)
				{
					case ComponentType.COMPONENT.value:
						childDescriptor.level = level + 1;
						childDescriptor.parent = desc;
						desc.children.addItem(childDescriptor);
						break;
					
					case ComponentType.TRANSITION.value:
						desc.transitions[childDescriptor.properties.direction] = childDescriptor;
						break;
					
					default:
						break;
				}
				
			}
			
            return desc;
        }
		
		/**
		 * Create a new instance of this component. 
		 */
		public function newInstance():*
		{
			if (definition == null)
			{
				// We haven't looked up the definition before: find the Class in our library's domain
				// and cache it for later use.
				try 
				{
					CONFIG::debug 
					{
						log.debug("Creating new instance of: " + primitive.qname);
					}
					
					definition = ClassUtils.forName(primitive.qname);
				}
				catch (e:Error)
				{
					throw new Error("Unable to find definition " + primitive.qname);
				}
			}
			
			var component:IComponent = new definition;
			component.context = _context;
			
			// Instantiate the Class for this asset.
			return component;
		}
		
		/**
		 * Create a new inspector instance of this SiteAsset. 
		 */
		public function newInspector():Object
		{			
			if (inspector == null)
			{				
				// Check to see that there even is an inspector class.
				if (primitive.inspector == "")
				{
					return null;
				}
				
				// We haven't looked up the inspector before: find the Class in our library's domain
				// and cache it for later use.
				//
				try 
				{
					CONFIG::debug
					{
						log.debug("Creating new inspector: " + primitive.inspector);
					}
					
					inspector = ClassUtils.forName(primitive.inspector);// ApplicationDomain.currentDomain.getDefinition(template.primitive.inspector) as Class;
				}
				catch (e:Error)
				{
					throw new Error("Unable to find definition " + primitive.inspector);
				}
			}
			
			// Instantiate the Inspector Class for this asset.
			return new inspector();
		}
		
		private var _feedbackClass:Class;
		
		/**
		 * Create a new inspector instance of this SiteAsset. 
		 */
		public function get feedbackClass():Class
		{			
			if (_feedbackClass == null)
			{
				// Check to see that there even is an inspector class.
				if (primitive.feedback == "")
				{
					return null;//primitive.feedback = Properties.instance.getProperty(Constants.DEFAULT_COMPONENT_FEEDBACK_CLASS_KEY);
				}
				
				// We haven't looked up the inspector before: find the Class in our library's domain
				// and cache it for later use.
				//
				try 
				{					
					_feedbackClass = ClassUtils.forName(primitive.feedback);
					// _inspector = library.domain.getDefinition(_feedbackName) as Class;
				}
				catch (e:Error)
				{
					throw new Error("Unable to find definition " + primitive.feedback);
				}
			}
			
			// Instantiate the Inspector Class for this asset.
			return _feedbackClass;
		}
		
		public function toString():String 
		{
			var s:String = "[ComponentTemplate:(";
			
			s += "id: " + id;
			s += ", children: " + children.length; 
			s += ", authoringLibraryId: " + authoringLibraryId;
			s += ", displayName: " + displayName;
			s += ", events: " + events;
			s += ", templateName: " + templateName;
			s += ", primitive: " + primitive;
			s += ", descriptor: " + descriptor;
			
			s += ")]";
			
			return s;
		}
    }
}