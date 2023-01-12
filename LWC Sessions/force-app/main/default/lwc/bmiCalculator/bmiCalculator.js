import { LightningElement, track } from "lwc";
import { getBMI } from "c/bmi";

export default class BmiCalculator extends LightningElement {
  titleWording = "BMI Calculator";

  weight;

  height;

  @track bmi;

  onWeightChange(event) {
    this.weight = parseFloat(event.target.value);
  }

  onHeightChange(event) {
    this.height = parseFloat(event.target.value);
  }

  calculateBMI() {
    this.bmi = getBMI(this.weight, this.height);
  }

  get bmiValue() {
    return `Your BMI is: ${this.bmi}`;
    if (bmi === undefined) {
      return "";
    }
  }
}
