import SystemModstamp from "@salesforce/schema/Account.SystemModstamp";
import { LightningElement, track } from "lwc";

export default class ConditionalRenderingExample extends LightningElement {
  @track displayDiv = false;

  @track cityList = ["Jaipur", "Hilo", "Hyd", "Torreon", "FoCo"];

  showDivHandler(event) {
    this.displayDiv = event.target.checked;
    //console.log(displayDiv);
  }
}
