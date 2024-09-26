package com.illusionFactory.lego
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MuteToggle extends MovieClip
   {
       
      
      private var _muted:Boolean;
      
      private var _soundManager:SoundManager;
      
      public var mcWaves:MovieClip;
      
      public function MuteToggle()
      {
         super();
         addFrameScript(0,frame1,5,frame6,10,frame11);
         _soundManager = SoundManager.getInstance();
         _muted = false;
         buttonMode = true;
         active = true;
         hitArea = new Sprite();
         hitArea.graphics.beginFill(0,0);
         hitArea.graphics.drawRect(0,0,18,15);
         addChild(hitArea);
      }
      
      public function set active(param1:Boolean) : void
      {
         if(param1)
         {
            this.addEventListener(MouseEvent.CLICK,toggleMute);
         }
         else
         {
            this.removeEventListener(MouseEvent.CLICK,toggleMute);
         }
      }
      
      internal function frame6() : *
      {
         stop();
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      public function getMuteStatus() : Boolean
      {
         return _muted;
      }
      
      internal function frame11() : *
      {
         stop();
      }
      
      private function toggleMute(param1:MouseEvent) : void
      {
         if(_muted)
         {
            gotoAndPlay("soundOn");
            _soundManager.unmute();
            _muted = false;
         }
         else
         {
            gotoAndPlay("soundOff");
            _soundManager.mute();
            _muted = true;
         }
      }
   }
}
