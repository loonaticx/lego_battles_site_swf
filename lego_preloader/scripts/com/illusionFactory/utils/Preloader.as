package com.illusionFactory.utils
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   
   public class Preloader extends MovieClip
   {
       
      
      private var loader:Loader;
      
      private var flashVars:Object;
      
      public var mcLoadingAnimation:MovieClip;
      
      private var fileToLoad:URLRequest;
      
      public var percentUpdaterShell:MovieClip;
      
      public function Preloader()
      {
         super();
         fileToLoad = new URLRequest("lego_battles.swf");
         loader = new Loader();
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
         loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onProgress);
         loader.load(fileToLoad);
      }
      
      private function onProgress(param1:ProgressEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:uint = 0;
         _loc2_ = param1.bytesLoaded / param1.bytesTotal * 100;
         percentUpdaterShell.percentUpdater.updateText.text = int(_loc2_) + "%";
         _loc3_ = mcLoadingAnimation.totalFrames * (_loc2_ / 100);
         mcLoadingAnimation.gotoAndStop(_loc3_);
      }
      
      private function onComplete(param1:Event) : void
      {
         var _loc2_:* = undefined;
         loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onComplete);
         loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,onProgress);
         flashVars = this.loaderInfo.parameters;
         _loc2_ = this.addChild(loader.content);
      }
      
      public function getFlashVars() : Object
      {
         return flashVars;
      }
      
      private function onInit(param1:Event) : void
      {
      }
   }
}
