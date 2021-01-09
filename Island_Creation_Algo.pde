 
void createIslands() {
  
    //Choses number of islands.
    int numIslands = int(random(3,5));
   
    
    for (int m = 0; m < numIslands; m ++) {
      //Determines the changes in width to the islands/countries.
      int numIslandChanges = round(random(3,5));
      
      //If the island expansion value is true, the width of the island increases as you go up, otherwise it decreases.
      boolean[] islandExpansion = new boolean[numIslandChanges];
      islandExpansion[0] = true;
      islandExpansion[numIslandChanges-1] = false;
      
      //Assigning values.
      for (int i = 1; i < islandExpansion.length-1; i ++) {
        int decider = round(random(0,1));
        if (decider == 1)
          islandExpansion[i] = true;
        else
          islandExpansion[i] = false;
      }
      
      //Height of the island (How many rows of pixels there are).
      int heightIsland = int(random(40, 65));
      //Makes it a multiple of the length of islandChanges.
      heightIsland = -heightIsland%numIslandChanges+heightIsland+numIslandChanges; 
      //Maximum width (How many pixels there are in a row).
      int maxWidthIsland = int(random(30, 45));
      
      //Makes random starting values, they are different for every island.
      int xInit = int(random(width/2*(m%2), width/2*(m%2) + width/2));
      xInit = -xInit%10 + xInit;
      int yInit = int(random(height/2*(m%2) + heightIsland, height/2*(m%2) + height/2 + heightIsland));
      yInit = -yInit%10 + yInit;
    
      //Values used to create island.
      int offSet = int(random(-3,3));
      int stripSize = int(random(maxWidthIsland/4,maxWidthIsland/3));
      int dx = 0;
      int dy = 0;
      
      //Intervals of width increase and decrease.
      int intervalSize = heightIsland/numIslandChanges;
      
      
      for (int i = 0; i < heightIsland; i ++) {
        //If the value is true, increase the width.
        if (islandExpansion[int(i/intervalSize)]) {
          stripSize += int(random(2,5));
        }
        //Otherwise decrease the width.
        else{
          stripSize -= int(random(3,8));
          if (stripSize <= 0) {
            stripSize = 0;
            heightIsland = i; //Stops the loop.
          }
        }
        
        //Draws the current row.
        for (int j = -int(stripSize/2)+offSet; j < int(stripSize/2)+offSet; j ++){
          dx = j*10;
          dy = -i*10;
          
          if (xInit + dx>=0 && xInit + dx < width && yInit + dy >=0 && yInit + dy < height) {
          Point newPoint = new Point(xInit + dx, yInit + dy);
          boolean canDrawLand = true;
          
          //Checks to see if it is trying to build on existing land and prevents it from doing so.
          for (int n = 0; n < takenLandCoordinates.length; n ++) {
            if (newPoint.isEqual(takenLandCoordinates[n])) {
              canDrawLand = false;
              break;
            }
          }
          
          if (canDrawLand) {
            fill(90,178,2);
            square(xInit+dx, yInit+dy, 10);
            Point takenLandPoint = new Point(xInit+dx, yInit+dy);
            takenLandCoordinates = (Point[])append(takenLandCoordinates, takenLandPoint);
          }
         }
        }
        
        //if the end of the loop is reached build an airport on the island.
        if (i >= heightIsland-1) {
          float tempY;
          float tempX;
          //Puts the airport in the middle of the island.
          dy = dy/2;
          dy = -dy%10 + dy;
          if (yInit + dy >= 0 && yInit + dy <= height) {
            tempY = yInit + dy;
          }
          else if (yInit + dy < 0) {
            tempY = 10;
          }
          
          else {
            tempY = -height%10 + height - 30;
          }
          
          if (xInit + offSet*10 >= 0 && xInit + offSet*10 <= width) {
            tempX = xInit;
          }
          
          else if (xInit + offSet*10 < 0) {
            tempX = 20;
          }
          
          else {
            tempX = -width%10 + width - 30;
          }
          //Checks used to make sure the airport is on land.
          boolean airportIsOnLand = false;
          float checkX = 0; 
          int counter = 1;
          float secondCounter = 0.5;
          //Builds points left and right of the chosen point that could be in water, currently the y-value is in the middle of the island, so it's only the x-value that could 
          //cause the airport to be on water. By scanning left and right it is guaranteed that the airport will be on an island.
          while (airportIsOnLand == false) {
            for (int o = 0; o < takenLandCoordinates.length; o ++) {
              Point testPoint = new Point(checkX + tempX, tempY);
              if (testPoint.isEqual(takenLandCoordinates[o]));
                airportIsOnLand = true;
           
            }
            checkX += 10*round(secondCounter)*pow(-1,counter);
            counter++;
            secondCounter += 0.5;
          }
          tempX += checkX ;
            Point airportCoordinate = new Point(tempX, tempY);
            airportCoordinates = (Point[])append(airportCoordinates, airportCoordinate);
            numAirports ++;
          }
           offSet += int(random(-6,6));
           numAirplanes = numAirports + int(random(5,10));
       }
       
    }

    //Removes most peninsulas on the map to allow for a more accurate spread of a virus.
    int counter = takenLandCoordinates.length;
    
    for (int m = 0; m < counter; m ++) {
      Point testPoint1 = new Point(takenLandCoordinates[m].xPos, takenLandCoordinates[m].yPos+10);
      Point testPoint2 = new Point(takenLandCoordinates[m].xPos, takenLandCoordinates[m].yPos-10);
      int truthCounter = 0;
      //If either the coordinate above a cell and below a cell are on land, the current cell must not be a peninsula. The truth counter must be greater than 0.
      for (int n = 0; n < counter; n ++) {
        
        if (testPoint1.isEqual(takenLandCoordinates[n])) {
          truthCounter ++;
        }
        if (testPoint2.isEqual(takenLandCoordinates[n])) {
          truthCounter ++;
        }        
      }
      //If the truth counter is 0, the land below and above the cell must be water and thus the current cell must be a peninsula.
      if (truthCounter == 0) {
        //Swaps the current cell and the last cell and then removes the final object in the array.
        Point tempValue = takenLandCoordinates[m];
        takenLandCoordinates[m] = takenLandCoordinates[takenLandCoordinates.length-1];
        takenLandCoordinates[takenLandCoordinates.length-1] = tempValue;
        takenLandCoordinates = (Point[])shorten(takenLandCoordinates);
        counter --;
      }
    }
}   
