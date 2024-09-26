package lego_battles_fla
{
   import com.illusionFactory.event.EventBroadcaster;
   import com.illusionFactory.lego.MuteToggle;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class Worlds_1 extends MovieClip
   {
       
      
      public var mcMuteBtn:MuteToggle;
      
      public var nav:MovieClip;
      
      public var dropDown:MovieClip;
      
      public var dimmer:MovieClip;
      
      public var mcLoadingAnimation:MovieClip;
      
      public var startBtn:MovieClip;
      
      public var worldRight:MovieClip;
      
      public var worldLeft:MovieClip;
      
      public function Worlds_1()
      {
         super();
         addFrameScript(0,frame1,39,frame40,78,frame79,117,frame118,156,frame157,195,frame196,234,frame235,235,frame236,244,frame245,253,frame254,298,frame299,332,frame333,368,frame369);
      }
      
      internal function frame157() : *
      {
         gotoAndPlay("StateCastle");
      }
      
      internal function frame79() : *
      {
         gotoAndPlay("StatePirates");
      }
      
      internal function frame299() : *
      {
         gotoAndPlay("StatePirates");
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame235() : *
      {
         gotoAndPlay("StateSpace");
      }
      
      internal function frame196() : *
      {
         gotoAndPlay("StatePirates");
      }
      
      internal function frame236() : *
      {
         stop();
         EventBroadcaster.getInstance().dispatchEvent(new Event("onWorldReady"));
      }
      
      internal function frame245() : *
      {
         stop();
         EventBroadcaster.getInstance().dispatchEvent(new Event("onWorldReady"));
      }
      
      internal function frame40() : *
      {
         gotoAndPlay("StateCastle");
      }
      
      internal function frame118() : *
      {
         gotoAndPlay("StateSpace");
      }
      
      internal function frame369() : *
      {
         gotoAndPlay("StateCastle");
      }
      
      internal function frame333() : *
      {
         gotoAndPlay("StateSpace");
      }
      
      internal function frame254() : *
      {
         stop();
         EventBroadcaster.getInstance().dispatchEvent(new Event("onWorldReady"));
      }
   }
}
