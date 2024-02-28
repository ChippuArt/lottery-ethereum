const Lottery = artifacts.require("Lottery");

module.exports = function(deployer, network, accounts){
  console.log(network, accounts)
  deployer.deploy(Lottery);
}