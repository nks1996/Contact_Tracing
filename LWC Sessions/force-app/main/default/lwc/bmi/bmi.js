const getBMI = function (weightInKgs, heightInMts) {
  try {
    return weightInKgs / (heightInMts * heightInMts);
  } catch (error) {
    return undefined;
  }
};

export { getBMI };
