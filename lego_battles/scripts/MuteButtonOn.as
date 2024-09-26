package
{
   import flash.display.MovieClip;
   
   public dynamic class MuteButtonOn extends MovieClip
   {
       
      
      public var placeholder_mc:MuteButtonOnNormal;
      
      public function MuteButtonOn()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         stop();
         this.upLinkageID = "MuteButtonOnNormal";
         this.overLinkageID = "MuteButtonOnOver";
         this.downLinkageID = "MuteButtonOnDown";
         this.disabledLinkageID = "MuteButtonOnDisabled";
      }
   }
}
