package com.illusionFactory.lego
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class DownloadShell extends MovieClip
   {
       
      
      private var __sThumb:String;
      
      public var mcHit:MovieClip;
      
      public var shade:MovieClip;
      
      private var __sLarge:String;
      
      public var mcProjectImage:MovieClip;
      
      private var __sTitle:String;
      
      private var __sSmallURL:String;
      
      private var __owner:StateDownloads;
      
      private var __sLargeURL:String;
      
      public function DownloadShell(param1:String, param2:String, param3:String, param4:String, param5:StateDownloads)
      {
         super();
         __sThumb = param1;
         __sLarge = param2;
         __sSmallURL = param3;
         __sLargeURL = param4;
         __owner = param5;
         this.addEventListener(Event.ADDED_TO_STAGE,init);
      }
      
      private function handle_smallWP(param1:MouseEvent) : void
      {
         var _loc2_:URLRequest = null;
         _loc2_ = new URLRequest(__sSmallURL);
         navigateToURL(_loc2_,"_blank");
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
      
      private function handle_largeWP(param1:MouseEvent) : void
      {
         var _loc2_:URLRequest = null;
         _loc2_ = new URLRequest(__sLargeURL);
         navigateToURL(_loc2_,"_blank");
      }
      
      private function loadLargeImage(param1:MouseEvent) : void
      {
         var _loc2_:Loader = null;
         var _loc3_:MovieClip = null;
         if(__sLargeURL == "")
         {
            parent.parent["mcDownloadWP"].visible = false;
            parent.parent["mcDownloadColor"].visible = true;
            parent.parent["mcDownloadColor"].addEventListener(MouseEvent.CLICK,handle_colorDownloads);
         }
         else
         {
            parent.parent["mcDownloadWP"].visible = true;
            parent.parent["mcDownloadColor"].visible = false;
            parent.parent["mcDownloadWP"].mcLarge.addEventListener(MouseEvent.CLICK,handle_largeWP);
            parent.parent["mcDownloadWP"].mcSmall.addEventListener(MouseEvent.CLICK,handle_smallWP);
         }
         _loc2_ = new Loader();
         _loc2_.load(new URLRequest(__sLarge));
         _loc3_ = parent.parent["mcLrg"];
         if(_loc3_.numChildren > 0)
         {
            _loc3_.removeChildAt(0);
         }
         _loc3_.addChildAt(_loc2_,0);
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
      
      private function handle_colorDownloads(param1:MouseEvent) : void
      {
         var _loc2_:URLRequest = null;
         _loc2_ = new URLRequest(__sSmallURL);
         navigateToURL(_loc2_,"_blank");
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
