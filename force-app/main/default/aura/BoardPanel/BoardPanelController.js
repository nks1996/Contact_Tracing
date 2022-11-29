({
  startGame: function (component, event, helper) {
    //access comboBox
    let comboBoxVariable = component.find("gameMode");
    //access value attribute of ComboBox
    let selectedValue = comboBoxVariable.get("v.value");

    //setting value of the comboBox in an attribute called 'selectedValueOfComboBox' on the component File
    component.set("v.selectedValueOfComboBox", selectedValue);

    const selectedMode = component.get("v.selectedValueOfComboBox");
    //same as if(selectedMode != null)
    if (selectedMode) {
      const boardComp = component.find("boardComp");
      boardComp.startGame();
    }

    // logging Value of selectedValue JS variable
    //console.log("The selected Value of the comboBox is: " + selectedValue);

    //console.log(
    //"The selectedValueOfComboBox Attribute Value is: " +
    //component.get("v.selectedValueOfComboBox")
    // );
  },
  reshuffleBoard: function (component, event, helper) {
    const boardComp = component.find("boardComp");
    boardComp.reshuffleBoard();
    component.set("v.reshuffleDisabled", true);
  },

  onResultHandler: function (component, event, helper) {
    const result = event.getParam("result");
    if (result === "win") {
      component.set("v.reshuffleDisabled", true);
      helper.showToast("You WON!", "Yayyyyy Awesome :)", "success");
    } else {
      component.set("v.reshuffleDisabled", false);
      helper.showToast(
        "You Lost",
        "No worries, Wanna try again? Hit Reshuffle button",
        "error"
      );
    }
    helper.addResultRecord(component, result);
  }
});
