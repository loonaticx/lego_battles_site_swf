package com.illusionFactory.StateMachineAS3
{
   public interface StateMachineInterface
   {
       
      
      function addState(param1:StateInterface, param2:Array, param3:Object = null) : void;
      
      function requestTransition(param1:String, param2:Object = null) : void;
      
      function getCurrentStateName() : String;
   }
}
