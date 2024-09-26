package com.illusionFactory.utils
{
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class XMLParser
   {
       
      
      private var _xmlData:XML;
      
      private var _xmlLoader:URLLoader;
      
      private var _xmlLocation:String;
      
      public function XMLParser(param1:String)
      {
         super();
         _xmlLocation = param1;
         _xmlLoader = new URLLoader();
         _xmlLoader.addEventListener(Event.COMPLETE,handler_complete);
         _xmlLoader.load(new URLRequest(_xmlLocation));
      }
      
      public function get xmlData() : XML
      {
         return _xmlData;
      }
      
      public function set xmlData(param1:XML) : void
      {
         _xmlData = param1;
      }
      
      private function handler_complete(param1:Event) : void
      {
         _xmlData = new XML(param1.target.data);
      }
   }
}
