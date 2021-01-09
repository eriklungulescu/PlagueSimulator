//Rules
//A cell refers to a population illustrated by a square on the sketch.
//A cell will infect all others around unless they are cured or have died.
//Essentially, dead or stable cells are NOT allowed to become infected again or infect others.
//The user clicks where the virus starts
//The user can click however many times they wish


//EDIT THESE VALUES
boolean manualControl = false; //having manualControl(mC) be false makes the virus start randomly. 
//Having mC be true allows for the user to click where they want to virus to start. However, the user can click to start a virus anywhere with either option.

String diseaseName = "Pan-2020"; //Name of the virus.
String nationName = "Earth"; //Name of the nation/world.

//Recommended to be from 0,10, it makes it more even, if one has a super large number the simulation isn't very interesting.
int nationIntelligence = 5; //Having a relatively higher nation intelligence will have the nation attempt to stifle the virus.
int virusAggresiveness = 7; //Having a relatively higher virus aggresiveness will have the virus mutate and become more dangerous. 

int infectability = 75; //How likely a person is to infect others around them before their outcome is determined -> Currently 75% change of infecting others. Number from (0,100).
float deathRate = 90; //How likely a person is to die -> Currently there is a 90% chance that the individual will die from their infection. Number from (0,100);

int speedAirplane = 15; //Speed of an airplane.
int blinksPerSecond = 60; //Recommended to have a framerate of 30 or higher.

//DO NOT TOUCH THESE VALUES:
Cell[] life = new Cell[0];
Cell[] dead = new Cell[0];
Cell[] alive = new Cell[0];
Point[] infectedAirports = new Point[0];
Point[] takenLandCoordinates = new Point[0];
Point[] existingCellCoordinates = new Point[0];
Point[] airportCoordinates = new Point[0];
Airplane[] airplanes = new Airplane[0];
int numAirports;
int numAirplanes;
boolean areAirportsOpen = true;
boolean hasVirusStarted = false;
float percentAffected;
PFont f;
String news = "Loading News...";
int frameCounter = 0;
int week = 1;
int vaccineProductionDays = 0;
float vaccineProgress = 0;

void setup() {
  frameRate(blinksPerSecond); //Slower framerate to allow for easier viewing of the spread of the virus. Recommended framerate of 30.
  fullScreen(P3D); //Makes the sketch fit to the screen.
  f = createFont("Times New Roman", 18); //Font.
  createIslands(); //Creates land.
  createAirplane();  //Creates airplanes.
  
  //If manual control is set to false, the virus starts in a random location.
  int randomCoordinate = int(random(0, takenLandCoordinates.length));
  
  if (!manualControl) {
    Cell startingCell = new Cell(takenLandCoordinates[randomCoordinate].xPos, takenLandCoordinates[randomCoordinate].yPos);
    life = (Cell[])append(life, startingCell);
    Point startingPoint = new Point(takenLandCoordinates[randomCoordinate].xPos, takenLandCoordinates[randomCoordinate].yPos);
    existingCellCoordinates = (Point[])append(existingCellCoordinates, startingPoint);
    hasVirusStarted = true;
  }
  
 
}


void draw() {
  background(165, 195, 201); //Colour of background
  //Draws Everything
  percentAffected = float(life.length + dead.length + alive.length + infectedAirports.length)/takenLandCoordinates.length;
  drawEverything();
  updateAirplanes();
  createVaccine();
  createNews();
  createVirus();
  survival();
  weekCounter();
   
    
  frameCounter++;
  }


void mousePressed(){
  float currX = mouseX;
  float currY = mouseY;
  //Forces the chosen coordinates to be a multiple of 10.
  currX = -currX%10 + currX;
  currY = -currY%10 + currY;
  //True and false values to make sure the virus is placed on an untouched cell on land.
  boolean isPlacedOnLand = false;
  boolean isPlacedOnInfected = false;
  boolean isPlacedOnDead = false;
  boolean isPlacedOnStable = false;
   
  //Chekcs that the cell is on land.
  for (int m = 0; m < takenLandCoordinates.length; m ++) {
    if (currX == takenLandCoordinates[m].xPos && currY == takenLandCoordinates[m].yPos) {
      isPlacedOnLand = true;
      break;
    }
  }
  
  //Checks that it is not being placed on an infected cell.
  for (int m = 0; m < life.length; m ++) {
    if (currX == life[m].xPos && currY == life[m].yPos) {
      isPlacedOnInfected = true;
      break;
    }
  }
  
  //Checks that it is not being placed on an dead cell.
  for (int m = 0; m < dead.length; m ++) {
    if (currX == dead[m].xPos && currY == dead[m].yPos) {
      isPlacedOnDead = true;
      break;
    }
  }
  
  //Checks that it is not being placed on an stable cell.
  for (int m = 0; m < alive.length; m ++) {
    if (currX == alive[m].xPos && currY == alive[m].yPos) {
      isPlacedOnStable = true;
      break;
    }
  }
  
  //If the rules are satisfied, the virus starts at the chosen location.
  if (isPlacedOnLand==true &&isPlacedOnInfected==false && isPlacedOnDead==false && isPlacedOnStable==false) {
  Cell newCell = new Cell(currX, currY); //Uses a Cell constructor method to create a cell on click.
  Point newPoint = new Point(currX, currY);
  life = (Cell[])append(life, newCell); //Adds the cell and its data to the array of life.
  existingCellCoordinates = (Point[])append(existingCellCoordinates,newPoint);
  hasVirusStarted = true;
  
  }
  else {
    println("Cannot be placed here!");
  }
}


void drawEverything() {
  
  //Draws all of the islands.
  for (int m = 0; m < takenLandCoordinates.length; m ++) {
    fill(34,139,34);
    square(takenLandCoordinates[m].xPos,takenLandCoordinates[m].yPos,10);
  }
  
  //Draws the airports.
  for (int w = 0; w < airportCoordinates.length; w ++) {
    fill(125,125,125);
    square(airportCoordinates[w].xPos, airportCoordinates[w].yPos, 10);
  }
  
  
  
  //Draws all cells which have died.
  for (int w = 0; w < dead.length; w++) {
    dead[w].kill();
  }
  
  //Draws all cells which have survived.
  for (int w = 0; w < alive.length; w ++) {
    alive[w].stable();
  }
  
  //Draws on the screen all cells that are infected an have yet to experience an outcome.
  for (int w = 0; w<life.length; w++){
    life[w].create();
  }
  
  //Draws all infected airports.
  for (int w = 0; w < infectedAirports.length; w ++) {
    fill(75,0,130);
    square(infectedAirports[w].xPos, infectedAirports[w].yPos, 10);
  }
   
}

void updateAirplanes() {
  //if the percent affected by the virus is greater than 25% airports are closed.
  if (float(alive.length + life.length+ dead.length + infectedAirports.length)/takenLandCoordinates.length > 0.25) {
    areAirportsOpen = false;
  }
  else {
    areAirportsOpen = true;
  }
  int counter = airplanes.length;
  
  for (int i = 0; i < counter; i ++) {
    //Draws the airplanes and updates their coordinates.
   fill(50,60,120);
   square(airplanes[i].xPos, airplanes[i].yPos, 5);
   airplanes[i].xPos += airplanes[i].xSpeed;
   airplanes[i].yPos += airplanes[i].ySpeed;
   
   //If the plane is close enough to an airport, it is considered that it has "landed". The function used essentially finds the distance between two points.
   if (getDistance(airplanes[i].xPos,airplanes[i].yPos, airportCoordinates[airplanes[i].chosenAirport].xPos, airportCoordinates[airplanes[i].chosenAirport].yPos) <= speedAirplane*1.5) {
     //Sets the coordinates of the airplane to that of the airport.
     airplanes[i].xPos = airportCoordinates[airplanes[i].chosenAirport].xPos;
     airplanes[i].yPos = airportCoordinates[airplanes[i].chosenAirport].yPos;
     
 
    
     //If the plane is not infected, check to see if its coordinates match with an infected airport, if it does, the airplane is now considered infected.
     if (!airplanes[i].isInfected) {
        for (int n = 0; n < infectedAirports.length; n ++) {
           if (airportCoordinates[airplanes[i].chosenAirport].isEqual(infectedAirports[n])) {
             airplanes[i].isInfected = true;
             break;
           }
         }
     }
     
    //if it is infected create the virus at a random cell around the airport.
     if (airplanes[i].isInfected) {
       //The int(random(0,8)) is used by a constructor method of the Cell class to create a new cell around a chosen location.
       Cell newCell = new Cell(airplanes[i].xPos,airplanes[i].yPos, int(random(0,8)));
       Point newPoint = new Point(newCell.xPos, newCell.yPos);
       boolean isOnNewPoint = true;
       //Searches for taken coordinates, if the coordinates of the cell match with a taken coordinate nothing new is created.
        for (int n = 0; n < existingCellCoordinates.length; n ++) {
              if (newPoint.isEqual(existingCellCoordinates[n])){
                isOnNewPoint = false;
                break;
              }
        }
       //if it is a new point, the virus is created.
       if (isOnNewPoint) {
         life = (Cell[])append(life, newCell);
         existingCellCoordinates = (Point[])append(existingCellCoordinates, newPoint);
       }
     
     }
     //Chosing the next airport to travel too.
     int chosenAirport = round(random(0,numAirports-1));
     if (areAirportsOpen) {
       //if the same airport is chosen it finds a new airport.
        while (airplanes[i].chosenAirport == chosenAirport) {
        chosenAirport = round(random(0, numAirports-1));
       }
      //Updates the current airplane.
      airplanes[i].chosenAirport = chosenAirport;
      float distance = getDistance(airplanes[i].xPos, airplanes[i].yPos, airportCoordinates[chosenAirport].xPos, airportCoordinates[chosenAirport].yPos);
      //Using the distance and chosen speed to manually change the x and y speed of the airplane. Done by using vector concepts. Essentially, a direction vector is made from the
      //starting point to the chosen point and is made into a unit vector. From here, each component of that unit vector is multiplied by the desired speed. These new components are used
      //to update the planes position as it travels.
      airplanes[i].xSpeed = getSpeed(airplanes[i].xPos, airportCoordinates[chosenAirport].xPos, distance, speedAirplane);
      airplanes[i].ySpeed = getSpeed(airplanes[i].yPos, airportCoordinates[chosenAirport].yPos, distance, speedAirplane);
    
     //If the airports are closed, the airplane speed is set to zero so it cannot travel, and is made so it is not infected as to avoid infecting every cell around the airport by accident.
      if (!areAirportsOpen) {
        speedAirplane = 0;
        airplanes[i].isInfected = false;
        airplanes[i].xSpeed = getSpeed(airplanes[i].xPos, airportCoordinates[chosenAirport].xPos, distance, speedAirplane);
        airplanes[i].ySpeed = getSpeed(airplanes[i].yPos, airportCoordinates[chosenAirport].yPos, distance, speedAirplane);
       }
    
     }
    
   }
   
 }
  
}

//Function that getss distance between two points.
float getDistance(float xA, float yA, float xB, float yB) {
  float xDir = abs(xB-xA);
  float yDir = abs(yB-yA);
  float vectorMagnitude = sqrt(pow(xDir,2) + pow(yDir, 2));
  return vectorMagnitude;
}

//Function that gets a value for a specific component of a direction vector. Used to update airplanes.
float getSpeed(float coordA,float coordB,float directionMagnitude, float overallSpeed) {
  float output = overallSpeed*(coordB-coordA)/directionMagnitude;
  return output;
}




//The cell class.
class Cell {
  float xPos; //the x-coordinate.
  float yPos; //the y-coordinate.
  float[] shift = {-10,0,10}; //Gives a random coordinate shift from where a starting point is chosen.
  float[][] allCombosIndex = {{-10.0,-10.0},{-10.0,0.0},{-10.0,10.0},{0.0,-10.0},{0.0,10.0},{10.0,-10.0},{10.0,0.0},{10.0,10.0}}; //Every single possible location in which a cell can infect those around it.
  
  //Makes a cell with random coordinates that are a factor of 10.
  Cell() {
    int x = int(random(100,width-100));
    int y = int(random(100,height-100));
    this.xPos = -x%10 + x;
    this.yPos = -y%10 + y;
  }
  
  //Used to draw a cell when the user clicks on the screen, ensures the coordinates are a multiple of 10.
  Cell(float tempX, float tempY) {
    float x = -tempX%10 + tempX;
    float y = -tempY%10 + tempY;
    this.xPos = x;
    this.yPos = y;
  }
  
  //Used for infecting cells around a chosen cell, goes through all the possibilities with the "possibility" parameter.
  Cell (float tempX, float tempY, int possibilityIndex) {
    this.xPos = tempX + allCombosIndex[possibilityIndex][0];
    this.yPos = tempY + allCombosIndex[possibilityIndex][1];
  }
  
  //Function that draws an infected cell (Red square of side length 10).
  void create() {
    fill(201, 6, 6);
    square(xPos,yPos,10);
  }
  
  //Function that draws a dead cell (Black square of side length 10).
  void kill() {
    fill(0);
    square(xPos,yPos,10);
   }
   
  //Function that draws a cell that survived (White square of side length 10).
  void stable(){
    fill(255,140,0);
    square(xPos,yPos,10);
  }
     
  }
  
  
class Point {
  float xPos;
  float yPos;
  
  Point(float x, float y) {
    xPos = x;
    yPos = y;
  }
  
  boolean isEqual(Point otherPoint) {
    return (int(xPos) == int(otherPoint.xPos) && int(yPos) == int(otherPoint.yPos));
  }
  
}

class Airplane {
  float xPos; //The x-coordinate.
  float yPos; //The y-coordinate.
  float xSpeed; //Horizontal speed.
  float ySpeed; //Vertical speed.
  boolean isInfected; //True or false value whether the plane is infected or not.
  int chosenAirport; //Its chosen airport.
  
  color chosenColour = color(201, 6, 6); //The colour.
  
  //Constructor method giving an airplane its desired values.
  Airplane(float tempX, float tempY, int airportNum) {
    fill(chosenColour); 
    this.xPos = tempX;
    this.yPos = tempY;
    this.chosenAirport = airportNum;
    
    square(xPos,yPos,10);
  }
  
}
