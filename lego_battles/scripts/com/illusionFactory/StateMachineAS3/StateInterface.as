package com.illusionFactory.StateMachineAS3
{
   public interface StateInterface
   {
       
      
      function init(param1:StateMachineInterface, param2:Object = null) : void;
      
      function enter(param1:Object) : void;
      
      function getName() : String;
      
      function exit(param1:Object) : void;
   }
}
