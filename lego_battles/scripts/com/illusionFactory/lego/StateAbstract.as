package com.illusionFactory.lego
{
   import com.illusionFactory.StateMachineAS3.EventStateMachine;
   import com.illusionFactory.StateMachineAS3.StateInterface;
   import com.illusionFactory.StateMachineAS3.StateMachineInterface;
   import flash.display.MovieClip;
   
   public class StateAbstract implements StateInterface
   {
       
      
      protected var _fsm:StateMachineInterface;
      
      protected var _view:MovieClip;
      
      protected const CONTENT_VIEW_YPOS_B:Number = 240;
      
      protected var _stateView:MovieClip;
      
      protected var _app:Main;
      
      protected var _name:String;
      
      protected const CONTENT_VIEW_YPOS_A:Number = -300;
      
      protected var _stmWorlds:EventStateMachine;
      
      protected var _parentDisplay:MovieClip;
      
      public function StateAbstract()
      {
         super();
      }
      
      public function init(param1:StateMachineInterface, param2:Object = null) : void
      {
         if(param2.parentDisplay == undefined || param2.parentDisplay == null || !(param2.parentDisplay is MovieClip))
         {
         }
         _stateView = param2.parentDisplay;
         _app = param2.app;
         _fsm = param1;
         _stmWorlds = _app.getWorldStateMachine();
      }
      
      public function enter(param1:Object) : void
      {
      }
      
      public function getName() : String
      {
         return _name;
      }
      
      public function exit(param1:Object) : void
      {
      }
   }
}
