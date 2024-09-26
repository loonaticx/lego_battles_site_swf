package fl.video
{
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class LayoutEvent extends Event
   {
      
      public static const LAYOUT:String = "layout";
       
      
      private var _oldBounds:Rectangle;
      
      private var _oldRegistrationBounds:Rectangle;
      
      public function LayoutEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Rectangle = null, param5:Rectangle = null)
      {
         super(param1,param2,param3);
         _oldBounds = param4;
         _oldRegistrationBounds = param5;
      }
      
      public function get oldRegistrationBounds() : Rectangle
      {
         return _oldRegistrationBounds;
      }
      
      override public function clone() : Event
      {
         return new LayoutEvent(type,bubbles,cancelable,Rectangle(oldBounds.clone()),Rectangle(oldRegistrationBounds.clone()));
      }
      
      public function set oldRegistrationBounds(param1:Rectangle) : void
      {
         _oldRegistrationBounds = param1;
      }
      
      public function set oldBounds(param1:Rectangle) : void
      {
         _oldBounds = param1;
      }
      
      public function get oldBounds() : Rectangle
      {
         return _oldBounds;
      }
   }
}
