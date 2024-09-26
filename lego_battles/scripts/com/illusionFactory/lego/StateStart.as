package com.illusionFactory.lego
{
   import com.illusionFactory.StateMachineAS3.EventStateMachine;
   import com.illusionFactory.event.EventBroadcaster;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class StateStart extends StateAbstract
   {
       
      
      public function StateStart()
      {
         super();
         _name = "StateStart";
      }
      
      override public function enter(param1:Object) : void
      {
         if(_stateView["dropDown"] == null)
         {
            EventBroadcaster.getInstance().addEventListener("onWorldReady",setupState);
         }
         else
         {
            EventBroadcaster.getInstance().dispatchEvent(new Event("onStartReady"));
         }
      }
      
      private function setupState(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:StateWorldAbstract = null;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         _parentDisplay = _stateView["dropDown"]["content"];
         _parentDisplay.parent.y = CONTENT_VIEW_YPOS_A;
         _parentDisplay.parent.parent["dimmer"].alpha = 0;
         _loc2_ = _app.getStartSection();
         _loc3_ = StateWorldAbstract(_stmWorlds.getCurrentState());
         _loc4_ = _loc3_.getBtnIndex(_loc2_);
         _loc5_ = _loc3_.getNav();
         if(_loc4_ == 0)
         {
            _loc3_.getBtnMgr().setFocus(_loc5_[0].mc);
         }
         else
         {
            _loc5_[_loc4_].mc.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      override public function exit(param1:Object) : void
      {
         EventBroadcaster.getInstance().dispatchEvent(new Event(EventStateMachine.STATE_EXITED));
      }
   }
}
