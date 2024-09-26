package com.illusionFactory.lego
{
   public class StatePirates extends StateWorldAbstract
   {
       
      
      public function StatePirates()
      {
         super();
         _name = "StatePirates";
         _xmlURL = "xml/pirates.xml";
         _leftWorld = "StateSpace";
         _rightWorld = "StateCastle";
      }
   }
}
