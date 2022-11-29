({
  doInit: function (component, event, helper) {
    //console.log("Initization complete");
    const gameMode = component.get("v.mode");
    let column = 0;
    if (gameMode && gameMode === "hard") {
      column = 6;
    } else if (gameMode === "medium") {
      column = 4;
    } else {
      column = 3;
    }
    let blockSize2 = 12 / column;
    component.set("v.blockSize2", blockSize2);
    const words = helper.getWords(column * column);
    component.set("v.words", words);
    console.log("The words list is here: " + words);

    //get Win Word
    const winWord = helper.getWinWord(words);
    component.set("v.winWord", winWord);
    console.log("The win word is: " + winWord);

    //reset the board
    helper.resetBoard(component);
  },
  doRender: function (component, event, helper) {
    //console.log("Rendering complete");
  },
  blockClickHandler: function (component, event, helper) {
    //getting current click count value
    let clickCountValue = component.get("v.clickCount") + 1;
    //get event value
    const value = event.getParam("value");

    if (value === component.get("v.winWord")) {
      //user has won
      component.set("v.result", "You WIN");
      console.log("You Win!");
      helper.disableBoard(component);
      helper.fireResultEvent("win");
    } else if (clickCountValue === 3) {
      component.set("v.result", "You LOSE");
      console.log("You Lose!");
      helper.disableBoard(component);
      helper.fireResultEvent("lose");
      //user has lost
    }
    //set click count
    component.set("v.clickCount", clickCountValue);
  },
  reshuffleBoard: function (component, event, helper) {
    const words = component.get("v.words");
    const randomizeWords = helper.randomizeArray(words);
    component.set("v.words", randomizeWords);
    helper.resetBoard(component);
  }
});
