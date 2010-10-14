package org.flashmonkey.collaboration.impl
{
    import flash.geom.Rectangle;
    
    import mx.collections.ArrayCollection;
    import mx.collections.IList;
    import mx.utils.ObjectProxy;
    
    import org.as3commons.lang.ObjectUtils;
    import org.flashmonkey.binding.BaseSignalModel;
    import org.flashmonkey.collaboration.api.IComponentDescriptor;
    import org.flashmonkey.collaboration.api.IComponentTemplate;
    
    /**
     * A ComponentDescriptor provides enough information to create an instance of some component in a display.
     */     
    [Bindable] public class ComponentDescriptor implements IComponentDescriptor
    {		      
		public static const ID						:String = "id";
		public static const DISPLAY_NAME			:String = "displayName";
		public static const INSTANCE_NAME			:String = "instanceName";
		public static const TEMPLATE				:String = "template";
		public static const CREATED					:String = "created";
		public static const UPDATED					:String = "updated";
		public static const PROPERTIES				:String = "properties";
		public static const CHILDREN				:String = "children";
		public static const PARENT					:String = "parent";
		public static const DATA_COMPONENT			:String = "dataComponent";
		public static const EVENTS					:String = "events";
		public static const TRANSITIONS				:String = "transitions";
		public static const VISIBLE					:String = "visible";
		public static const LOCKED					:String = "locked";
		public static const SIZE_PROPORTIONALLY		:String = "sizeProportionally";
		public static const SELECTED				:String = "selected";
		public static const LEVEL					:String = "level";
		//public static const VIDEO					:String = "video";
				
		public function ComponentDescriptor()
		{
			properties = new ObjectProxy();
			children = new ArrayCollection();
			events = new ArrayCollection();
			transitions = new ObjectProxy();
			visible = true;
			locked = false;
			sizeProportionally = false;
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
		
		private var _displayName:String;
        		
		public function get displayName():String
		{
			return _displayName;
		}
		public function set displayName(value:String):void
		{
			_displayName = value;
		}
		
		private var _instanceName:String;
		
		public function get instanceName():String
		{
			return _instanceName;
		}
		public function set instanceName(value:String):void
		{
			_instanceName = value;
		}
		
		private var _template:IComponentTemplate;
		
		public function get template():IComponentTemplate
		{
			return _template;
		}
		public function set template(value:IComponentTemplate):void
		{
			_template = value;
		}
		
		private var _created:String;
		
		public function get created():String
		{
			return _created;
		}
		public function set created(value:String):void
		{
			_created = value;
		}
		
		private var _updated:String;
		
		public function get updated():String
		{
			return _updated;
		}
		public function set updated(value:String):void
		{
			_updated = value;
		}
        
		private var _properties:ObjectProxy;
		
        /**
         * Property/value list to be used for initializing instances of this component.
         * We use an ObjectProxy because it will dispatch PropertyChangeEvents on any property
         * change (which Moccasin needs), yet it's dynamic and doesn't constrain us to a fixed set of properties.
         */		
		public function get properties():ObjectProxy
		{
			return _properties;
		}
		public function set properties(value:ObjectProxy):void
		{
			_properties = value;
		}
		
		private var _children:IList;
		
		public function get children():IList
		{
			return _children;
		}
		public function set children(value:IList):void
		{
			_children = value;
		}
		
		private var _parent:IComponentDescriptor;
		
		public function get parent():IComponentDescriptor
		{
			return _parent;
		}
		public function set parent(value:IComponentDescriptor):void
		{
			_parent = value;
		}
		
		private var _dataComponent:IComponentDescriptor;
		
		public function get dataComponent():IComponentDescriptor
		{
			return _dataComponent;
		}
		public function set dataComponent(value:IComponentDescriptor):void
		{
			_dataComponent = value;
		}
		
		private var _events:IList;
		
		public function get events():IList
		{
			return _events;
		}
		public function set events(value:IList):void
		{
			_events = value;
		}
		
		private var _transitions:ObjectProxy;
		
		public function get transitions():ObjectProxy
		{
			return _transitions;
		}
		public function set transitions(value:ObjectProxy):void
		{
			_transitions = value;
		}
		
		private var _visible:Boolean;
		
		public function get visible():Boolean
		{
			return _visible;
		}
		public function set visible(value:Boolean):void
		{
			_visible = value;
		}
		
		private var _locked:Boolean;
		
		public function get locked():Boolean
		{
			return _locked;
		}
		public function set locked(value:Boolean):void
		{
			_locked = value;
		}
		
		private var _sizeProportionally:Boolean;
		
		public function get sizeProportionally():Boolean
		{
			return _sizeProportionally;
		}
		public function set sizeProportionally(value:Boolean):void
		{
			_sizeProportionally = value;
		}
		
		private var _selected:Boolean;
		
		public function get selected():Boolean
		{
			return _selected;
		}
		public function set selected(value:Boolean):void
		{
			_selected = value;
		}
		
		private var _level:int;
		
		public function get level():int 
		{
			if (!parent)
			{
				return 0;
			}
			
			return parent.level + 1;
		}
		public function set level(value:int):void 
		{
			_level = value;
		}
		
		/**
		 * @inheritDoc
		 *//*
		public function get video():IVideoSource
		{
			return signalProxy[VIDEO];
		}
		public function set video(value:IVideoSource):void
		{
			signalProxy[VIDEO] = value;
			
			for each (var descriptor:IComponentDescriptor in children)
			{
				descriptor.video = value;
			}
		}*/
		
		public function getNestedPropertyValue(property:String):Number 
		{
			var value:Number = properties[property];
			
			if (parent)
			{
				//value += parent.getNestedPropertyValue(property);
			}
			
			return value;
		}
				
		public function measure():Rectangle
		{
			if (children.length > 0)
			{
				var childBounds:Rectangle = getBoundsOfChildren();
				
				/*addRect(childBounds);
				
				for each (var child:ComponentDescriptor in children)
				{
					child.subtractRect(childBounds);
				}*/
				
				properties.x = childBounds.x;
				properties.y = childBounds.y;
				properties.width = childBounds.width;
				properties.height = childBounds.height;
			}

			return new Rectangle(properties.x, properties.y, (isNaN(properties.width)) ? 0 : properties.width, (isNaN(properties.height)) ? 0 : properties.height);
		}
		
		public function addRect(rect:Rectangle):void 
		{
			properties.x += rect.x;
			properties.y += rect.y;
		}
		
		public function subtractRect(rect:Rectangle):void 
		{
			properties.x -= rect.x;
			properties.y -= rect.y;
		}
		
		public function getBoundsOfChildren():Rectangle
		{
			var x:Number = Number.POSITIVE_INFINITY;
			var y:Number = Number.POSITIVE_INFINITY;
			var width:Number = 0.0;
			var height:Number = 0.0;			
			
			for each (var child:ComponentDescriptor in children)
			{					
				var rect:Rectangle = child.measure();
				
				var px:Number = rect.x;
				var py:Number = rect.y;
				var pw:Number = rect.width;
				var ph:Number = rect.height;
				
				if (px < x)
				{
					x = px;
				}
				
				if (py < y)
				{
					y = py;
				}
				
				if (px + pw > width)
				{
					width = px + pw;
				}
				
				if (py + ph > height)
				{
					height = py + ph;
				}
			}
			
			width -= x;
			height -= y;
			
			return new Rectangle(x, y, width, height);
		}
		
		public function clone():IComponentDescriptor 
		{
			var o:IComponentDescriptor = new ComponentDescriptor();
			o.id = id;
			o.displayName = displayName;
			o.properties = new ObjectProxy();
			
			for (var i:String in properties)
			{
				var p:Object = properties[i];
				
				/*if (p is ICloneable)
				{
					o.properties[i] = ICloneable(p).clone();
				} 
				else 
				{*/
					o.properties[i] = p;
				//}
			}
			
			o.visible = visible;
			o.locked = locked;
			
			o.template = template;
			
			return o;
		}
		
		public function toString():String 
		{
			return "[ComponentDescriptor(displayName=" + displayName + ", transitions=" + ObjectUtils.getKeys(transitions) + ")]";
		}
    }
}