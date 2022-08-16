// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

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

    constructor(RWD _rwd, Tether _tether) {
        rwd = _rwd;
        tether = _tether;
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
        if (!hasStaked) {
            stakers.push[msg.sender];
        }

        // Update the staked status of the sender
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }
}