/* eslint-disable no-undef */
const Tether = artifacts.require("Tether");
const RWD = artifacts.require("RWD");
const DecentralBank = artifacts.require("DecentralBank");

module.exports = async function(deployer, network, accounts) {
  // Deploy Tether contract
  await deployer.deploy(Tether);
  const tether = await Tether.deployed();

  // Deploy Reward contract
  await deployer.deploy(RWD);
  const rwd = await RWD.deployed();

  // Deploy DecentralBank contract
  await deployer.deploy(DecentralBank);
  const decentralBank = await DecentralBank.deployed()

  // Transfer all RWD tokens to DecentralBank
  await rwd.transfer(DecentralBank.address, "1000000000000000000000000");

  // Distribute 100 Tether tokens to investors
  await tether.transfer(accounts[1], "100000000000000000000");
};
