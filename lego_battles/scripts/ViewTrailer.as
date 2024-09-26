package
{
   import fl.video.FLVPlayback;
   import flash.display.MovieClip;
   
   public dynamic class ViewTrailer extends MovieClip
   {
       
      
      public var flvPlayer:FLVPlayback;
      
      public var muteBtn:MuteButton;
      
      public var seekbar:SeekBar;
      
      public var playPauseBtn:PlayPauseButton;
      
      public function ViewTrailer()
      {
         super();
         __setProp_flvPlayer_ViewTrailer_flvPlayer_1();
      }
      
      internal function __setProp_flvPlayer_ViewTrailer_flvPlayer_1() : *
      {
         try
         {
            flvPlayer["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         flvPlayer.align = "center";
         flvPlayer.autoPlay = false;
         flvPlayer.scaleMode = "maintainAspectRatio";
         flvPlayer.skin = "";
         flvPlayer.skinAutoHide = false;
         flvPlayer.skinBackgroundAlpha = 1;
         flvPlayer.skinBackgroundColor = 0;
         flvPlayer.source = "flv/lego_battles.flv";
         flvPlayer.volume = 1;
         try
         {
            flvPlayer["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
