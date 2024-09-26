package com.illusionFactory.event
{
   import flash.events.EventDispatcher;
   
   public class EventBroadcaster extends EventDispatcher
   {
      
      private static var _instance:EventBroadcaster = new EventBroadcaster();
       
      
      public function EventBroadcaster()
      {
         super();
         if(_instance != null)
         {
         }
      }
      
      public static function getInstance() : EventBroadcaster
      {
         return EventBroadcaster._instance;
      }
   }
}
