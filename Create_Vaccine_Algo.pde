//Updates the progress of the vaccine as soon as 0.5% of the world is affected by the virus.
void createVaccine() {
  //Runs while the vaccine progress isn't 100% or the world hasn't been entirely infected
  if (hasVirusStarted && percentAffected >= 0.005 && frameCounter % 90 == 0 && vaccineProgress != 100 && percentAffected != 1) {
    vaccineProgress += round(100*float(1)/54);
    if (vaccineProgress > 100) {
     vaccineProgress = 100; 
    }
  }
}


void survival() {
  //If everyone is infected cells are deleted from the life and alive arrays and added to the dead array.
  //This gives the impression that everyone is succumbing to the disease.
  if (frameCounter % 45 == 0 && percentAffected == 1) {
    for (int i = 0; i < 10; i ++) {
      try {
      dead = (Cell[])append(dead, life[life.length-1]);
      life = (Cell[])shorten(life);
      }
      catch(Exception e) { }
    }
    
    for (int i = 0; i < 50; i ++) {
      try {
      dead = (Cell[])append(dead, alive[alive.length-1]);
      alive = (Cell[])shorten(alive);
      }
      catch(Exception e) { }
    }
  }
  
  //If a vaccine is made then remove objects from the infected cells array and the dead cells array and the stable cells array.
  else if (frameCounter % 30 == 0 && vaccineProgress == 100) {
       try {
         infectedAirports = (Point[])shorten(infectedAirports);
       }
       catch(Exception e) {}
    
       for (int i = 0; i < 50; i ++) {
         try {
           life = (Cell[])shorten(life);
           
         }
         catch(Exception e) {}
       }
       for (int i = 0; i < 50; i ++) {
         try {
           dead = (Cell[])shorten(dead);
        
         }
         catch(Exception e) {}
       }
       for (int i = 0; i < 50; i ++) {
         try {
           alive = (Cell[])shorten(alive);
         }
         catch(Exception e) {}
       }
       
       
    }
  }
