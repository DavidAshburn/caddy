import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "cardHole",
    "hiddenPars",
    "hiddenShots",
    "hiddenLength",
    "fairwayPercentage",
    "fairwayO",
    "fairway1",
    "fairway2",
    "fairway4",
    "fairwayP",
    "cOneTap",
    "cOneMid",
    "cOneFar",
    "cOneMisses",
    "cTwoNear",
    "cTwoMid",
    "cTwoFar",
    "cTwoMisses",
    "cOneXPercentage",
    "cTwoPercentage",
    "penaltyShots",
    "coursePar",
    "cardScore",
    "overUnder",
    "testDisplay"
  ]

  connect() {
    this.scores = [];
    this.shotstring = this.hiddenShotsTarget.innerText
    this.shots = this.hiddenShotsTarget.innerText.split('');
    this.parray = this.hiddenParsTarget.innerText.split('');
    this.length = parseInt(this.hiddenLengthTarget.innerText);
    this.parseScores();
    this.updateCard();
    this.drivingPercent();
    this.circleOneXPercent();
    this.circleTwoPercent();
    this.penaltyShots();
    this.overUnder();

    this.driveArray = this.shots.filter((shot, index, shots) => index == 0 || shots[index-1] == 0);
  }

  count(array, variable) {
    let counter = 0;
    array.forEach(element => {
      if(element == variable)
        counter++;
    });
    return counter;
  }

  acecheck(index) { //handle ace, recursive call handles repeats
    if(this.shots[index+2] == '0') {
      this.scores.push(1);
      index += 2;
      return this.acecheck(index);
    }
    else return index;
  }

  drive_regex(shot) {
    return new RegExp(`^${shot}|0${shot}`, 'g')
  }

  drive(shot, target) { //percentages for different Drives substats, puts count(match)/length to target.innerText
    let matches = this.shotstring.match(this.drive_regex(shot))
    if (matches) {
      target.innerText = `${((matches.length / this.length)*100).toFixed(0)}%`;
    }
    else
      target.innerText = "N/A";
  }

  drivingPercent() { // (length - (bad drives)) / length, drive() for substats
    
    let gooddrives = this.shotstring.match(/^[0,1,2,4]|0[0,1,2,4]/g).length;
    this.fairwayPercentageTarget.innerText = `${((gooddrives / this.length)*100).toFixed(0)}%`;

    this.drive('5', this.fairwayPTarget);
    this.drive('4', this.fairway4Target);
    this.drive('3', this.fairwayOTarget);
    this.drive('2', this.fairway2Target);
    this.drive('1', this.fairway1Target);
  }

  circleOneXPercent() { // (made putts - tapins) / (all putts - tapins)
    this.testDisplayTarget.innerText = this.shotstring.match(/1./g);
    let followups = this.shotstring.match(/1./g);
    if (followups) {
      let tapins = this.count(followups, '1A');
      let cOneB = this.count(followups, '1B');
      let cOneC = this.count(followups,'1C');
      let cOnex = 0;
      let misses = followups.length - cOneC - cOneB - tapins;

      if (followups.length == tapins){
        cOnex = "N/A"
      } else {
        cOnex = (cOneB + cOneC) / (followups.length - tapins);
      }
      
      this.cOneXPercentageTarget.innerText = `${(cOnex * 100).toFixed(0) }%`;
      this.cOneTapTarget.innerText = tapins;
      this.cOneMidTarget.innerText = cOneB;
      this.cOneFarTarget.innerText = cOneC;
      this.cOneMissesTarget.innerText = misses;
    }
    else {
      this.cOneXPercentageTarget.innerText = "N/A";
      this.cOneTapTarget.innerText = "N/A";
      this.cOneMidTarget.innerText = "N/A";
      this.cOneFarTarget.innerText = "N/A";
      this.cOneMissesTarget.innerText = "N/A";
    }
  }

  circleTwoPercent() { // made putts from C2 / all putts from C2
    let followups = this.shotstring.match(/2./g);
    if (followups[0]) {
      let cTwoA = this.count(followups, '2A');
      let cTwoB = this.count(followups, '2B');
      let cTwoC = this.count(followups, '2C');
      let cTwo = cTwoA + cTwoB + cTwoC;

      let cTwoPerc = cTwo / parseFloat(this.count(this.shots, '2'));
      this.cTwoPercentageTarget.innerText = `${(cTwoPerc * 100).toFixed(0)}%`
      this.cTwoNearTarget.innerText = cTwoA;
      this.cTwoMidTarget.innerText = cTwoB;
      this.cTwoFarTarget.innerText = cTwoC;
      this.cTwoMissesTarget.innerText = followups.length - cTwo;
    } else {
      this.cTwoPercentageTarget.innerText = "N/A";
      this.cTwoNearTarget.innerText = "N/A";
      this.cTwoMidTarget.innerText = "N/A";
      this.cTwoFarTarget.innerText = "N/A";
      this.cTwomissesTarget.innerText = "N/A";
    }
  }

  penaltyShots() {
    this.penaltyShotsTarget.innerText = this.shotstring.match(/5/g).length;
  }

  overUnder() {
    let par = parseInt(this.courseParTarget.innerText);
    let score = parseInt(this.cardScoreTarget.innerText);

    if(score > par) {
      this.overUnderTarget.innerText = `+${score - par}`;
      this.overUnderTarget.classList.add("text-rose-400");
    } else if(score < par) {
      this.overUnderTarget.innerText = `-${par - score}`;
      this.overUnderTarget.classList.add("text-teal-400");
    } else {
      this.overUnderTarget.innerText = '0';
      this.overUnderTarget.classList.add("text-sky-400");
    }

  }

  parseScores() { //fill hole scores based on this.shots
    let shot_counter = 0;
    for(let i = 0; i < this.shots.length; i++) {
      shot_counter++;
      if(this.shots[i] == '0') {
        shot_counter--; //correction for putt codes
          this.scores.push(shot_counter);
          shot_counter = 0;
          
          //handle ace, recursive for repeats
          i = this.acecheck(i);
      }
      if(this.shots[i] == '5') {
        //penalty shot
        shot_counter++;
      }
    }
  }

  updateCard() {

    //set score numbers
    for(let i = 0; i < this.length; i++){
      this.cardHoleTargets[i].innerText = this.scores[i];
    }

    //style score numbers for bogey, par, and birdie(skip 0s)
    let scorecard = this.cardHoleTargets;
    for(let i = 0; i < this.length; i++) {
      let score = parseInt(scorecard[i].innerText);
      
      if(score > this.parray[i]) {
        scorecard[i].classList.toggle("text-rose-400", true);
        scorecard[i].classList.toggle("text-sky-400", false);
        scorecard[i].classList.toggle("text-teal-400", false);
      } else if(score == this.parray[i]) {
        scorecard[i].classList.toggle("text-rose-400", false);
        scorecard[i].classList.toggle("text-sky-400", true);
        scorecard[i].classList.toggle("text-teal-400", false);
      } else if(score != 0) {
        scorecard[i].classList.toggle("text-rose-400", false);
        scorecard[i].classList.toggle("text-sky-400", false);
        scorecard[i].classList.toggle("text-teal-400", true);
      }

      scorecard[i].innerText = this.scores[i]; 
    }

    //main Stats
    this.courseParTarget.innerText = this.parray.reduce((x,y) => parseInt(x) + parseInt(y));
    this.cardScoreTarget.innerText = this.scores.reduce((x,y) => parseInt(x) + parseInt(y));
  }

}