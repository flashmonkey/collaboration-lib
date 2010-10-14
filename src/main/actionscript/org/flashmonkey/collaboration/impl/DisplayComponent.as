package org.flashmonkey.collaboration.impl
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.system.Security;
    import flash.utils.Dictionary;
    
    import org.as3commons.lang.DictionaryUtils;
    import org.flashmonkey.collaboration.api.DisplayPhase;
    import org.flashmonkey.collaboration.api.IComponentContext;
    import org.flashmonkey.collaboration.api.IComponentService;
    import org.flashmonkey.collaboration.api.IDataComponent;
    import org.flashmonkey.collaboration.api.IDisplayComponent;
    import org.flashmonkey.collaboration.api.ITransition;
    import org.flashmonkey.collaboration.api.TransitionDirection;
    import org.flashmonkey.collaboration.impl.service.DefaultComponentService;
    import org.flashmonkey.operations.service.IOperation;

    [Bindable] public class DisplayComponent extends Sprite implements IDisplayComponent
    {	
		private var _sizeProportionally:Boolean;
		
		public function get sizeProportionally():Boolean
		{
			return _sizeProportionally;
		}
		public function set sizeProportionally(value:Boolean):void
		{
			_sizeProportionally = value;
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
		
		private var _id:Number;
		
		public function get id():Number 
		{
			return _id;
		}
		public function set id(value:Number):void 
		{
			_id = value;
		}
		
		private var _includeInLayout:Boolean = true;
		
		public function get includeInLayout():Boolean
		{
			return _includeInLayout;
		}
		public function set includeInLayout(value:Boolean):void 
		{
			_includeInLayout = value;
			
			updateDisplayPhase();
		}
		
		/**
		 * Setting up context reference.
		 * @private 
		 */
		protected var _context:IComponentContext;
		
		/**
		 * IContextAwareComponent implementation to hold reference on component context. 
		 * @return IComponentContext
		 */
		public function get context():IComponentContext
		{
			return _context;
		}
		public function set context( value:IComponentContext ):void
		{
			_context = value;
		}
		
		private var _firstShowing:Boolean = true;
		
		private var _componentService:IComponentService = new DefaultComponentService();
		
		public function set componentService(value:IComponentService):void
		{
			_componentService = value;
		}
		
        private var _width:Number = 0;
        private var _height:Number = 0;
		
		private var _displayPhase:DisplayPhase = DisplayPhase.BEFORE_TRANSITION_IN;
		
		public function get displayPhase():DisplayPhase
		{
			return _displayPhase;
		}
		
		private var _previousDisplayPhase:DisplayPhase = _displayPhase;
		
		private var _playheadValueDirty:Boolean;
		
		private var _active:Boolean = true;
		
		protected function set active(value:Boolean):void 
		{
			if (_active != value)
			{
				_active = visible = value;
			}
		}
		
		protected var _transitionIn:ITransition = new NullTransition();
		
		public function get IN():ITransition
		{
			return _transitionIn;
		}
		
		public function set IN(value:ITransition):void 
		{
			_transitionIn = value;
			_transitionIn.direction = TransitionDirection.IN;
			
			updateDisplayPhase();
		}
		
		protected var _transitionOut:ITransition;
		
		public function get OUT():ITransition
		{
			return _transitionOut;
		}
		
		public function set OUT(value:ITransition):void 
		{
			_transitionOut = value;
			_transitionOut.direction = TransitionDirection.OUT;
			
			updateDisplayPhase();
		}
		
		protected var _playheadTime:Number = 0.0;
		
		public function get playheadTime():Number 
		{
			return _playheadTime;
		}
		
		public function set playheadTime(value:Number):void 
		{
			//trace("Setting Playhead time on " + this + " to " + value);
			_playheadTime = value;
			_playheadValueDirty = true;
			updateDisplayPhase();
		}
		
		protected var _duration:Number = 0.0;
		
		public function get duration():Number 
		{
			return _duration;
		}
		
		/**
		 * The duration of the video this component is currently running in.
		 */
		public function set duration(value:Number):void
		{
			_duration = value / 1000;
			updateDisplayPhase();
		}
		
		protected var _begin:Number = 0.0;
		
		public function get begin():Number 
		{
			return _begin;
		}
		
		/**
		 * The time at which this component needs to be active (any transitions should complete at this point).
		 */
		public function set begin(value:Number):void
		{
			_begin = value;
			updateDisplayPhase();
		}
		
		protected var _end:Number = 0.0;
		
		public function get end():Number 
		{
			return _end;
		}
		
		/**
		 * The time at which this component needs to be inactive (any transitions should start at this point).
		 */
		public function set end(value:Number):void
		{
			_end = value;
			updateDisplayPhase();
		}
		
		private var _dataComponent:IDataComponent = new StaticDataComponent();
		
		public function get dataComponent():IDataComponent
		{
			return _dataComponent;
		}
		public function set dataComponent(value:IDataComponent):void 
		{
			_dataComponent = value;
		}
        
        public function DisplayComponent()
        {
			Security.allowDomain("*");
			
			registerEvents();
        }
		
		private var _eventMap:Dictionary = new Dictionary();
		
		protected function registerEvents():void 
		{
			
		}
		
		public function registerOperation(type:String, operation:IOperation):void 
		{			
			if (!DictionaryUtils.containsKey(_eventMap, type))
			{
				_eventMap[type] = [];
			}
			
			(_eventMap[type] as Array).push(operation);
			
			if (!hasEventListener(type))
			{
				addEventListener(type, handleEvent);
			}
		}
		
		public function handleEvent(e:Event):void 
		{			
			if (DictionaryUtils.containsKey(_eventMap, e.type))
			{
				var operations:Array = _eventMap[e.type] as Array;
				
				for each (var operation:IOperation in operations)
				{
					operation.execute();
				}
			}
		}
        
        override public function get width():Number
        {
            return _width;
        }
        
        override public function set width(value:Number):void
        {
            _width = value;
        }
        
        override public function get height():Number
        {
            return _height;
        }
        
        override public function set height(value:Number):void
        {
            _height = value;
        }
		
		private function currentDisplayPhase():DisplayPhase 
		{									
			if (_playheadTime < _begin)
			{						
				if (_transitionIn)
				{
					if (_playheadTime > _begin - _transitionIn.duration)
					{
						if (_previousDisplayPhase != DisplayPhase.DURING_TRANSITION_IN)
						{
							dispatchEvent(new Event("during transition in"));
						}
						
						return _previousDisplayPhase = DisplayPhase.DURING_TRANSITION_IN;
					}
				}				
				
				if (_previousDisplayPhase != DisplayPhase.BEFORE_TRANSITION_IN)
				{
					dispatchEvent(new Event("before transition in"));
				}
				
				return _previousDisplayPhase = DisplayPhase.BEFORE_TRANSITION_IN;
			}
			
			if (_playheadTime < _end)
			{								
				// If this is the first time the component has been shown
				// tell the service to inform the stats server.
				if (_firstShowing)
				{
					if (_context && !_context.editing && !_context.previewing)
					{
						_firstShowing = false;
						//_componentService.componentDisplayed(this);
					}
				}
				
				if (_previousDisplayPhase != DisplayPhase.DISPLAYING)
				{
					dispatchEvent(new Event("component displaying"));
				}
				
				return _previousDisplayPhase = DisplayPhase.DISPLAYING;
			}
			
			if (_transitionOut)
			{
				if (_playheadTime < _end + _transitionOut.duration)
				{			
					if (_previousDisplayPhase != DisplayPhase.DURING_TRANSITION_OUT)
					{
						dispatchEvent(new Event("during transition out"));
					}
					
					return _previousDisplayPhase = DisplayPhase.DURING_TRANSITION_OUT;
				}
			}
					
			if (_previousDisplayPhase != DisplayPhase.AFTER_TRANSITION_OUT)
			{
				dispatchEvent(new Event("after transition out"));
			}
			
			return _previousDisplayPhase = DisplayPhase.AFTER_TRANSITION_OUT;
		}
		
		/**
		 * Update the current state of the displayobject of this component.
		 * If there's a transition available use that.
		 * Otherwise just set the component active if the playhead is within the start/end times.
		 */
        public function updateDisplayPhase():void
        {
			_displayPhase = currentDisplayPhase();

			trace("DisplayPhase is: " + _previousDisplayPhase.getValue() + " => " + _displayPhase.getValue());

			if (!includeInLayout)
			{
				alpha = 0;
				active = false;
			}
			else
			{
				switch (_displayPhase)
				{
					case DisplayPhase.BEFORE_TRANSITION_IN:
					case DisplayPhase.AFTER_TRANSITION_OUT:
						alpha = 0;
						active = false;
						break;
					
					case DisplayPhase.DURING_TRANSITION_IN:
						active = true;
						applyTransition(_transitionIn);
						break;
					
					case DisplayPhase.DISPLAYING:
						alpha = 1;
						active = true;
						break;
					
					case DisplayPhase.DURING_TRANSITION_OUT:
						active = true;
						applyTransition(_transitionOut);
						break;
					
					default:
						active = false;
						break;
				}
			}
			
			//trace("component alpha " + alpha);
        }
		
		private function applyTransition(transition:ITransition):void 
		{
			transition.resolve(this, _begin, _end, _duration, _playheadTime);
		}
		
		public function applyPropertyValue(name:Object, value:*):void
		{
			//trace("APPLYING PROPERTY VALUE : " + name + " " + value);
			this[name] = value;
		}
    }
}