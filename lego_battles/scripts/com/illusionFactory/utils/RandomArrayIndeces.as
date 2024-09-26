package com.illusionFactory.utils
{
   public dynamic class RandomArrayIndeces extends Array
   {
       
      
      public function RandomArrayIndeces(param1:Number)
      {
         var _loc2_:Number = NaN;
         super();
         _loc2_ = 0;
         while(_loc2_ < param1)
         {
            this.push(_loc2_);
            _loc2_++;
         }
         randomize();
      }
      
      public function randomize() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Number = NaN;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Object = null;
         _loc1_ = this;
         _loc2_ = 0;
         while(_loc2_ < this.length * 2)
         {
            _loc3_ = uint(Math.random() * 10);
            _loc4_ = uint(Math.random() * 10);
            while(_loc3_ == _loc4_)
            {
               _loc4_ = uint(Math.random() * 10);
            }
            _loc5_ = _loc1_[_loc3_];
            _loc1_[_loc3_] = _loc1_[_loc4_];
            _loc1_[_loc4_] = _loc5_;
            _loc2_++;
         }
      }
   }
}
