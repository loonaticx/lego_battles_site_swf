package com.illusionFactory.lego
{
   public class SoundManager
   {
      
      private static var _instance:SoundManager = new SoundManager();
       
      
      private var _effects:SoundHolder;
      
      private var _backgrounds:SoundHolder;
      
      private var _muted:Boolean;
      
      public function SoundManager()
      {
         super();
         _effects = new SoundHolder({
            "StateCastle_dropdown":new Castle_dropdown(),
            "StatePirates_dropdown":new Pirates_dropdown(),
            "StateSpace_dropdown":new Space_dropdown()
         },0);
         _backgrounds = new SoundHolder({
            "StateCastle_ambient":new Castle_ambient(),
            "StatePirates_ambient":new Pirates_ambient(),
            "StateSpace_ambient":new Space_ambient()
         },65536,false);
         _muted = false;
         setBackgroundVolume(0.1);
      }
      
      public static function getInstance() : SoundManager
      {
         return SoundManager._instance;
      }
      
      public function playBackground(param1:String, param2:Number = 0, param3:int = -1) : void
      {
         _backgrounds.playSound(param1,param2,param3);
      }
      
      public function playEffect(param1:String, param2:Number = 0, param3:int = -1) : void
      {
         _effects.playSound(param1,param2,param3);
      }
      
      public function setBackgroundVolume(param1:Number) : void
      {
         _backgrounds.setVolume(param1);
      }
      
      public function stopBackground(param1:String, param2:Number = 0) : void
      {
         _backgrounds.stopSound(param1,param2);
      }
      
      public function unmute() : void
      {
         _muted = false;
         _effects.unmute();
         _backgrounds.unmute();
      }
      
      public function stopEffect(param1:String, param2:Number = 0) : void
      {
         _effects.stopSound(param1,param2);
      }
      
      public function toggleMute() : void
      {
         if(_muted)
         {
            unmute();
         }
         else
         {
            mute();
         }
      }
      
      public function mute() : void
      {
         _muted = true;
         _effects.mute();
         _backgrounds.mute();
      }
   }
}
