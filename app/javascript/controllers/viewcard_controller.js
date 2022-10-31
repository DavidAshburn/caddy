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
    "overUnder"
  ]

  connect() {
    this.scores = [];
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

  //in: this.shots, char to look for
  //out: array of characters which immediately follow 'char'
  next_char(list, char) {
    if(char != '0') {
      let out = [];
      list.forEach((element,index,array) => {
        if(element == char) {
            out.push(array[index+1]);
        }
      });
      return out;
    }
    return 0;
  }

  acecheck(index) { //handle ace, recursive for repeats in PDGA play
    if(this.shots[index+2] == '0') {
      this.scores.push(1);
      index += 2;
      return this.acecheck(index);
    }
    else return index;
  }

  drive(array, match, target) { //percentages for different Drives substats, puts count(match)/length to target.innerText
    if(array) {
      target.innerText = `${((this.count(array, match)/parseFloat(this.length)) * 100).toFixed(0)}%`;
    }
    else
      target.innerText = "N/A";
  }

  drivingPercent() { // (length - (bad drives)) / length, drive() for substats
    let driveArray = this.shots.filter((shot, index, shots) => index == 0 || shots[index-1] == 0); //gets 1st and after baskets
    let drivePercent = (this.length - (this.count(driveArray, '5') + this.count(driveArray, '3'))) / this.length;
    this.fairwayPercentageTarget.innerText = `${(drivePercent * 100).toFixed(0)}%`;

    this.drive(driveArray, '5', this.fairwayPTarget);
    this.drive(driveArray, '4', this.fairway4Target);
    this.drive(driveArray, '3', this.fairwayOTarget);
    this.drive(driveArray, '2', this.fairway2Target);
    this.drive(driveArray, '1', this.fairway1Target);
  }

  circleOneXPercent() { // (made putts - tapins) / (all putts - tapins)
    let followups = this.next_char(this.shots,'1');
    if (followups) {
      let tapins = this.count(followups, 'A');
      let cOneB = this.count(followups, 'B');
      let cOneC = this.count(followups,'C');
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
    let followups = this.next_char(this.shots,'2');
    if (followups[0]) {
      let cTwoA = this.count(followups, 'A');
      let cTwoB = this.count(followups, 'B');
      let cTwoC = this.count(followups, 'C');
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
    let penalties = this.count(this.shots, '5');
    this.penaltyShotsTarget.innerText = penalties;
  }

  overUnder() {
    let par = parseInt(this.courseParTarget.innerText);
    let score = parseInt(this.cardScoreTarget.innerText);

    if(score > par) {
      this.overUnderTarget.innerText = `+${score - par}`;
      this.overUnderTarget.classList.add("text-yellow-600");
    } else if(score < par) {
      this.overUnderTarget.innerText = `-${par - score}`;
      this.overUnderTarget.classList.add("text-green-600");
    } else {
      this.overUnderTarget.innerText = '0';
      this.overUnderTarget.classList.add("text-sky-600");
    }

  }

  parseScores() { //fill hole scores based on this.shots
    let shot_counter = 0;
    for(let i = 0; i < this.shots.length; i++) {
      shot_counter++;
      
      switch(this.shots[i]) {
        case '0': //basket shot
          shot_counter--; //correction for putt codes before each 0
          this.scores.push(shot_counter);
          shot_counter = 0;
          
          //handle ace, recursive for repeats
          i = this.acecheck(i);

          break;
        case '5': //penalty shot
          shot_counter++;
          break;
        default:
          break;
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
        scorecard[i].classList.toggle("text-amber-600", true);
        scorecard[i].classList.toggle("text-green-600", false);
        scorecard[i].classList.toggle("text-sky-600", false);
      } else if(score == this.parray[i]) {
        scorecard[i].classList.toggle("text-amber-600", false);
        scorecard[i].classList.toggle("text-green-600", true);
        scorecard[i].classList.toggle("text-sky-600", false);
      } else if(score != 0) {
        scorecard[i].classList.toggle("text-amber-600", false);
        scorecard[i].classList.toggle("text-green-600", false);
        scorecard[i].classList.toggle("text-sky-600", true);
      }

      scorecard[i].innerText = this.scores[i]; 
    }

    //main Stats
    this.courseParTarget.innerText = this.parray.reduce((x,y) => parseInt(x) + parseInt(y));
    this.cardScoreTarget.innerText = this.scores.reduce((x,y) => parseInt(x) + parseInt(y));
  }

}