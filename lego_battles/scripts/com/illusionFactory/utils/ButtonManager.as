package com.illusionFactory.utils
{
   import com.illusionFactory.StateMachineAS3.EventStateMachine;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class ButtonManager
   {
       
      
      private var _aBtnData:Array;
      
      private var _mcContent:MovieClip;
      
      private var _stm:EventStateMachine;
      
      private var _mcCurrentBtn:MovieClip;
      
      public function ButtonManager(param1:Array, param2:EventStateMachine, param3:MovieClip)
      {
         super();
         _aBtnData = param1;
         _stm = param2;
         _mcContent = param3;
         enableSys();
      }
      
      public function disableSys() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in _aBtnData)
         {
            disableBtn(_loc1_.mc);
         }
         _mcCurrentBtn = null;
      }
      
      public function enableSys() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in _aBtnData)
         {
            enableBtn(_loc1_.mc);
         }
         _mcCurrentBtn = null;
      }
      
      private function getBtnIndex(param1:MovieClip) : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc3_ = 0;
         while(_loc3_ < _aBtnData.length)
         {
            if(param1 == _aBtnData[_loc3_].mc)
            {
               _loc2_ = _loc3_;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function disableBtn(param1:MovieClip) : void
      {
         param1.buttonMode = false;
         param1.removeEventListener(MouseEvent.CLICK,btnOnClick);
         param1.removeEventListener(MouseEvent.ROLL_OVER,btnOnRollOver);
         param1.removeEventListener(MouseEvent.ROLL_OUT,btnOnRollOut);
      }
      
      public function setFocus(param1:MovieClip) : void
      {
         if(_mcCurrentBtn)
         {
            enableBtn(_mcCurrentBtn);
            _mcCurrentBtn.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));
         }
         _mcCurrentBtn = param1;
         if(_mcCurrentBtn.name != "startBtn")
         {
            _mcCurrentBtn.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
         }
         disableBtn(_mcCurrentBtn);
      }
      
      public function enableBtn(param1:MovieClip) : void
      {
         param1.buttonMode = true;
         param1.addEventListener(MouseEvent.CLICK,btnOnClick);
         param1.addEventListener(MouseEvent.ROLL_OVER,btnOnRollOver);
         param1.addEventListener(MouseEvent.ROLL_OUT,btnOnRollOut);
      }
      
      private function btnOnRollOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = param1.currentTarget as MovieClip;
         _loc2_.gotoAndStop(2);
      }
      
      private function btnOnClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:uint = 0;
         var _loc4_:URLRequest = null;
         _loc2_ = param1.currentTarget as MovieClip;
         _loc3_ = getBtnIndex(_loc2_);
         switch(_aBtnData[_loc3_].target)
         {
            case "BuyNow":
               _loc4_ = new URLRequest("http://lego.com");
               navigateToURL(_loc4_,"_blank");
               break;
            default:
               setFocus(_loc2_);
               _stm.requestTransition(_aBtnData[_loc3_].target,{"nextState":_aBtnData[_loc3_].target});
         }
      }
      
      private function btnOnRollOut(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = param1.currentTarget as MovieClip;
         _loc2_.gotoAndStop(1);
      }
   }
}
