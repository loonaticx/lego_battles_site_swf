package
{
   import flash.display.MovieClip;
   
   public dynamic class PlayButton extends MovieClip
   {
       
      
      public var placeholder_mc:PlayButtonNormal;
      
      public function PlayButton()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         stop();
         this.upLinkageID = "PlayButtonNormal";
         this.overLinkageID = "PlayButtonOver";
         this.downLinkageID = "PlayButtonDown";
         this.disabledLinkageID = "PlayButtonDisabled";
      }
   }
}
