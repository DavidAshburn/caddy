import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "holePar",
    "holeScore",
    "holeNumber",
    "scorecardNumber",
    "cardHole",
    "shotIcons",
    "hiddenLength",
    "hiddenShots",
    "hiddenScore",
    "hiddenPars",
    "shotModal",
    "basketModal",
    "submitModal",
    "removeMe"
  ]

  connect() {
  	this.hole = 0;
  	this.length = this.hiddenLengthTarget.innerText;
  	this.scores = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    this.score = 0;
  	this.shots = []; //char array
  	this.parray = this.hiddenParsTarget.innerText.split(''); //char array of numbers
  	this.updateCard();
  }

  undoShot() {
    if(this.shots[0] != null) {
      if(this.shots.at(-1) == '0') {
        this.shots.pop();
      }
      if(this.shots.at(-1) == '5') {
        this.scores[this.hole]--;
      }
    	if(this.scores[this.hole] != 0) {
    	  this.scores[this.hole]--;
    	  this.shots.pop();
    	  this.updateCard();
      }
    }
  }

  addShot(val) {
  	this.scores[this.hole] += val;
  	this.updateCard();
  }

  lastHole() {
    if(this.hole != 0) {
    	this.hole--;
    	this.updateCard();
    }
  }
  nextHole() {
    if(this.hole < this.length - 1) {
  	  this.hole++;
      this.updateCard();
    }
    else
      this.openSubmitModal()
  }

  updateCard() {
    //update main counters
    this.holeScoreTarget.innerText = this.scores[this.hole];
    this.holeNumberTarget.innerText = this.hole + 1;

    //set score numbers
    for(let i = 0; i < this.length; i++){
      this.cardHoleTargets[i].innerText = this.scores[i];
    }

    //style score numbers for bogey, par, and birdie(skip 0s)
    //set innerText on card and sum this.score
    let scorecard = this.cardHoleTargets;
    this.score = 0;
    for(let i = 0; i < this.length; i++) {
      let hole = parseInt(this.scores[i]);
      
      if(hole > this.parray[i]) {
        scorecard[i].classList.toggle("text-amber-600", true);
        scorecard[i].classList.toggle("text-green-600", false);
        scorecard[i].classList.toggle("text-sky-600", false);
      } else if(hole == this.parray[i]) {
        scorecard[i].classList.toggle("text-amber-600", false);
        scorecard[i].classList.toggle("text-green-600", true);
        scorecard[i].classList.toggle("text-sky-600", false);
      } else if(hole != 0) {
        scorecard[i].classList.toggle("text-amber-600", false);
        scorecard[i].classList.toggle("text-green-600", false);
        scorecard[i].classList.toggle("text-sky-600", true);
      }

      //update scores on display
      scorecard[i].innerText = this.scores[i];

      //sum total score for form output
      this.score += this.scores[i];

      //highlight current hole on scorecard
      if(i == this.hole) {
        this.scorecardNumberTargets[i].classList.toggle("text-white", true);
        this.scorecardNumberTargets[i].classList.toggle("text-3xl", true);
        this.scorecardNumberTargets[i].classList.toggle("text-slate-700", false);
      }
      else {
        this.scorecardNumberTargets[i].classList.toggle("text-white", false);
        this.scorecardNumberTargets[i].classList.toggle("text-3xl", false);
        this.scorecardNumberTargets[i].classList.toggle("text-slate-700", true);
      }

    }
  }

  openBasketModal() {
    this.removeMeTargets.forEach(element => element.remove());

    let close_range = document.createElement("button");
    let mid_range = document.createElement("button");
    let long_range = document.createElement("button");
    let close_modal = document.createElement("button");

    let last_shot = this.shots.at(-1);
    let close = "";
    let mid = "";
    let long = "";

    switch(last_shot) {
      case '2':
        close = "33 - 44ft";
        mid = "44 - 55ft";
        long = "55 - 66ft";
        break;
      case '1':
        close = "0 - 11ft";
        mid = "11 - 22ft";
        long = "22 - 33ft";
        break;
      default:
        close = "66 - 80ft";
        mid = "80 - 100ft";
        long = "100ft+";
        break;
    }

    close_range.classList.add("btn-green");
    close_range.innerText = close;
    close_range.setAttribute("data-action", "scorecard#nearBasket");
    close_range.setAttribute("data-scorecard-target", "removeMe");

    mid_range.classList.add("btn-blue");
    mid_range.innerText = mid;
    mid_range.setAttribute("data-action", "scorecard#midBasket");
    mid_range.setAttribute("data-scorecard-target", "removeMe");

    long_range.classList.add("btn-yellow");
    long_range.innerText = long;
    long_range.setAttribute("data-action", "scorecard#longBasket");
    long_range.setAttribute("data-scorecard-target", "removeMe");

    close_modal.classList.add("btn-grey", "w-1/2");
    close_modal.innerText = "Close";
    close_modal.setAttribute("data-action", "scorecard#closeBasketModal");
    close_modal.setAttribute("data-scorecard-target", "removeMe");
  
    this.basketModalTarget.appendChild(close_range);
    this.basketModalTarget.appendChild(mid_range);
    this.basketModalTarget.appendChild(long_range);
    this.basketModalTarget.appendChild(close_modal);

    this.basketModalTarget.classList.toggle("hidden", false);
  }

  openShotModal() {
    this.shotModalTarget.classList.toggle("hidden", false);
  }

  closeShotModal() {
    this.shotModalTarget.classList.toggle("hidden", true);
  }

  closeBasketModal() {
    this.basketModalTarget.classList.toggle("hidden", true);
  }


  penaltyShot() {
    this.closeShotModal();
    this.shots.push('5')
    this.addShot(2);
  }

  fairwayShot() {
  	this.closeShotModal();
  	this.shots.push('4');
  	this.addShot(1);
  }

  offFairwayShot() {
  	this.closeShotModal();
  	this.shots.push('3');
  	this.addShot(1);
  }

  circleTwoShot() {
  	this.closeShotModal();
  	this.shots.push('2');
  	this.addShot(1);
  }

  circleOneShot() {
  	this.closeShotModal();
  	this.shots.push('1');
  	this.addShot(1);
  }

  nearBasket() {
  	this.shots.push('A');
  	this.shots.push('0');
  	this.addShot(1);
  	this.closeBasketModal();
  	this.nextHole();
  }

  midBasket() {
  	this.shots.push('B');
  	this.shots.push('0');
  	this.addShot(1);
  	this.closeBasketModal();
  	this.nextHole();
  }

  longBasket() {
  	this.shots.push('C');
  	this.shots.push('0');
  	this.addShot(1);
  	this.closeBasketModal();
  	this.nextHole();
  }
  
  openSubmitModal() {
    this.submitModalTarget.classList.toggle("hidden", false);
    this.hiddenShotsTarget.value = this.shots.join('');
    this.hiddenScoreTarget.value = this.score;
  }

  closeSubmitModal() {
    this.submitModalTarget.classList.toggle("hidden", true);
  }
}