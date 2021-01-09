void createAirplane() {
  //Creates airplanes.
  for (int i = 0; i < numAirplanes; i ++) {
    //Chooses a random airport to travel too.
    int chosenAirport = round(random(0, numAirports-1));
    //Starts airplanes at different airports. Creates airplane using the Airplane class constructor method.
    Airplane newAirplane = new Airplane(airportCoordinates[i%numAirports].xPos, airportCoordinates[i%numAirports].yPos, chosenAirport);

    //Assigns the airplane its important data.
    float direction = getDistance(newAirplane.xPos, newAirplane.yPos, airportCoordinates[chosenAirport].xPos, airportCoordinates[chosenAirport].yPos);
    newAirplane.xSpeed = getSpeed(newAirplane.xPos, airportCoordinates[chosenAirport].xPos, direction, speedAirplane);
    newAirplane.ySpeed = getSpeed(newAirplane.yPos, airportCoordinates[chosenAirport].yPos, direction, speedAirplane);
    airplanes = (Airplane[])append(airplanes, newAirplane);
  }
}
