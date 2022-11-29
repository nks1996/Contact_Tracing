({
  addResultRecord: function (component, gameResult) {
    // create apex method call action
    // below 'c' refers to Apex Controller
    const action = component.get("c.addResult");
    const modeValue = component.get("v.selectedValueOfComboBox").toUpperCase();
    //set parameters
    action.setParams({
      result: gameResult.toUpperCase(),
      mode: modeValue
    });
    //define a callback
    action.setCallback(this, function (response) {
      const state = response.getState();
      if (state !== "SUCCESS") {
        console.error("Error in saving record");
      }
    });
    //call apex method now
    $A.enqueueAction(action);
  },
  showToast: function (titleValue, messageValue, typeValue) {
    var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
      title: titleValue,
      message: messageValue,
      type: typeValue
    });
    toastEvent.fire();
  }
});