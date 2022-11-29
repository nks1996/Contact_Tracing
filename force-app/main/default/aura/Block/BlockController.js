({
  blockClickHandler: function (component, event, helper) {
    const openFlagValue = component.get("v.open");
    if (!openFlagValue) {
      component.set("v.open", true);
      //get value of label
      const labelValue = component.get("v.label");
      //fire the BlockClickEvent
      let compEvent = component.getEvent("onclick");
      compEvent.setParams({ value: labelValue });
      compEvent.fire();
    }
  },

  scriptsLoaded: function (component, event, helper) {
    const divElement = component.getElement(".board-block");
    fitText(divElement);
  }
});
