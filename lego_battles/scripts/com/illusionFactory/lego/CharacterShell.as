package com.illusionFactory.lego
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.text.TextField;
   
   public class CharacterShell extends MovieClip
   {
       
      
      private var __sThumb:String;
      
      public var mcHit:MovieClip;
      
      public var shade:MovieClip;
      
      private var __sLarge:String;
      
      public var mcProjectImage:MovieClip;
      
      private var __sTitle:String;
      
      private var __owner:StateCharacters;
      
      public function CharacterShell(param1:String, param2:String, param3:String, param4:StateCharacters)
      {
         super();
         __sTitle = param1;
         __sThumb = param2;
         __sLarge = param3;
         __owner = param4;
         this.addEventListener(Event.ADDED_TO_STAGE,init);
      }
      
      private function init(param1:Event) : void
      {
         var _loc2_:Loader = null;
         this.removeEventListener(Event.ADDED_TO_STAGE,init);
         _loc2_ = new Loader();
         _loc2_.load(new URLRequest(__sThumb));
         this.mcProjectImage.addChild(_loc2_);
         this.hitArea = this["mcHit"];
         enable();
      }
      
      private function loadLargeImage(param1:MouseEvent) : *
      {
         var _loc2_:Loader = null;
         var _loc3_:MovieClip = null;
         var _loc4_:TextField = null;
         _loc2_ = new Loader();
         _loc2_.load(new URLRequest(__sLarge));
         _loc3_ = parent.parent["mcLrg"];
         if(_loc3_.numChildren > 0)
         {
            _loc3_.removeChildAt(0);
         }
         _loc3_.addChildAt(_loc2_,0);
         (_loc4_ = parent.parent["characterName"]).text = __sTitle;
         __owner.doLoadLargeImage(this);
      }
      
      public function enable() : void
      {
         this.buttonMode = true;
         this.addEventListener(MouseEvent.CLICK,loadLargeImage);
         this.addEventListener(MouseEvent.ROLL_OVER,handler_rollOver);
         this.addEventListener(MouseEvent.ROLL_OUT,handler_rollOut);
      }
      
      private function handler_rollOver(param1:MouseEvent) : void
      {
         this["shade"].visible = false;
      }
      
      private function handler_rollOut(param1:MouseEvent) : void
      {
         this["shade"].visible = true;
      }
      
      public function disable() : void
      {
         this.buttonMode = false;
         this.removeEventListener(MouseEvent.CLICK,loadLargeImage);
         this.removeEventListener(MouseEvent.ROLL_OVER,handler_rollOver);
         this.removeEventListener(MouseEvent.ROLL_OUT,handler_rollOut);
      }
   }
}
