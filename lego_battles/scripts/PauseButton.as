package
{
   import flash.display.MovieClip;
   
   public dynamic class PauseButton extends MovieClip
   {
       
      
      public var placeholder_mc:PauseButtonNormal;
      
      public function PauseButton()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         stop();
         this.upLinkageID = "PauseButtonNormal";
         this.overLinkageID = "PauseButtonOver";
         this.downLinkageID = "PauseButtonDown";
         this.disabledLinkageID = "PauseButtonDisabled";
      }
   }
}
