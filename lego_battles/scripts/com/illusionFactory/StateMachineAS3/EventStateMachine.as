package com.illusionFactory.StateMachineAS3
{
   import com.illusionFactory.event.EventBroadcaster;
   import flash.events.Event;
   
   public class EventStateMachine implements StateMachineInterface
   {
      
      public static const STATE_EXITED:String = "STATE_EXITED";
       
      
      private var _oNextArgs:Object;
      
      private var _oStates:Object;
      
      private var _stCurrentState:StateInterface;
      
      private var _stNextState:StateInterface;
      
      public function EventStateMachine(param1:Array, param2:String, param3:Object = null, param4:Object = null)
      {
         var _loc5_:uint = 0;
         super();
         _oStates = new Object();
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            addState(param1[_loc5_].state,param1[_loc5_].allowedStates,param4);
            _loc5_++;
         }
         _stCurrentState = _oStates[param2].state;
         _oStates[param2].state.enter(param3);
      }
      
      public function requestTransition(param1:String, param2:Object = null) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         if(_oStates[param1] == undefined)
         {
            return;
         }
         _loc3_ = false;
         _loc4_ = _oStates[_stCurrentState.getName()].allowedTransitions;
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            if(_loc4_[_loc5_] == param1)
            {
               _loc3_ = true;
               EventBroadcaster.getInstance().addEventListener(EventStateMachine.STATE_EXITED,enterNext);
               _stNextState = _oStates[param1].state;
               _oNextArgs = param2;
               _stCurrentState.exit(_oNextArgs);
            }
            _loc5_++;
         }
         if(!_loc3_)
         {
            return;
         }
      }
      
      public function getCurrentState() : StateInterface
      {
         return _stCurrentState;
      }
      
      public function addState(param1:StateInterface, param2:Array, param3:Object = null) : void
      {
         _oStates[param1.getName()] = {
            "state":param1,
            "allowedTransitions":param2
         };
         _oStates[param1.getName()].state.init(this,param3);
      }
      
      public function getCurrentStateName() : String
      {
         return _stCurrentState.getName();
      }
      
      private function enterNext(param1:Event) : void
      {
         EventBroadcaster.getInstance().removeEventListener(EventStateMachine.STATE_EXITED,enterNext);
         _stNextState.enter(_oNextArgs);
         _stCurrentState = _stNextState;
         _stNextState = null;
         _oNextArgs = null;
      }
   }
}
