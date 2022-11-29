({
  getWords: function (count) {
    if (count > 100) return;
    // if count < 100 then build array of words
    let wordsArray = [
      "expansion",
      "grandfather",
      "nappy",
      "oranges",
      "beds",
      "quack",
      "achiever",
      "yell",
      "hospital",
      "winter",
      "understood",
      "squalid",
      "merciful",
      "reaction",
      "wipe",
      "fearless",
      "tiresome",
      "introduce",
      "planes",
      "drum",
      "muddle",
      "capable",
      "canvas",
      "route",
      "enchanted",
      "quirky",
      "switch",
      "apparatus",
      "loss",
      "agreement",
      "substance",
      "back",
      "oafish",
      "expand",
      "aromatic",
      "quarrelsome",
      "free",
      "useful",
      "raspy",
      "drown",
      "ring",
      "lush",
      "numberless",
      "embarrass",
      "shrill",
      "rice",
      "ice",
      "crow",
      "pumped",
      "sparkle",
      "instruct",
      "girl",
      "glass",
      "frog",
      "murky",
      "impolite",
      "crabby",
      "pin",
      "grade",
      "upbeat",
      "linen",
      "flaky",
      "side",
      "unknown",
      "cactus",
      "round",
      "busy",
      "grab",
      "crush",
      "faithful",
      "mother",
      "clean",
      "unhealthy",
      "event",
      "absent",
      "thoughtless",
      "icy",
      "prefer",
      "charge",
      "confuse",
      "clam",
      "dress",
      "snake",
      "evasive",
      "unit",
      "flow",
      "annoying",
      "gusty",
      "possessive",
      "rhetorical",
      "rule",
      "frantic",
      "farm",
      "poor",
      "possess",
      "men",
      "pleasant",
      "zoom",
      "sidewalk",
      "reply"
    ];
    // randomize array
    wordsArray = this.randomizeArray(wordsArray);
    // to return only a certain count of words from the list of 100 words use the slice function

    //to add open property to words we're converting this words array into an object array with 2 properties the word itself and open proerty= false
    const wordObjArray = wordsArray.map((element) => {
      // word and open are porperties of the wordsObjArray object
      return { word: element, open: false };
    });
    return wordObjArray.slice(0, count);
  },

  randomizeArray: function (arr) {
    const randomArr = arr;
    // Randomize the array
    for (let i = randomArr.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * i);
      const temp = randomArr[i];
      randomArr[i] = randomArr[j];
      randomArr[j] = temp;
    }
    return randomArr;
  },

  getWinWord: function (arr) {
    const randomIndex = Math.floor(Math.random() * arr.length);
    return arr[randomIndex].word;
  },

  disableBoard: function (component) {
    component.set("v.boardDisabled", true);
  },

  enableBoard: function (component) {
    component.set("v.boardDisabled", false);
  },

  resetBoard: function (component) {
    this.enableBoard(component);
    //reset moves left counter
    component.set("v.clickCount", 0);
    // reset result
    component.set("v.result", "");
  },

  fireResultEvent: function (resultValue) {
    const appevent = $A.get("e.c:ResultApplicationEvent");
    appevent.setParams({ result: resultValue });
    appevent.fire();
  }
});
