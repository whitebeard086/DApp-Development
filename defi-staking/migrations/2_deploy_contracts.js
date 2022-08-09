/* eslint-disable no-undef */
const Tether = artifacts.require("Tether");
const RWD = artifacts.require("RWD");
const DecentralBank = artifacts.require("DecentralBank");

module.exports = async function(deployer) {
  // Deploy Tether contract
  await deployer.deploy(Tether);

  // Deploy Reward contract
  await deployer.deploy(RWD);

  // Deploy DecentralBank contract
  await deployer.deploy(DecentralBank);
};
