const { jestConfig } = require("@salesforce/sfdx-lwc-jest/config");

module.exports = {
  ...jestConfig,
  moduleNameMapper: {
    "^thunder/hammerButton$":
      "<rootDir>/force-app/test/jest-mocks/thunder/hammerButton",
    "^lightning/button$": "/force-app/test/jest-mocks/lightning/button"
  },
  modulePathIgnorePatterns: ["/.localdevserver"]
};