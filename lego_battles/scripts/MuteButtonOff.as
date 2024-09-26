package
{
   import flash.display.MovieClip;
   
   public dynamic class MuteButtonOff extends MovieClip
   {
       
      
      public var placeholder_mc:MuteButtonOffNormal;
      
      public function MuteButtonOff()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         stop();
         this.upLinkageID = "MuteButtonOffNormal";
         this.overLinkageID = "MuteButtonOffOver";
         this.downLinkageID = "MuteButtonOffDown";
         this.disabledLinkageID = "MuteButtonOffDisabled";
      }
   }
}
