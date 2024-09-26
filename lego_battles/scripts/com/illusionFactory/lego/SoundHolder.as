package com.illusionFactory.lego
{
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   import gs.TweenMax;
   
   public class SoundHolder
   {
       
      
      private var _sounds:Object;
      
      private var _clearOnMute:Boolean;
      
      private var _soundsPlaying:Dictionary;
      
      private var _muted:Boolean;
      
      private var _volume:Number;
      
      private var _defaultRepeat:Number;
      
      public function SoundHolder(param1:Object, param2:Number = 0, param3:Boolean = true)
      {
         super();
         _sounds = param1;
         _defaultRepeat = param2;
         _clearOnMute = param3;
         _soundsPlaying = new Dictionary();
         _muted = false;
         _volume = 1;
      }
      
      public function mute() : void
      {
         var _loc1_:Object = null;
         var _loc2_:SoundTransform = null;
         _muted = true;
         for(_loc1_ in _soundsPlaying)
         {
            _loc2_ = _soundsPlaying[_loc1_].soundTransform;
            _loc2_.volume = 0;
            _soundsPlaying[_loc1_].soundTransform = _loc2_;
         }
      }
      
      private function clearChannel(param1:Sound) : void
      {
         if(_soundsPlaying[param1] is SoundChannel)
         {
            _soundsPlaying[param1].stop();
            _soundsPlaying[param1].removeEventListener(Event.SOUND_COMPLETE,onSoundComplete);
            delete _soundsPlaying[param1];
         }
      }
      
      private function onSoundComplete(param1:Event) : void
      {
         var _loc2_:Object = null;
         param1.target.stop();
         param1.target.removeEventListener(Event.SOUND_COMPLETE,onSoundComplete);
         for(_loc2_ in _soundsPlaying)
         {
            if(_soundsPlaying[_loc2_] == param1.target)
            {
               delete _soundsPlaying[_loc2_];
               break;
            }
         }
      }
      
      public function unmute() : void
      {
         var _loc1_:Object = null;
         var _loc2_:SoundTransform = null;
         _muted = false;
         if(!_clearOnMute)
         {
            for(_loc1_ in _soundsPlaying)
            {
               _loc2_ = _soundsPlaying[_loc1_].soundTransform;
               _loc2_.volume = _volume;
               _soundsPlaying[_loc1_].soundTransform = _loc2_;
            }
         }
      }
      
      public function stopSound(param1:String, param2:Number = 0) : void
      {
         var _loc3_:Sound = null;
         var _loc4_:SoundChannel = null;
         if(_sounds[param1] is Sound && _soundsPlaying[_sounds[param1]] is SoundChannel)
         {
            _loc3_ = _sounds[param1];
            _loc4_ = _soundsPlaying[_loc3_];
            if(param2 > 0)
            {
               TweenMax.to(_loc4_,param2,{
                  "volume":0,
                  "onComplete":clearChannel,
                  "onCompleteParams":[_loc3_]
               });
            }
            else
            {
               _loc4_.stop();
               clearChannel(_loc3_);
            }
         }
      }
      
      public function playSound(param1:String, param2:Number = 0, param3:int = -1) : void
      {
         var _loc4_:SoundChannel = null;
         var _loc5_:SoundTransform = null;
         if(_sounds[param1] is Sound)
         {
            if(param3 < 0)
            {
               _loc4_ = _sounds[param1].play(0,_defaultRepeat);
            }
            else
            {
               _loc4_ = _sounds[param1].play(0,param3);
            }
            _loc5_ = _loc4_.soundTransform;
            if(_muted)
            {
               _loc5_.volume = 0;
            }
            else
            {
               _loc5_.volume = _volume;
            }
            _loc4_.soundTransform = _loc5_;
            _loc4_.addEventListener(Event.SOUND_COMPLETE,onSoundComplete,false,0,true);
            if(param2 > 0)
            {
               TweenMax.from(_loc4_,param2,{"volume":0});
            }
            _soundsPlaying[_sounds[param1]] = _loc4_;
         }
      }
      
      public function setVolume(param1:Number) : void
      {
         _volume = param1;
      }
      
      public function stopAll(param1:Number = 0) : void
      {
         var _loc2_:Object = null;
         for(_loc2_ in _sounds)
         {
            stopSound(String(_loc2_),param1);
         }
      }
   }
}
