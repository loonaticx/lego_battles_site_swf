package com.illusionFactory.lego
{
   import com.illusionFactory.StateMachineAS3.EventStateMachine;
   import com.illusionFactory.event.EventBroadcaster;
   import fl.video.VideoEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gs.TweenLite;
   import gs.easing.Back;
   import gs.easing.Bounce;
   import gs.easing.Strong;
   
   public class StateTrailer extends StateAbstract
   {
       
      
      private var bWorldMute:Boolean;
      
      public function StateTrailer()
      {
         super();
         _name = "StateTrailer";
      }
      
      override public function enter(param1:Object) : void
      {
         _view = new ViewTrailer();
         _view["playPauseBtn"].buttonMode = true;
         _view["muteBtn"].buttonMode = true;
         _view["flvPlayer"].playPauseButton = _view["playPauseBtn"];
         _view["flvPlayer"].muteButton = _view["muteBtn"];
         _view["flvPlayer"].autoRewind = true;
         _view["flvPlayer"].source = "flv/lego_battles.flv";
         _view["flvPlayer"].play();
         _view["flvPlayer"].addEventListener(VideoEvent.READY,handler_videoReady);
         _parentDisplay = _stateView.dropDown.content;
         bWorldMute = _parentDisplay.parent.parent["mcMuteBtn"].getMuteStatus();
         if(!bWorldMute)
         {
            _parentDisplay.parent.parent["mcMuteBtn"].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         _parentDisplay.parent.parent["mcMuteBtn"].active = false;
      }
      
      override public function exit(param1:Object) : void
      {
         _parentDisplay.parent.parent["mcMuteBtn"].active = true;
         if(!bWorldMute)
         {
            _parentDisplay.parent.parent["mcMuteBtn"].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         _view["flvPlayer"].removeEventListener(VideoEvent.READY,handler_videoReady);
         _view["flvPlayer"].stop();
         if(param1.nextState == Main.STATE_START)
         {
            TweenLite.to(_parentDisplay.parent,0.5,{
               "y":CONTENT_VIEW_YPOS_A,
               "ease":Strong.easeInOut
            });
            TweenLite.to(_parentDisplay.parent.parent["dimmer"],0.5,{
               "alpha":0,
               "ease":Strong.easeInOut,
               "onComplete":exit_end
            });
         }
         else
         {
            exit_end();
         }
      }
      
      private function exit_end() : void
      {
         if(_parentDisplay != null && _view != null && _parentDisplay.contains(_view))
         {
            _parentDisplay.removeChild(_view);
         }
         EventBroadcaster.getInstance().dispatchEvent(new Event(EventStateMachine.STATE_EXITED));
      }
      
      private function handler_videoReady(param1:VideoEvent) : void
      {
         _view["flvPlayer"].removeEventListener(VideoEvent.READY,handler_videoReady);
         _parentDisplay.addChild(_view);
         if(_parentDisplay.parent.y < CONTENT_VIEW_YPOS_B)
         {
            switch(_stmWorlds.getCurrentStateName())
            {
               case Main.STATE_CASTLE:
                  TweenLite.to(_parentDisplay.parent,1,{
                     "y":CONTENT_VIEW_YPOS_B,
                     "ease":Bounce.easeOut,
                     "delay":0.1
                  });
                  SoundManager.getInstance().playEffect(_stmWorlds.getCurrentStateName() + "_dropdown",1);
                  break;
               case Main.STATE_PIRATES:
                  TweenLite.to(_parentDisplay.parent,1.2,{
                     "y":CONTENT_VIEW_YPOS_B - 80,
                     "ease":Back.easeOut
                  });
                  TweenLite.to(_parentDisplay.parent,2,{
                     "y":CONTENT_VIEW_YPOS_B,
                     "ease":Bounce.easeInOut,
                     "delay":1,
                     "overwrite":0
                  });
                  SoundManager.getInstance().playEffect(_stmWorlds.getCurrentStateName() + "_dropdown",1);
                  break;
               case Main.STATE_SPACE:
                  TweenLite.to(_parentDisplay.parent,1.3,{
                     "y":CONTENT_VIEW_YPOS_B,
                     "ease":Strong.easeInOut,
                     "delay":0.8
                  });
                  SoundManager.getInstance().playEffect(_stmWorlds.getCurrentStateName() + "_dropdown",1);
            }
         }
         TweenLite.to(_parentDisplay.parent.parent["dimmer"],0.5,{
            "alpha":1,
            "ease":Strong.easeInOut
         });
      }
   }
}
