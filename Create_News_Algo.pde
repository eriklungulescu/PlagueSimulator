void createNews() {
  //All article names that can be played.
  String[] averageNews = {"2020 summer olympics underway!", "CDC says flu season is relatively mild.", "Democratic primaries begin soon!", "Jeff Bezos donates millions to plant trees.", "SpaceX launch successful!", "Unemployment at an all time low."};
  String[] virusAnnouncementNews = {"Strange New Virus Emerges!", "New novel virus begins to Spread!", "New disease spotted in " + nationName};
  String[] concernedNews = {"CDC annunces new disease prevention guidelines.", "Death toll begins to rise, start of deadly plague?", "Growing concern over the spread of novel virus.", "Possibility of closing airports rises.", "CDC places novel " + diseaseName + " on watchlist."};
  String[] greatConcernNews = {"Head of CDC steps down!", "Pandemic striking fear and panic across nation.", nationName + " begins quarantining cities.", "WHO says " + diseaseName + " is unlike anything seen before."};
  String[] theEndIsNearNews = {"Anarchy ravages Erkelscu.", "Government falls apart after death of Prime Minister.", "Prevelant food shortages worldwide.", "Scientists say there is no hope.", diseaseName + " has spread all over the world.", "Whole cities wiped out by " + diseaseName+"."};
  String gameOver = "HUMANITY HAS LOST! The last humans are now succumbing to "+diseaseName + ".";
  int newsChoice;
 
  if (frameCounter % 90 == 0) {
    //If a vaccine is made news is updated.
    if (vaccineProgress == 100) {
      news = "HUMANITY HAS WON! A vaccine has been discovered.";
    }
    
    //Plays average news.
    else if (percentAffected < 0.005) {
      newsChoice = int(random(0,averageNews.length));
      news = "News: " + averageNews[newsChoice];
    }
    
    //Plays virus announcement news.
    else if (percentAffected >= 0.005 && percentAffected < 0.05) {
      newsChoice = int(random(0,virusAnnouncementNews.length));
      news = "News: " + virusAnnouncementNews[newsChoice];
    }
    
    //Plays concerned news.
    else if (percentAffected >= 0.05 && percentAffected < 0.3) {
      //Announces the creation of the vaccine.
      if (vaccineProgress > 0 && percentAffected < 0.23) {
        news = "Production of a Vaccine is underway.";
      }
      //Announces that airports are closed.
      else if (percentAffected >= 0.23 && percentAffected <= 0.27) {
        news = "AIRPORTS ARE NOW CLOSED, all flights must land!";
      }
      else {
        newsChoice = int(random(0,concernedNews.length));
        news = "News: " + concernedNews[newsChoice];
      }
    }
    
    //Plays great concern news.
    else if (percentAffected >= 0.3 && percentAffected < 0.8) {
      newsChoice = int(random(0,greatConcernNews.length));
      news = "News: " + greatConcernNews[newsChoice];
    }
    
    //Plays the end is near news.
    else if (percentAffected >= 0.8 && percentAffected < 1) {
      newsChoice = int(random(0,theEndIsNearNews.length));
 
      news = "News: " + theEndIsNearNews[newsChoice];
    }
    
    //Plays the news when the entire world has been infected
    else {
      news = "News: " + gameOver;
      
    }
   
  //List of mutations.
  String[] vaccineMutationsVirus = {diseaseName + " has mutated into a new strain.", diseaseName + " has undergone a genetic reshuffling.", "Important research on "+diseaseName +" has been lost in a fire.", "Prominent scientist has succumbed to " + diseaseName + "."};
  String[] infectibilityMutationsVirus = {diseaseName + " now causes coughing.", diseaseName + " now causes severe fevers.", diseaseName + " now causes sinus congestion and sore throat.", diseaseName + " now causes body aches and pains."};
  String[] deathRateMutationsVirus = {diseaseName + " symptoms now include pulmonary edema.", diseaseName + " symptoms now include liver failiure.", diseaseName + " symptoms now include internal hemorrhaging.", diseaseName + " symptoms now include comas.", diseaseName + " symptoms now include pneumonia.", diseaseName + " symptoms now include sensitivty to light and seizures.", diseaseName + " symptoms now include heart failiure.", diseaseName + " symptoms now include acute psychosis."};
  
  String[] vaccineMutationsNation = {"CDC discovers that " + diseaseName + " is airborne." , "Scientists find origin species for" + diseaseName + ".", "Researchers discover that " + diseaseName + " is an 'avian' flu.", diseaseName + " genome has been decoded by Scientists.", "Understanding of " + diseaseName + " has increased!", "Rodents are now known to be carriers for " + diseaseName + "."};
  String[] infectibilityMutationsNation = {"The sick are now isolated from the healthy.", "The dead are now burned to prevent the spread to healthy individuals.", "Sick people are jailed.", "Disinfecting of surfaces is now mandatory at all public locations.", "Erkelscu slaughters all livestock to prevent spread of disease", "All water supplies are now chemically treated.", "Those who are sick are now immediately quarantined.", "All citizens now wash their hands obessively.", "Bug nets have been installed to reduce spread from mosquitos" };
  String[] deathRateMutationsNation = {"New medicine reduces the severity of the symptoms of " + diseaseName+".", "Researchers have discovered methods to reduce the lethality of " + diseaseName+".", "New hospitals have been constructed."};
  
  //Chosing the type of mutation.
  int mutationChoice = int(random(0,3));
 
  //Creates a mutation .
  if (week%8 == 0 && vaccineProgress != 100 && percentAffected != 1 && hasVirusStarted) {
    //The nation gets a benefit.
    if (random(0,nationIntelligence) > random(0, virusAggresiveness)) {
      //If the choice affects vaccine progress.
      if (mutationChoice == 0) {
        //Increase the completion of the vaccine.
        vaccineProgress += round(random(5,10));
        if (vaccineProgress > 100) {
          vaccineProgress = 100;
        }        
        news = vaccineMutationsNation[int(random(0,vaccineMutationsNation.length))] + " Vaccine is now " + vaccineProgress + "% complete.";
      }
      //if the choice affects the infectability.
      else if (mutationChoice == 1 && infectability >= 6) {
        //Decrease's the infectability. (Lowest possible infectability is 1)
        infectability -= 5;
        news = infectibilityMutationsNation[int(random(0,infectibilityMutationsNation.length))] + " Infectibility is now " + infectability + "%.";
      }
      //if the choice affects the death rate. (Lowest possible death rate is 1)
      else if (deathRate >= 6) {
        //Decreases the death rate.
        deathRate -= 5;
        news = deathRateMutationsNation[int(random(0,deathRateMutationsNation.length))] + " Death Rate is now " + deathRate + "%.";
      }
    }
    //If the virus gets a benefit.
    else {
      ////if the choice affects the vaccine progress.
      if (mutationChoice == 0) {
         //Lowers the vaccine progress.
         vaccineProgress -= round(random(5,10));
        if (vaccineProgress < 0) {
          vaccineProgress = 0;
        }        
        news = vaccineMutationsVirus[int(random(0,vaccineMutationsVirus.length))] + " Vaccine completion is now " + vaccineProgress + "% complete.";
      }
      //if the choice affects the infectability.
      else if (mutationChoice == 1) {
        //Increases the infectability.
        infectability += 5;
        if (infectability > 100) {
         infectability = 100; 
        }
        news = infectibilityMutationsVirus[int(random(0,infectibilityMutationsVirus.length))] + " Infectibility is now " + infectability + "%.";
      }
      //if the choice affects the death rate.
      else {
        //Increases the death rate.
        deathRate += 5;
         if (deathRate > 100)
           deathRate = 100;
        news = deathRateMutationsVirus[int(random(0,deathRateMutationsVirus.length))] + " Death Rate is now " + deathRate + "%.";
      } 
      
    }
  }
  }
  
  String Week = "Week: " + str(week) + " #Infected: " + life.length + " #Dead: " + dead.length + " #Stable: " + alive.length + " Vaccine Progress: " + vaccineProgress + "%";
  
  fill(0);
  textFont(f);
  text(news, 10, height-60);
  if (vaccineProgress != 100) {
    fill(0);
    textFont(f);
    text(Week, 10, height-30);
  }
  
  else {
    fill(0);
    textFont(f);
    Week = "Week: " + str(week) + " #Population: " + (takenLandCoordinates.length - dead.length) + " Vaccine Progress: " + vaccineProgress + "%";
    text(Week, 10, height-30);
  }
}

//Counts weeks
void weekCounter() {
  if (frameCounter%90 == 0) {
    week ++;
  }
}
