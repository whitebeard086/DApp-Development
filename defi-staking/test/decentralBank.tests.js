/* eslint-disable no-undef */
const Tether = artifacts.require("Tether");
const RWD = artifacts.require("RWD");
const DecentralBank = artifacts.require("DecentralBank");

require("chai")
  .use(require("chai-as-promised"))
  .should();

contract("DecentralBank", ([owner, customer]) => {
  let tether, rwd;

  function tokens(number) {
    return web3.utils.toWei(number, "ether");
  }

  before(async () => {
    // Load Contracts
    tether = await Tether.new();
    rwd = await RWD.new();
    decentralBank = await DecentralBank.new(rwd.address, tether.address);

    // Transfer all tokens to DecentralBank (1 million)
    await rwd.transfer(decentralBank.address, tokens("1000000"));

    // Transfer 100 mock Tethers to customer
    await tether.transfer(customer, tokens("100"), { from: owner });
  });

  describe("Mock Tether Deployment", async () => {
    it("matches name successfully", async () => {
      const name = await tether.name();
      assert.equal(name, "Mock Tether Token");
    });
  });

  describe("Reward Token Deployment", async () => {
    it("matches name successfully", async () => {
      const name = await rwd.name();
      assert.equal(name, "Reward Token");
    });
  });

  describe("Decentral Bank Deployment", async () => {
    it("matches name successfully", async () => {
      const name = await decentralBank.name();
      assert.equal(name, "Decentral Bank");
    });

    it("contract has tokens", async () => {
      let balance = await rwd.balanceOf(decentralBank.address);
      assert.equal(balance, tokens("1000000"));
    });
  });

  describe("Yield Farming", async () => {
    it("rewards token for staking", async () => {
      let result;

      // Check customer's balance before staking
      result = await tether.balanceOf(customer);
      assert.equal(result.toString(), tokens("100"));

      // Check Staking function for 100 token
      await tether.approve(decentralBank.address, tokens("100"), {
        from: customer,
      });
      await decentralBank.depositTokens(tokens("100"), { from: customer });

      // Check customer's balance after staking
      result = await tether.balanceOf(customer);
      assert.equal(result.toString(), tokens("0"));

      // Check DecentralBank's balance after staking
      result = await tether.balanceOf(decentralBank.address);
      assert.equal(result.toString(), tokens("100"));

      // Is Staking status
      result = await decentralBank.isStaking(customer);
      assert.equal(result, true);

      // Issue reward tokens to customer
      await decentralBank.issueTokens({ from: owner });

      // Ensure only owner can issue tokens
      await decentralBank.issueTokens({ from: customer }).should.be.rejected;

      // Unstake tokens
      await decentralBank.unstakeTokens({ from: customer });

      // Check customer's balance after unstaking
      result = await tether.balanceOf(customer);
      assert.equal(result.toString(), tokens("100"));

      // Check DecentralBank's balance after unstaking
      result = await tether.balanceOf(decentralBank.address);
      assert.equal(result.toString(), tokens("0"));

      // Is Staking status
      result = await decentralBank.isStaking(customer);
      assert.equal(result, false);
    });
  });
});
