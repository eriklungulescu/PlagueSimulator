void createVirus() {
  if (frameCounter % 30 == 0 && vaccineProgress != 100 && percentAffected != 1) {
    
    int count = life.length; //Current amount of cells that can infect others.
    
    for (int i = 0; i<count; i++){
      int decider = round(random(0,100)); //Here it is decided whether a cell will infect others or have their outcome decided.
      
        if (decider <= infectability) { //If the decider is less than the infectability, the cell will attempt to infect neighbouring cells.
          int possibilityCounter = 0; //Used by the Cell constructor method to ensure every square around an individual is infected.
          
          while (possibilityCounter < 8) { //There can be at most 9 cells infected by a individual.
            Cell possibleCell = new Cell(life[i].xPos,life[i].yPos, possibilityCounter); //Creates a possible cell.
            Point cellPoint = new Point(possibleCell.xPos,possibleCell.yPos);
            
            //True or false values used to make sure the spread of the virus follows the rules.
            boolean isLand = false;
            boolean isCell = false;
            boolean isAirport = false;
            boolean isInfectedAirport = false;

            //If the cell is infecting an airport, check to see if the airport is already infected or not. If it isn't infected, its coordinates are added to the list of infected airports.
            for (int w = 0; w < airportCoordinates.length; w ++) {
              if (cellPoint.isEqual(airportCoordinates[w])) {
                for (int m = 0; m < infectedAirports.length; m ++) {
                  if (cellPoint.isEqual(infectedAirports[m])) {
                    isInfectedAirport = true;
                    break;
                  }
                }
                if (!isInfectedAirport) {
                  infectedAirports = (Point[])append(infectedAirports, cellPoint);
                  existingCellCoordinates = (Point[])append(existingCellCoordinates, cellPoint);
                }
                isAirport = true;
              }
            }
            //If the cell isn't infecting an airport, then check to see if the possible cell is on land, and isn't infecting a taken cell.
            if (!isAirport) {
              //Checks that its on land.
              for (int m = 0; m < takenLandCoordinates.length; m ++) {
                if (cellPoint.isEqual(takenLandCoordinates[m])){
                  isLand = true;
                  break;
                }   
              }
              
              //Chekcs that it isn't taking a taken cell.
              for (int n = 0; n < existingCellCoordinates.length; n ++) {
                if (cellPoint.isEqual(existingCellCoordinates[n])){
                  isCell = true;
                  break;
                }
              }
              
              //If it satisfies the above conditions than that cell becomes infected and is added to the array.
              if (isLand && !isCell) {
                Cell newCell = possibleCell; //New cell gets added to the array.
                life = (Cell[])append(life, newCell); 
                existingCellCoordinates = (Point[])append(existingCellCoordinates, cellPoint); //Coordinate which are taken are updated.
              }
            }  
            possibilityCounter ++; //Moves on to the next possible infected cell.
          }
        }
        else { //Decided that the cell will not infect others and instead will either die or be cured.
           int decider2 = round(random(0,100)); //If the decider is less than the death rate the cell dies.
           if (decider2 <= deathRate){
             dead = (Cell[])append(dead, life[i]); //Adds the cell and its data to the list of the dead.
          }
           else {
             alive = (Cell[])append(alive, life[i]); //Adds the cell and its data to the list of those that survived.
           }
           Cell tempValue = life[i]; //The current cell swaps position with the last cell in the array and then that cell is removed from the array of life (being in array of life means that cells are still infectious).
           life[i] = life[life.length-1];
           life[life.length-1] = tempValue;
           life = (Cell[])shorten(life);
           count = count-1;   
    
        }    
    } 
  }
}
