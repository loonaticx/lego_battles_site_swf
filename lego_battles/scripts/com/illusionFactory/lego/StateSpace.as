package com.illusionFactory.lego
{
   public class StateSpace extends StateWorldAbstract
   {
       
      
      public function StateSpace()
      {
         super();
         _name = "StateSpace";
         _xmlURL = "xml/space.xml";
         _leftWorld = "StateCastle";
         _rightWorld = "StatePirates";
      }
   }
}
