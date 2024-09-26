package gs.plugins
{
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   import gs.TweenLite;
   import gs.utils.tween.TweenInfo;
   
   public class TintPlugin extends TweenPlugin
   {
      
      protected static var _props:Array = ["redMultiplier","greenMultiplier","blueMultiplier","alphaMultiplier","redOffset","greenOffset","blueOffset","alphaOffset"];
      
      public static const VERSION:Number = 1.1;
      
      public static const API:Number = 1;
       
      
      protected var _ct:ColorTransform;
      
      protected var _ignoreAlpha:Boolean;
      
      protected var _target:DisplayObject;
      
      public function TintPlugin()
      {
         super();
         this.propName = "tint";
         this.overwriteProps = ["tint"];
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         var _loc2_:ColorTransform = null;
         updateTweens(param1);
         if(_ignoreAlpha)
         {
            _loc2_ = _target.transform.colorTransform;
            _ct.alphaMultiplier = _loc2_.alphaMultiplier;
            _ct.alphaOffset = _loc2_.alphaOffset;
         }
         _target.transform.colorTransform = _ct;
      }
      
      public function init(param1:DisplayObject, param2:ColorTransform) : void
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         _target = param1;
         _ct = _target.transform.colorTransform;
         _loc3_ = int(_props.length - 1);
         while(_loc3_ > -1)
         {
            _loc4_ = String(_props[_loc3_]);
            if(_ct[_loc4_] != param2[_loc4_])
            {
               _tweens[_tweens.length] = new TweenInfo(_ct,_loc4_,_ct[_loc4_],param2[_loc4_] - _ct[_loc4_],"tint",false);
            }
            _loc3_--;
         }
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         var _loc4_:ColorTransform = null;
         if(!(param1 is DisplayObject))
         {
            return false;
         }
         _loc4_ = new ColorTransform();
         if(param2 != null && param3.exposedVars.removeTint != true)
         {
            _loc4_.color = uint(param2);
         }
         _ignoreAlpha = true;
         init(param1 as DisplayObject,_loc4_);
         return true;
      }
   }
}
