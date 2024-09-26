package fl.video
{
   import flash.events.Event;
   
   public class MetadataEvent extends Event implements IVPEvent
   {
      
      public static const METADATA_RECEIVED:String = "metadataReceived";
      
      public static const CUE_POINT:String = "cuePoint";
       
      
      private var _info:Object;
      
      private var _vp:uint;
      
      public function MetadataEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Object = null, param5:uint = 0)
      {
         super(param1,param2,param3);
         _info = param4;
         _vp = param5;
      }
      
      public function get vp() : uint
      {
         return _vp;
      }
      
      public function set info(param1:Object) : void
      {
         _info = param1;
      }
      
      override public function clone() : Event
      {
         return new MetadataEvent(type,bubbles,cancelable,info,vp);
      }
      
      public function get info() : Object
      {
         return _info;
      }
      
      public function set vp(param1:uint) : void
      {
         _vp = param1;
      }
   }
}
