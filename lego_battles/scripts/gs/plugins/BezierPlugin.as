package gs.plugins
{
   import gs.TweenLite;
   
   public class BezierPlugin extends TweenPlugin
   {
      
      protected static const _RAD2DEG:Number = 180 / Math.PI;
      
      public static const VERSION:Number = 1.01;
      
      public static const API:Number = 1;
       
      
      protected var _future:Object;
      
      protected var _orient:Boolean;
      
      protected var _orientData:Array;
      
      protected var _beziers:Object;
      
      protected var _target:Object;
      
      public function BezierPlugin()
      {
         _future = {};
         super();
         this.propName = "bezier";
         this.overwriteProps = [];
      }
      
      public static function parseBeziers(param1:Object, param2:Boolean = false) : Object
      {
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:Object = null;
         var _loc6_:String = null;
         var _loc7_:Object = null;
         _loc7_ = {};
         if(param2)
         {
            for(_loc6_ in param1)
            {
               _loc4_ = param1[_loc6_];
               _loc7_[_loc6_] = _loc5_ = [];
               if(_loc4_.length > 2)
               {
                  _loc5_[_loc5_.length] = [_loc4_[0],_loc4_[1] - (_loc4_[2] - _loc4_[0]) / 4,_loc4_[1]];
                  _loc3_ = 1;
                  while(_loc3_ < _loc4_.length - 1)
                  {
                     _loc5_[_loc5_.length] = [_loc4_[_loc3_],_loc4_[_loc3_] + (_loc4_[_loc3_] - _loc5_[_loc3_ - 1][1]),_loc4_[_loc3_ + 1]];
                     _loc3_++;
                  }
               }
               else
               {
                  _loc5_[_loc5_.length] = [_loc4_[0],(_loc4_[0] + _loc4_[1]) / 2,_loc4_[1]];
               }
            }
         }
         else
         {
            for(_loc6_ in param1)
            {
               _loc4_ = param1[_loc6_];
               _loc7_[_loc6_] = _loc5_ = [];
               if(_loc4_.length > 3)
               {
                  _loc5_[_loc5_.length] = [_loc4_[0],_loc4_[1],(_loc4_[1] + _loc4_[2]) / 2];
                  _loc3_ = 2;
                  while(_loc3_ < _loc4_.length - 2)
                  {
                     _loc5_[_loc5_.length] = [_loc5_[_loc3_ - 2][2],_loc4_[_loc3_],(_loc4_[_loc3_] + _loc4_[_loc3_ + 1]) / 2];
                     _loc3_++;
                  }
                  _loc5_[_loc5_.length] = [_loc5_[_loc5_.length - 1][2],_loc4_[_loc4_.length - 2],_loc4_[_loc4_.length - 1]];
               }
               else if(_loc4_.length == 3)
               {
                  _loc5_[_loc5_.length] = [_loc4_[0],_loc4_[1],_loc4_[2]];
               }
               else if(_loc4_.length == 2)
               {
                  _loc5_[_loc5_.length] = [_loc4_[0],(_loc4_[0] + _loc4_[1]) / 2,_loc4_[1]];
               }
            }
         }
         return _loc7_;
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:Object = null;
         var _loc5_:Number = NaN;
         var _loc6_:uint = 0;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:Object = null;
         var _loc10_:Boolean = false;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Array = null;
         var _loc14_:Number = NaN;
         if(param1 == 1)
         {
            for(_loc3_ in _beziers)
            {
               _loc2_ = _beziers[_loc3_].length - 1;
               _target[_loc3_] = _beziers[_loc3_][_loc2_][2];
            }
         }
         else
         {
            for(_loc3_ in _beziers)
            {
               _loc6_ = uint(_beziers[_loc3_].length);
               if(param1 < 0)
               {
                  _loc2_ = 0;
               }
               else if(param1 >= 1)
               {
                  _loc2_ = int(_loc6_ - 1);
               }
               else
               {
                  _loc2_ = int(_loc6_ * param1);
               }
               _loc5_ = (param1 - _loc2_ * (1 / _loc6_)) * _loc6_;
               _loc4_ = _beziers[_loc3_][_loc2_];
               if(this.round)
               {
                  _loc8_ = (_loc7_ = _loc4_[0] + _loc5_ * (2 * (1 - _loc5_) * (_loc4_[1] - _loc4_[0]) + _loc5_ * (_loc4_[2] - _loc4_[0]))) < 0 ? -1 : 1;
                  _target[_loc3_] = _loc7_ % 1 * _loc8_ > 0.5 ? int(_loc7_) + _loc8_ : int(_loc7_);
               }
               else
               {
                  _target[_loc3_] = _loc4_[0] + _loc5_ * (2 * (1 - _loc5_) * (_loc4_[1] - _loc4_[0]) + _loc5_ * (_loc4_[2] - _loc4_[0]));
               }
            }
         }
         if(_orient)
         {
            _loc9_ = _target;
            _loc10_ = this.round;
            _target = _future;
            this.round = false;
            _orient = false;
            this.changeFactor = param1 + 0.01;
            _target = _loc9_;
            this.round = _loc10_;
            _orient = true;
            _loc2_ = 0;
            while(_loc2_ < _orientData.length)
            {
               _loc14_ = Number(Number((_loc13_ = _orientData[_loc2_])[3]) || 0);
               _loc11_ = _future[_loc13_[0]] - _target[_loc13_[0]];
               _loc12_ = _future[_loc13_[1]] - _target[_loc13_[1]];
               _target[_loc13_[2]] = Math.atan2(_loc12_,_loc11_) * _RAD2DEG + _loc14_;
               _loc2_++;
            }
         }
      }
      
      protected function init(param1:TweenLite, param2:Array, param3:Boolean) : void
      {
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         _target = param1.target;
         if(param1.exposedVars.orientToBezier == true)
         {
            _orientData = [["x","y","rotation",0]];
            _orient = true;
         }
         else if(param1.exposedVars.orientToBezier is Array)
         {
            _orientData = param1.exposedVars.orientToBezier;
            _orient = true;
         }
         _loc4_ = {};
         _loc5_ = 0;
         while(_loc5_ < param2.length)
         {
            for(_loc6_ in param2[_loc5_])
            {
               if(_loc4_[_loc6_] == undefined)
               {
                  _loc4_[_loc6_] = [param1.target[_loc6_]];
               }
               if(typeof param2[_loc5_][_loc6_] == "number")
               {
                  _loc4_[_loc6_].push(param2[_loc5_][_loc6_]);
               }
               else
               {
                  _loc4_[_loc6_].push(param1.target[_loc6_] + Number(param2[_loc5_][_loc6_]));
               }
            }
            _loc5_++;
         }
         for(_loc6_ in _loc4_)
         {
            this.overwriteProps[this.overwriteProps.length] = _loc6_;
            if(param1.exposedVars[_loc6_] != undefined)
            {
               if(typeof param1.exposedVars[_loc6_] == "number")
               {
                  _loc4_[_loc6_].push(param1.exposedVars[_loc6_]);
               }
               else
               {
                  _loc4_[_loc6_].push(param1.target[_loc6_] + Number(param1.exposedVars[_loc6_]));
               }
               delete param1.exposedVars[_loc6_];
               _loc5_ = int(param1.tweens.length - 1);
               while(_loc5_ > -1)
               {
                  if(param1.tweens[_loc5_].name == _loc6_)
                  {
                     param1.tweens.splice(_loc5_,1);
                  }
                  _loc5_--;
               }
            }
         }
         _beziers = parseBeziers(_loc4_,param3);
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         if(!(param2 is Array))
         {
            return false;
         }
         init(param3,param2 as Array,false);
         return true;
      }
      
      override public function killProps(param1:Object) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in _beziers)
         {
            if(_loc2_ in param1)
            {
               delete _beziers[_loc2_];
            }
         }
         super.killProps(param1);
      }
   }
}
