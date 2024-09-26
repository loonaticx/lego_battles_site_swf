package gs.plugins
{
   import flash.media.SoundTransform;
   import gs.TweenLite;
   
   public class VolumePlugin extends TweenPlugin
   {
      
      public static const VERSION:Number = 1.01;
      
      public static const API:Number = 1;
       
      
      protected var _st:SoundTransform;
      
      protected var _target:Object;
      
      public function VolumePlugin()
      {
         super();
         this.propName = "volume";
         this.overwriteProps = ["volume"];
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         updateTweens(param1);
         _target.soundTransform = _st;
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         if(isNaN(param2) || !param1.hasOwnProperty("soundTransform"))
         {
            return false;
         }
         _target = param1;
         _st = _target.soundTransform;
         addTween(_st,"volume",_st.volume,param2,"volume");
         return true;
      }
   }
}
