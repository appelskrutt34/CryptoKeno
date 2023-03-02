const Keno = artifacts.require("Keno");

module.exports = function (deployer) {
  deployer.deploy(Keno);
};
