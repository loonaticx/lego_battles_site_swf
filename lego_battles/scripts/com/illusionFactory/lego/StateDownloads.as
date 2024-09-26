package com.illusionFactory.lego
{
   import com.illusionFactory.StateMachineAS3.EventStateMachine;
   import com.illusionFactory.event.EventBroadcaster;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gs.TweenLite;
   import gs.easing.Back;
   import gs.easing.Bounce;
   import gs.easing.Strong;
   
   public class StateDownloads extends StateAbstract
   {
       
      
      private var aShells:Array;
      
      private const SPACING_VERTICAL:uint = 1;
      
      private const ORIGIN:Object = {
         "x":1,
         "y":45
      };
      
      private const NUM_COLS:Number = 3;
      
      private var coloringStartY:Number;
      
      private var currentShell:DownloadShell;
      
      private const SPACING_HORIZONTAL:uint = 1;
      
      private var bShells:Array;
      
      private var xmlData:XMLList;
      
      private var shellHeight:Number;
      
      public function StateDownloads()
      {
         super();
         _name = "StateDownloads";
         _view = new ViewDownloads();
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
      
      private function exit_end() : void
      {
         _view.mcLrg.removeChildAt(0);
         _parentDisplay.removeChild(_view);
         EventBroadcaster.getInstance().dispatchEvent(new Event(EventStateMachine.STATE_EXITED));
      }
      
      private function loadXML() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:Array = null;
         var _loc4_:Number = NaN;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:DownloadShell = null;
         var _loc10_:uint = 0;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:DownloadShell = null;
         var _loc16_:uint = 0;
         _loc1_ = 0;
         _loc2_ = 0;
         xmlData = _app.getXMLData("downloads");
         _view.section1.text = xmlData.wallpaper.attribute("title");
         _view.section2.text = xmlData.coloring.attribute("title");
         aShells = new Array();
         bShells = new Array();
         _loc3_ = new Array();
         _loc4_ = 0;
         while(_loc4_ < xmlData.wallpaper.item.length())
         {
            _loc5_ = String(xmlData.wallpaper.item.thumb[_loc4_]);
            _loc6_ = String(xmlData.wallpaper.item.image[_loc4_]);
            _loc7_ = String(xmlData.wallpaper.item[_loc4_].attribute("sml"));
            _loc8_ = String(xmlData.wallpaper.item[_loc4_].attribute("lrg"));
            _loc9_ = new DownloadShell(_loc5_,_loc6_,_loc7_,_loc8_,this);
            aShells.push(_loc9_);
            _loc9_.x = ORIGIN.x + _loc2_ * (SPACING_HORIZONTAL + _loc9_.width);
            _loc9_.y = ORIGIN.y + _loc1_ * (SPACING_VERTICAL + _loc9_.height);
            _loc2_++;
            if((_loc10_ = _loc4_ % NUM_COLS) == 2)
            {
               _loc1_++;
               _loc2_ = 0;
            }
            coloringStartY = _loc9_.y + _loc9_.height;
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < aShells.length)
         {
            _view.mcContentShell.addChild(aShells[_loc4_]);
            _loc4_++;
         }
         shellHeight = _loc1_ * (SPACING_VERTICAL + _loc9_.height);
         _view.section2.y = coloringStartY + _view.section2.height / 2;
         _loc4_ = 0;
         while(_loc4_ < xmlData.coloring.item.length())
         {
            _loc11_ = String(xmlData.coloring.item.thumb[_loc4_]);
            _loc12_ = String(xmlData.coloring.item.image[_loc4_]);
            _loc13_ = String(xmlData.coloring.item[_loc4_].attribute("url"));
            _loc14_ = "";
            _loc15_ = new DownloadShell(_loc11_,_loc12_,_loc13_,_loc14_,this);
            bShells.push(_loc15_);
            _loc15_.x = ORIGIN.x + _loc2_ * (SPACING_HORIZONTAL + _loc15_.width);
            _loc15_.y = ORIGIN.y + (_loc1_ * (SPACING_VERTICAL + _loc15_.height) + _view.section2.height + 5);
            _loc2_++;
            if((_loc16_ = _loc4_ % NUM_COLS) == 2)
            {
               _loc1_++;
               _loc2_ = 0;
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < bShells.length)
         {
            _view.mcContentShell.addChild(bShells[_loc4_]);
            _loc4_++;
         }
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
         _view.mcDownloadWP.visible = true;
         _view.mcDownloadColor.visible = false;
      }
      
      public function doLoadLargeImage(param1:DownloadShell) : void
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
      
      private function getShellIndex(param1:DownloadShell) : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:Number = NaN;
         _loc3_ = 0;
         while(_loc3_ < aShells.length)
         {
            if(param1 == aShells[_loc3_])
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < bShells.length)
         {
            if(param1 == bShells[_loc3_])
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}
