package com.illusionFactory.lego
{
   public class StateCastle extends StateWorldAbstract
   {
       
      
      public function StateCastle()
      {
         super();
         _name = "StateCastle";
         _xmlURL = "xml/castle.xml";
         _leftWorld = "StatePirates";
         _rightWorld = "StateSpace";
      }
   }
}
