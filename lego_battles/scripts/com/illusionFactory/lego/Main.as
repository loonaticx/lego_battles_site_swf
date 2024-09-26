package com.illusionFactory.lego
{
   import com.illusionFactory.StateMachineAS3.EventStateMachine;
   import com.illusionFactory.utils.XMLParser;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class Main extends MovieClip
   {
      
      public static const STATE_TRAILER:String = "StateTrailer";
      
      public static const STATE_CASTLE:String = "StateCastle";
      
      public static const STATE_STORY:String = "StateStory";
      
      public static const STATE_PIRATES:String = "StatePirates";
      
      private static var xmlParser:XMLParser;
      
      public static const STATE_SUPPORT:String = "StateSupport";
      
      public static const STATE_GALLERY:String = "StateGallery";
      
      public static const STATE_SPACE:String = "StateSpace";
      
      private static var sXMLURL:String;
      
      public static const STATE_CREDITS:String = "StateCredits";
      
      public static const STATE_START:String = "StateStart";
      
      public static const STATE_CHARACTERS:String = "StateCharacters";
      
      private static var xmlData:XML;
      
      public static const STATE_DOWNLOADS:String = "StateDownloads";
       
      
      public var worlds:MovieClip;
      
      private var _stateCastle:StateCastle;
      
      private var _sectionStateMachine:EventStateMachine;
      
      private var _sStartSection:String;
      
      private var _statePirates:StatePirates;
      
      private var _stateTrailer:StateTrailer;
      
      private var _stateStory:StateStory;
      
      private var _stateDownloads:StateDownloads;
      
      private var _stateGallery:StateGallery;
      
      private var _stateCredits:StateCredits;
      
      private var _worldStateMachine:EventStateMachine;
      
      private var _stateSpace:StateSpace;
      
      private var _stateCharacters:StateCharacters;
      
      private var _stateSupport:StateSupport;
      
      private var _stateStart:StateStart;
      
      public function Main()
      {
         super();
         this.addEventListener(Event.ADDED_TO_STAGE,init);
      }
      
      public static function get xmlURL() : String
      {
         return sXMLURL;
      }
      
      public static function set xmlURL(param1:String) : void
      {
         sXMLURL = "xml/site_content.xml";
         xmlParser = new XMLParser(sXMLURL);
      }
      
      private function init(param1:Event) : void
      {
         var oFlashVars:Object = null;
         var aWorlds:Array = null;
         var startWorld:* = undefined;
         var evt:Event = param1;
         this.removeEventListener(Event.ADDED_TO_STAGE,init);
         oFlashVars = new Object();
         try
         {
            oFlashVars = parent["getFlashVars"]();
         }
         catch(error:Error)
         {
         }
         parseFlashVars(oFlashVars);
         _stateCastle = new StateCastle();
         _statePirates = new StatePirates();
         _stateSpace = new StateSpace();
         aWorlds = new Array(STATE_CASTLE,STATE_PIRATES,STATE_SPACE);
         startWorld = aWorlds[randRange(0,aWorlds.length - 1)];
         _worldStateMachine = new EventStateMachine([{
            "state":_stateCastle,
            "allowedStates":[STATE_PIRATES,STATE_SPACE]
         },{
            "state":_statePirates,
            "allowedStates":[STATE_CASTLE,STATE_SPACE]
         },{
            "state":_stateSpace,
            "allowedStates":[STATE_CASTLE,STATE_PIRATES]
         }],startWorld,null,{
            "display":this["worlds"],
            "app":this
         });
         _stateStart = new StateStart();
         _stateCharacters = new StateCharacters();
         _stateStory = new StateStory();
         _stateDownloads = new StateDownloads();
         _stateTrailer = new StateTrailer();
         _stateGallery = new StateGallery();
         _stateCredits = new StateCredits();
         _stateSupport = new StateSupport();
         _sectionStateMachine = new EventStateMachine([{
            "state":_stateStart,
            "allowedStates":[STATE_CHARACTERS,STATE_STORY,STATE_DOWNLOADS,STATE_TRAILER,STATE_GALLERY,STATE_CREDITS,STATE_SUPPORT]
         },{
            "state":_stateCharacters,
            "allowedStates":[STATE_START,STATE_STORY,STATE_DOWNLOADS,STATE_TRAILER,STATE_GALLERY,STATE_CREDITS,STATE_SUPPORT]
         },{
            "state":_stateStory,
            "allowedStates":[STATE_CHARACTERS,STATE_START,STATE_DOWNLOADS,STATE_TRAILER,STATE_GALLERY,STATE_CREDITS,STATE_SUPPORT]
         },{
            "state":_stateDownloads,
            "allowedStates":[STATE_CHARACTERS,STATE_STORY,STATE_START,STATE_TRAILER,STATE_GALLERY,STATE_CREDITS,STATE_SUPPORT]
         },{
            "state":_stateTrailer,
            "allowedStates":[STATE_CHARACTERS,STATE_STORY,STATE_DOWNLOADS,STATE_START,STATE_GALLERY,STATE_CREDITS,STATE_SUPPORT]
         },{
            "state":_stateGallery,
            "allowedStates":[STATE_CHARACTERS,STATE_STORY,STATE_DOWNLOADS,STATE_TRAILER,STATE_START,STATE_CREDITS,STATE_SUPPORT]
         },{
            "state":_stateCredits,
            "allowedStates":[STATE_CHARACTERS,STATE_STORY,STATE_DOWNLOADS,STATE_TRAILER,STATE_GALLERY,STATE_START,STATE_SUPPORT]
         },{
            "state":_stateSupport,
            "allowedStates":[STATE_CHARACTERS,STATE_STORY,STATE_DOWNLOADS,STATE_TRAILER,STATE_GALLERY,STATE_CREDITS,STATE_START]
         }],STATE_START,null,{
            "parentDisplay":this["worlds"],
            "app":this
         });
      }
      
      public function getXMLData(param1:String) : XMLList
      {
         var _loc2_:XMLList = null;
         return xmlParser.xmlData[param1];
      }
      
      private function randRange(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = NaN;
         return Math.floor(Math.random() * (param2 - param1 + 1)) + param1;
      }
      
      public function getWorldStateMachine() : EventStateMachine
      {
         return _worldStateMachine;
      }
      
      public function getStartSection() : String
      {
         return _sStartSection;
      }
      
      public function getSectionStateMachine() : EventStateMachine
      {
         return _sectionStateMachine;
      }
      
      public function parseFlashVars(param1:Object) : void
      {
         switch(param1["page"])
         {
            case "characters":
               _sStartSection = STATE_CHARACTERS;
               break;
            case "story":
               _sStartSection = STATE_STORY;
               break;
            case "downloads":
               _sStartSection = STATE_DOWNLOADS;
               break;
            case "trailer":
               _sStartSection = STATE_TRAILER;
               break;
            case "gallery":
               _sStartSection = STATE_GALLERY;
               break;
            case "support":
               _sStartSection = STATE_SUPPORT;
               break;
            case "credits":
               _sStartSection = STATE_CREDITS;
               break;
            default:
               _sStartSection = STATE_START;
         }
      }
   }
}
