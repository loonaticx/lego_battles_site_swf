package
{
   import flash.display.MovieClip;
   
   public dynamic class SeekBar extends MovieClip
   {
       
      
      public function SeekBar()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         stop();
         this.handleLinkageID = "SeekBarHandle";
         this.handleLeftMargin = 2;
         this.handleRightMargin = 2;
         this.handleY = 11;
      }
   }
}
