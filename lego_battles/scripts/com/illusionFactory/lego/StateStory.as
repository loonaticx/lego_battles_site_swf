package com.illusionFactory.lego
{
   import com.illusionFactory.StateMachineAS3.EventStateMachine;
   import com.illusionFactory.event.EventBroadcaster;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.text.TextFieldAutoSize;
   import gs.TweenLite;
   import gs.easing.Back;
   import gs.easing.Bounce;
   import gs.easing.Strong;
   
   public class StateStory extends StateAbstract
   {
       
      
      private var xmlData:XMLList;
      
      internal var xmlLocation = "xml/castle.xml";
      
      public function StateStory()
      {
         xmlLocation = "xml/castle.xml";
         super();
         _name = "StateStory";
         _view = new ViewStory();
      }
      
      private function loadXML() : void
      {
         var _loc1_:String = null;
         var _loc2_:Loader = null;
         var _loc3_:String = null;
         xmlData = _app.getXMLData("story");
         _loc1_ = String(xmlData.item.image[randRange(0,xmlData.item.image.length() - 1)]);
         _loc2_ = new Loader();
         _loc2_.load(new URLRequest(_loc1_));
         _view.mcContentShell.addChildAt(_loc2_,0);
         _loc3_ = String(xmlData.item.copy[0].toString());
         _view.storyContent.htmlText = _loc3_;
         _view.storyContent.autoSize = TextFieldAutoSize.CENTER;
      }
      
      override public function enter(param1:Object) : void
      {
         var startUpScroll:Function = null;
         var upScroll:Function = null;
         var stopUpScroll:Function = null;
         var startDownScroll:Function = null;
         var stopDownScroll:Function = null;
         var downScroll:Function = null;
         var oArgs:Object = param1;
         startUpScroll = function(param1:MouseEvent):void
         {
            _view.upButton.addEventListener(Event.ENTER_FRAME,upScroll);
         };
         upScroll = function(param1:Event):void
         {
            if(_view.storyContent.y <= 52)
            {
               _view.storyContent.y += 10;
            }
         };
         stopUpScroll = function(param1:MouseEvent):void
         {
            _view.upButton.removeEventListener(Event.ENTER_FRAME,upScroll);
         };
         startDownScroll = function(param1:MouseEvent):void
         {
            _view.downButton.addEventListener(Event.ENTER_FRAME,downScroll);
         };
         stopDownScroll = function(param1:MouseEvent):void
         {
            _view.downButton.removeEventListener(Event.ENTER_FRAME,downScroll);
         };
         downScroll = function(param1:Event):void
         {
            if(_view.storyContent.y >= (_view.storyContent.height - 250) * -1)
            {
               _view.storyContent.y -= 10;
            }
         };
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
         _view.downButton.addEventListener(MouseEvent.MOUSE_UP,stopDownScroll);
         _view.upButton.addEventListener(MouseEvent.MOUSE_DOWN,startUpScroll);
         _view.upButton.addEventListener(MouseEvent.MOUSE_UP,stopUpScroll);
         _view.storyContent.y = 52;
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
            exit_end();
         }
      }
      
      private function randRange(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = NaN;
         return Math.floor(Math.random() * (param2 - param1 + 1)) + param1;
      }
      
      private function exit_end() : void
      {
         _view.mcContentShell.removeChildAt(0);
         _parentDisplay.removeChild(_view);
         EventBroadcaster.getInstance().dispatchEvent(new Event(EventStateMachine.STATE_EXITED));
      }
   }
}
