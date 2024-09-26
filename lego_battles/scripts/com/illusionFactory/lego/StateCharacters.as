package com.illusionFactory.lego
{
   import com.illusionFactory.StateMachineAS3.EventStateMachine;
   import com.illusionFactory.event.EventBroadcaster;
   import com.illusionFactory.utils.RandomArrayIndeces;
   import flash.display.Loader;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gs.TweenLite;
   import gs.easing.Back;
   import gs.easing.Bounce;
   import gs.easing.Strong;
   
   public class StateCharacters extends StateAbstract
   {
       
      
      private var aShells:Array;
      
      private const SPACING_VERTICAL:uint = 1;
      
      private var largeInc:Number;
      
      private const ORIGIN:Object = {
         "x":1,
         "y":1
      };
      
      private var thumbInc:Number = 324;
      
      private const NUM_COLS:Number = 3;
      
      private var currentShell:CharacterShell;
      
      private const SPACING_HORIZONTAL:uint = 1;
      
      private var xmlData:XMLList;
      
      private var pageCounter:Number = 0;
      
      private const SHELLS_ON_PAGE:Number = 12;
      
      private var loadLarge:Loader;
      
      private var shellHeight:Number;
      
      public function StateCharacters()
      {
         pageCounter = 0;
         thumbInc = 324;
         super();
         _name = "StateCharacters";
         _view = new ViewCharacters();
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
      
      internal function moreDown(param1:MouseEvent) : void
      {
         _view.mcMoreButtonDown.removeEventListener(MouseEvent.CLICK,moreDown);
         if(pageCounter < shellHeight / thumbInc - 1)
         {
            TweenLite.to(_view.mcContentShell,1,{
               "y":"-" + thumbInc.toString(),
               "ease":Strong.easeInOut,
               "onComplete":reActivate,
               "onCompleteParams":[_view.mcMoreButtonDown,moreDown]
            });
            ++pageCounter;
         }
         else
         {
            _view.mcMoreButtonDown.addEventListener(MouseEvent.CLICK,moreDown);
         }
      }
      
      private function exit_end() : void
      {
         var _loc1_:uint = 0;
         currentShell = null;
         _view.mcLrg.removeChildAt(0);
         _loc1_ = 0;
         while(_loc1_ < aShells.length)
         {
            _view.mcContentShell.removeChild(aShells[_loc1_]);
            _loc1_++;
         }
         _parentDisplay.removeChild(_view);
         EventBroadcaster.getInstance().dispatchEvent(new Event(EventStateMachine.STATE_EXITED));
      }
      
      internal function reActivate(param1:SimpleButton, param2:Function) : void
      {
         param1.addEventListener(MouseEvent.CLICK,param2);
      }
      
      private function loadXML() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:Array = null;
         var _loc4_:RandomArrayIndeces = null;
         var _loc5_:uint = 0;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:CharacterShell = null;
         var _loc10_:GalleryBorder = null;
         var _loc11_:uint = 0;
         _loc1_ = 0;
         _loc2_ = 0;
         xmlData = _app.getXMLData("characters");
         aShells = new Array();
         _loc3_ = new Array();
         _loc4_ = new RandomArrayIndeces(xmlData.item.length());
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = String(xmlData.item.thumb[_loc4_[_loc5_]]);
            _loc7_ = String(xmlData.item.image[_loc4_[_loc5_]]);
            _loc8_ = String(xmlData.item.charName[_loc4_[_loc5_]]);
            _loc9_ = new CharacterShell(_loc8_,_loc6_,_loc7_,this);
            aShells.push(_loc9_);
            _loc9_.x = ORIGIN.x + _loc2_ * (SPACING_HORIZONTAL + _loc9_.width);
            _loc9_.y = ORIGIN.y + _loc1_ * (SPACING_VERTICAL + _loc9_.height);
            _loc10_ = new GalleryBorder();
            _loc3_.push(_loc10_);
            _loc10_.y = _loc9_.y;
            _loc2_++;
            if((_loc11_ = _loc5_ % NUM_COLS) == 2)
            {
               _loc1_++;
               _loc2_ = 0;
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < aShells.length)
         {
            _view.mcContentShell.addChild(aShells[_loc5_]);
            _loc5_++;
         }
         shellHeight = _loc1_ * (SPACING_VERTICAL + _loc9_.height);
         _loc5_ = 1;
         while(_loc5_ < 3)
         {
            (_loc10_ = new GalleryBorder()).width = shellHeight;
            _loc10_.rotation = 90;
            _loc10_.x = (_loc9_.width + SPACING_HORIZONTAL) * _loc5_ + 1;
            _view.mcContentShell.addChild(_loc10_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _view.mcContentShell.addChild(_loc3_[_loc5_]);
            _loc5_++;
         }
         _view.mcMoreButtonUp.addEventListener(MouseEvent.CLICK,moreUp);
         _view.mcMoreButtonDown.addEventListener(MouseEvent.CLICK,moreDown);
         largeInc = 0;
         aShells[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
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
      }
      
      public function doLoadLargeImage(param1:CharacterShell) : void
      {
         if(currentShell)
         {
            currentShell.enable();
            currentShell.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));
         }
         currentShell = param1;
         currentShell.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
         currentShell.disable();
      }
      
      internal function moreUp(param1:MouseEvent) : void
      {
         _view.mcMoreButtonUp.removeEventListener(MouseEvent.CLICK,moreUp);
         if(pageCounter > 0)
         {
            TweenLite.to(_view.mcContentShell,1,{
               "y":thumbInc.toString(),
               "ease":Strong.easeInOut,
               "onComplete":reActivate,
               "onCompleteParams":[_view.mcMoreButtonUp,moreUp]
            });
            --pageCounter;
         }
         else
         {
            _view.mcMoreButtonUp.addEventListener(MouseEvent.CLICK,moreUp);
         }
      }
   }
}
