package com.illusionFactory.lego
{
   import com.illusionFactory.StateMachineAS3.EventStateMachine;
   import com.illusionFactory.StateMachineAS3.StateInterface;
   import com.illusionFactory.StateMachineAS3.StateMachineInterface;
   import com.illusionFactory.event.EventBroadcaster;
   import com.illusionFactory.utils.ButtonManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class StateWorldAbstract implements StateInterface
   {
       
      
      protected var _fsm:StateMachineInterface;
      
      protected var _display:MovieClip;
      
      protected var _leftWorld:String;
      
      private var _nextWorld:String;
      
      protected var _app:Main;
      
      private var _nav:Array;
      
      protected var _name:String;
      
      protected var _rightWorld:String;
      
      protected var _xmlURL:String;
      
      private var _btnMgr:ButtonManager;
      
      public function StateWorldAbstract()
      {
         super();
      }
      
      private function handler_closeBtnClick(param1:MouseEvent) : void
      {
         _nav[0].mc.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      public function getBtnMgr() : ButtonManager
      {
         return _btnMgr;
      }
      
      public function getBtnIndex(param1:*) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _nav.length)
         {
            if(param1 == _nav[_loc2_].mc || param1 == _nav[_loc2_].target)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function init(param1:StateMachineInterface, param2:Object = null) : void
      {
         _fsm = param1;
         _display = param2.display;
         _app = param2.app;
      }
      
      public function getName() : String
      {
         return _name;
      }
      
      private function enableWorldNav() : void
      {
         _display.worldLeft.buttonMode = true;
         _display.worldRight.buttonMode = true;
         _display.worldLeft.addEventListener(MouseEvent.CLICK,gotoWorld);
         _display.worldRight.addEventListener(MouseEvent.CLICK,gotoWorld);
      }
      
      public function exit(param1:Object) : void
      {
         SoundManager.getInstance().stopBackground(getName() + "_ambient",1);
         _display.worldLeft.buttonMode = false;
         _display.worldRight.buttonMode = false;
         _display.worldLeft.removeEventListener(MouseEvent.CLICK,gotoWorld);
         _display.worldRight.removeEventListener(MouseEvent.CLICK,gotoWorld);
         _display.dropDown.closeBtn.buttonMode = false;
         _display.dropDown.closeBtn.removeEventListener(MouseEvent.CLICK,handler_closeBtnClick);
         EventBroadcaster.getInstance().dispatchEvent(new Event(EventStateMachine.STATE_EXITED));
      }
      
      public function enter(param1:Object) : void
      {
         if(param1 != null && param1.prevWorld != null)
         {
            _display.gotoAndPlay(param1.prevWorld + " to " + getName());
         }
         else
         {
            _display.gotoAndPlay(getName() + " enter");
         }
         Main.xmlURL = _xmlURL;
         _display.worldLeft.gotoAndStop(_leftWorld);
         _display.worldRight.gotoAndStop(_rightWorld);
         disableWorldNav();
         SoundManager.getInstance().playBackground(getName() + "_ambient",1);
         EventBroadcaster.getInstance().addEventListener("onWorldReady",enableNav);
      }
      
      public function getNav() : Array
      {
         return _nav;
      }
      
      private function enableNav(param1:Object) : void
      {
         EventBroadcaster.getInstance().removeEventListener("onWorldReady",enableNav);
         enableWorldNav();
         _display.dropDown.grips.gotoAndStop(getName());
         _nav = new Array({
            "mc":_display.startBtn,
            "target":Main.STATE_START
         },{
            "mc":_display.nav.charactersBtn,
            "target":Main.STATE_CHARACTERS
         },{
            "mc":_display.nav.storyBtn,
            "target":Main.STATE_STORY
         },{
            "mc":_display.nav.downloadsBtn,
            "target":Main.STATE_DOWNLOADS
         },{
            "mc":_display.nav.trailerBtn,
            "target":Main.STATE_TRAILER
         },{
            "mc":_display.nav.galleryBtn,
            "target":Main.STATE_GALLERY
         },{
            "mc":_display.nav.creditsBtn,
            "target":Main.STATE_CREDITS
         },{
            "mc":_display.nav.supportBtn,
            "target":Main.STATE_SUPPORT
         },{
            "mc":_display.nav.buyNowBtn,
            "target":"BuyNow"
         });
         _display.dropDown.closeBtn.buttonMode = true;
         _display.dropDown.closeBtn.addEventListener(MouseEvent.CLICK,handler_closeBtnClick,false,0,true);
         _btnMgr = new ButtonManager(_nav,_app.getSectionStateMachine(),_display.dropDown);
      }
      
      private function onStartReady(... rest) : void
      {
         if(rest.length > 0)
         {
            EventBroadcaster.getInstance().removeEventListener("onStartReady",onStartReady);
         }
         switch(_nextWorld)
         {
            case "worldLeft":
               _fsm.requestTransition(_leftWorld,{"prevWorld":getName()});
               break;
            case "worldRight":
               _fsm.requestTransition(_rightWorld,{"prevWorld":getName()});
         }
      }
      
      private function disableWorldNav() : void
      {
         _display.worldLeft.buttonMode = false;
         _display.worldRight.buttonMode = false;
         _display.worldLeft.removeEventListener(MouseEvent.CLICK,gotoWorld);
         _display.worldRight.removeEventListener(MouseEvent.CLICK,gotoWorld);
      }
      
      private function gotoWorld(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = MovieClip(param1.currentTarget);
         _nextWorld = _loc2_.name;
         if(_app.getSectionStateMachine().getCurrentStateName() != Main.STATE_START)
         {
            EventBroadcaster.getInstance().addEventListener("onStartReady",onStartReady);
            _nav[0].mc.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         else
         {
            onStartReady();
         }
      }
   }
}
