// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.5.0;

import "./RWD.sol";
import "./Tether.sol";

contract DecentralBank {
    string public name = "Decentral Bank";
    address public owner;
    Tether public tether;
    RWD public rwd;

    address[] public stakers;

    mapping (address => uint) public stakingBalance;
    mapping (address => bool) public hasStaked;
    mapping (address => bool) public isStaking;

    constructor(RWD _rwd, Tether _tether) public {
        rwd = _rwd;
        tether = _tether;
        owner = msg.sender;
    }

    // Staking function
    function depositTokens(uint _amount) public {
        // Require staking amount to be greater than 0
        require(_amount > 0, "Amount must be greater than 0");
        // Transfer Tether tokens to this contract address for staking
        tether.transferFrom(msg.sender, address(this), _amount);

        // Update the staking balance of the sender
        stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;

        // Check if the sender has staked before
        if (!hasStaked[msg.sender]) {
            stakers.push(msg.sender);
        }

        // Update the staked status of the sender
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }

    // Unstake tokens
    function unstakeTokens() public {
        uint balance = stakingBalance[msg.sender];
        // Require the amount to be greater than 0
        require(balance > 0, "Amount must be greater than 0");

        // Transfer Tether tokens to the specified contract address
        tether.transfer(msg.sender, balance);

        // Reset staking balance
        stakingBalance[msg.sender] = 0;

        // Update the staking status of the sender
        isStaking[msg.sender] = false;
    }

    // Issue reward tokens
    function issueTokens() public {
        // Require the owner to be the sender
        require(msg.sender == owner, "Only the owner can issue tokens");
        for (uint i = 0; i < stakers.length; i++) {
            address recipient = stakers[i];
            uint balance = stakingBalance[recipient] / 9; // Divide by 9 to create percentage incentive for staking
            if (balance > 0) {
                rwd.transfer(recipient, balance);
            }
        }
    }
}