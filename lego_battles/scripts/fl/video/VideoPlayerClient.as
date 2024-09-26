package fl.video
{
   public dynamic class VideoPlayerClient
   {
       
      
      private var _owner:VideoPlayer;
      
      public function VideoPlayerClient(param1:VideoPlayer)
      {
         super();
         _owner = param1;
      }
      
      public function get owner() : VideoPlayer
      {
         return _owner;
      }
      
      public function onCuePoint(param1:Object, ... rest) : void
      {
         _owner.flvplayback_internal::onCuePoint(param1);
      }
      
      public function onMetaData(param1:Object, ... rest) : void
      {
         _owner.flvplayback_internal::onMetaData(param1);
      }
   }
}
