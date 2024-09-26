package gs.plugins
{
   import gs.TweenLite;
   
   public class AutoAlphaPlugin extends TweenPlugin
   {
      
      public static const VERSION:Number = 1;
      
      public static const API:Number = 1;
       
      
      protected var _tweenVisible:Boolean;
      
      protected var _tween:TweenLite;
      
      protected var _visible:Boolean;
      
      protected var _target:Object;
      
      public function AutoAlphaPlugin()
      {
         super();
         this.propName = "autoAlpha";
         this.overwriteProps = ["alpha","visible"];
         this.onComplete = onCompleteTween;
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         updateTweens(param1);
         if(_target.visible != true && _tweenVisible)
         {
            _target.visible = true;
         }
      }
      
      public function onCompleteTween() : void
      {
         if(_tweenVisible && _tween.vars.runBackwards != true && _tween.ease == _tween.vars.ease)
         {
            _target.visible = _visible;
         }
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         _target = param1;
         _tween = param3;
         _visible = Boolean(param2 != 0);
         _tweenVisible = true;
         addTween(param1,"alpha",param1.alpha,param2,"alpha");
         return true;
      }
      
      override public function killProps(param1:Object) : void
      {
         super.killProps(param1);
         _tweenVisible = !Boolean("visible" in param1);
      }
   }
}
