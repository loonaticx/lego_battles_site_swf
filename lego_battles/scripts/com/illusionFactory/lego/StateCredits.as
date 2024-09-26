package com.illusionFactory.lego
{
   import com.illusionFactory.StateMachineAS3.EventStateMachine;
   import com.illusionFactory.event.EventBroadcaster;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import gs.TweenLite;
   import gs.easing.Back;
   import gs.easing.Bounce;
   import gs.easing.Strong;
   
   public class StateCredits extends StateAbstract
   {
       
      
      private var xmlData:XMLList;
      
      internal var xmlLocation = "xml/castle.xml";
      
      public function StateCredits()
      {
         xmlLocation = "xml/castle.xml";
         super();
         _name = "StateCredits";
         _view = new ViewCredits();
      }
      
      internal function startUpScroll(param1:MouseEvent) : void
      {
         _view.upButton.removeEventListener(MouseEvent.MOUSE_DOWN,startUpScroll);
         _view.stage.addEventListener(MouseEvent.MOUSE_UP,stopUpScroll);
         _view.upButton.addEventListener(Event.ENTER_FRAME,upScroll);
      }
      
      internal function stopUpScroll(param1:MouseEvent) : void
      {
         _view.upButton.addEventListener(MouseEvent.MOUSE_DOWN,startUpScroll);
         _view.upButton.removeEventListener(Event.ENTER_FRAME,upScroll);
      }
      
      internal function startDownScroll(param1:MouseEvent) : void
      {
         _view.downButton.removeEventListener(MouseEvent.MOUSE_DOWN,startDownScroll);
         _view.stage.addEventListener(MouseEvent.MOUSE_UP,stopDownScroll);
         _view.downButton.addEventListener(Event.ENTER_FRAME,downScroll);
      }
      
      override public function enter(param1:Object) : void
      {
         _parentDisplay = _stateView.dropDown.content;
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
         loadXML();
         _view.upButton.buttonMode = true;
         _view.downButton.buttonMode = true;
         _view.downButton.addEventListener(MouseEvent.MOUSE_DOWN,startDownScroll);
         _view.upButton.addEventListener(MouseEvent.MOUSE_DOWN,startUpScroll);
         _view.supportContent.y = 52;
      }
      
      internal function upScroll(param1:Event) : void
      {
         if(_view.supportContent.y <= 52)
         {
            _view.supportContent.y += 10;
         }
      }
      
      override public function exit(param1:Object) : void
      {
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
            _parentDisplay.removeChild(_view);
            EventBroadcaster.getInstance().dispatchEvent(new Event(EventStateMachine.STATE_EXITED));
         }
      }
      
      internal function stopDownScroll(param1:MouseEvent) : void
      {
         _view.downButton.removeEventListener(Event.ENTER_FRAME,downScroll);
         _view.downButton.addEventListener(MouseEvent.MOUSE_DOWN,startDownScroll);
      }
      
      private function exit_end() : void
      {
         _parentDisplay.removeChild(_view);
         EventBroadcaster.getInstance().dispatchEvent(new Event(EventStateMachine.STATE_EXITED));
      }
      
      internal function downScroll(param1:Event) : void
      {
         if(_view.supportContent.y >= (_view.supportContent.height - 250) * -1)
         {
            _view.supportContent.y -= 10;
         }
      }
      
      private function loadXML() : void
      {
         var _loc1_:String = null;
         xmlData = _app.getXMLData("credits");
         _loc1_ = String(xmlData.item.copy[0].toString());
         _view.supportContent.htmlText = _loc1_;
         _view.supportContent.autoSize = TextFieldAutoSize.CENTER;
      }
   }
}
